import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ingrade_io/screens/Auth%20Screens/LogIn_Screen.dart';
import 'dart:async';

import 'package:ingrade_io/screens/Home%20Screen/homescreens.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../screens/Auth Screens/email_verification_page.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxBool isSendingVerification = false.obs;
  RxString errorMessage = ''.obs;

  // Email verification timer
  Timer? _emailVerificationTimer;
  RxInt resendCooldown = 0.obs;

  // Track verification status
  RxBool isEmailVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    ever(user, _goToScreen);

    // Also listen to user changes (includes email verification changes)
    _auth.userChanges().listen((User? user) {
      if (user != null) {
        isEmailVerified.value = user.emailVerified;
        if (user.emailVerified && Get.currentRoute == '/EmailVerificationPage') {
          // Force navigation if we're on verification page and email is verified
          Get.offAll(() => HomeScreen());
        }
      }
    });
  }

  @override
  void onClose() {
    _emailVerificationTimer?.cancel();
    super.onClose();
  }

  void _goToScreen(User? firebaseUser) {
    if (firebaseUser == null) {
      Get.offAll(() => LoginScreen());
    } else {
      // Check if email is verified
      isEmailVerified.value = firebaseUser.emailVerified;
      if (firebaseUser.emailVerified) {
        Get.offAll(() => HomeScreen());
      } else {
        // If user exists but email not verified, go to verification page
        Get.offAll(() => EmailVerificationPage());
      }
    }
  }

  User? get currentUser => _auth.currentUser;

  // Simple email validation
  bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  // Sign up with email verification
  Future<void> signUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Validate name
      if (name.trim().length < 2) {
        throw Exception('Name must be at least 2 characters long');
      }

      // Validate email
      if (!isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      // Validate password
      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters long');
      }

      // Create user account
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name.trim());

      // Send email verification immediately
      await sendEmailVerification();

      Get.snackbar(
        'Account Created',
        'Please check your email to verify your account.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      // Navigation will be handled by _goToScreen listener
      // User will be redirected to EmailVerificationPage

    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      isSendingVerification.value = true;

      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        // Start cooldown timer
        _startResendCooldown();

        Get.snackbar(
          'Verification Email Sent',
          'Please check your email and spam folder. Click the verification link to continue.',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Too Many Requests',
          'Please wait before requesting another verification email.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send verification email. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send verification email. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isSendingVerification.value = false;
    }
  }

  // Start resend cooldown timer
  void _startResendCooldown() {
    resendCooldown.value = 60; // 60 seconds cooldown
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCooldown.value > 0) {
        resendCooldown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // Check if email is verified - IMPROVED VERSION
  Future<void> checkEmailVerification() async {
    try {
      print('Checking email verification...');

      // Force reload the current user from Firebase
      await _auth.currentUser?.reload();

      // Get the fresh user data
      final freshUser = _auth.currentUser;

      print('User email verified: ${freshUser?.emailVerified}');

      if (freshUser != null && freshUser.emailVerified) {
        _emailVerificationTimer?.cancel();

        // Update our reactive variables
        isEmailVerified.value = true;
        user.value = freshUser;

        Get.snackbar(
          'Email Verified!',
          'Your email has been verified successfully! Redirecting to home...',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );

        // Navigate to home page
        await Future.delayed(Duration(milliseconds: 800));
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar(
          'Not Verified Yet',
          'Please check your email and click the verification link. Check your spam folder if needed.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Error checking email verification: $e');
      Get.snackbar(
        'Error',
        'Failed to check verification status. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  // Start periodic email verification check - IMPROVED VERSION
  void startEmailVerificationCheck() {
    print('Starting email verification check...');
    _emailVerificationTimer?.cancel();

    _emailVerificationTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      try {
        print('Periodic check - reloading user...');

        // Force reload the current user from Firebase
        await _auth.currentUser?.reload();
        final freshUser = _auth.currentUser;

        print('Periodic check - User verified: ${freshUser?.emailVerified}');

        if (freshUser != null && freshUser.emailVerified) {
          timer.cancel();

          // Update our reactive variables
          isEmailVerified.value = true;
          user.value = freshUser;

          print('Email verified! Navigating to home...');

          Get.snackbar(
            'Email Verified!',
            'Your email has been verified successfully! Welcome!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );

          // Navigate to home page
          await Future.delayed(Duration(milliseconds: 800));
          Get.offAll(() => HomeScreen());
        }
      } catch (e) {
        print('Error in periodic verification check: $e');
      }

      // Stop checking if user is null (signed out)
      if (_auth.currentUser == null) {
        print('User is null, stopping verification check');
        timer.cancel();
      }
    });
  }

  // Stop email verification check
  void stopEmailVerificationCheck() {
    print('Stopping email verification check...');
    _emailVerificationTimer?.cancel();
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Basic email format validation for login
      if (!isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      if (password.isEmpty) {
        throw Exception('Please enter your password');
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // Check if email is verified
      if (!userCredential.user!.emailVerified) {
        Get.snackbar(
          'Email Not Verified',
          'Please verify your email address to continue.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        // Navigation will be handled by _goToScreen listener to EmailVerificationPage
        return;
      }

      Get.snackbar(
        'Success',
        'Logged in successfully! Welcome back.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

// Google SignIn Method
  Future<User?>SingInWithGoole()async{
    isLoading.value = true;
    errorMessage.value = '';
    try{
      await googleSignIn.initialize(
          serverClientId:"592839572708-elin3rc6ia1k40kmvkf6gvq3en9l4gr5.apps.googleusercontent.com"
      );
      final acount = await googleSignIn.authenticate();
      if(acount==null){
        errorMessage.value="SignIn canceled by user";
        Get.snackbar("Cancelled", errorMessage.value,
            backgroundColor: Colors.orange, colorText: Colors.white);
        isLoading.value = false;
        return null;
      }
      final auth = acount.authentication;
      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      await _auth.signInWithCredential(credential);

      Get.snackbar("Success", "Logged in with Google successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);



    }on GoogleSignInException catch(e){
      if (e.code == GoogleSignInExceptionCode.canceled) {
        errorMessage.value = "Sign-in cancelled by user.";
      } else {
        errorMessage.value = "Error (${e.code}): ${e.description}";
      }
      Get.snackbar("Error", errorMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }on FirebaseAuthException catch (e) {
      _handleAuthException(e);

    } catch (e) {
      errorMessage.value = "Unknown error: $e";
      Get.snackbar("Error", errorMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);

    }finally {
      isLoading.value = false;
    }
    return null;

  }

  // Reset password - FIXED VERSION
  Future<bool> resetPassword(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('Attempting to send password reset email to: $email');

      if (!isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      // Send password reset email with basic settings
      await _auth.sendPasswordResetEmail(
        email: email.trim().toLowerCase(),
      );

      print('Password reset email sent successfully');
      return true;

    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');

      switch (e.code) {
        case 'user-not-found':
          errorMessage.value = 'No account found with this email address. Please check your email or create a new account.';
          break;
        case 'invalid-email':
          errorMessage.value = 'The email address format is invalid. Please enter a valid email.';
          break;
        case 'too-many-requests':
          errorMessage.value = 'Too many password reset requests. Please wait before trying again.';
          break;
        case 'network-request-failed':
          errorMessage.value = 'Network error. Please check your internet connection and try again.';
          break;
        default:
          errorMessage.value = e.message ?? 'Failed to send password reset email. Please try again.';
      }

      Get.snackbar(
        'Password Reset Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      return false;

    } catch (e) {
      print('General exception: $e');
      errorMessage.value = 'An unexpected error occurred. Please try again.';

      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      return false;

    } finally {
      isLoading.value = false;
    }
  }



  // Sign in with Apple
  Future<void> signInWithApple() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Check if Apple Sign In is available
      if (!await SignInWithApple.isAvailable()) {
        throw Exception('Apple Sign In is not available on this device');
      }

      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.example.ingradeIo', // Replace with your actual bundle ID
          redirectUri: Uri.parse('https://ingradelms-ef9d4.firebaseapp.com/__/auth/handler'), // Replace with your Firebase project
        ),
      );

      // Create OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with Apple credential
      UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);

      // Update display name if available from Apple
      if (appleCredential.givenName != null || appleCredential.familyName != null) {
        String displayName = '';
        if (appleCredential.givenName != null) {
          displayName += appleCredential.givenName!;
        }
        if (appleCredential.familyName != null) {
          if (displayName.isNotEmpty) displayName += ' ';
          displayName += appleCredential.familyName!;
        }

        if (displayName.isNotEmpty) {
          await userCredential.user?.updateDisplayName(displayName);
        }
      }

      Get.snackbar(
        'Success',
        'Logged in with Apple successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
        // User canceled the sign-in flow
          errorMessage.value = 'Apple Sign In was canceled';
          break;
        case AuthorizationErrorCode.failed:
          errorMessage.value = 'Apple Sign In failed. Please try again.';
          break;
        case AuthorizationErrorCode.invalidResponse:
          errorMessage.value = 'Invalid response from Apple Sign In';
          break;
        case AuthorizationErrorCode.notHandled:
          errorMessage.value = 'Apple Sign In request was not handled';
          break;
        case AuthorizationErrorCode.unknown:
          errorMessage.value = 'Unknown error occurred with Apple Sign In';
          break;
        default:
          errorMessage.value = 'Apple Sign In failed: ${e.message}';
      }

      if (e.code != AuthorizationErrorCode.canceled) {
        Get.snackbar(
          'Apple Sign In Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      errorMessage.value = 'Apple Sign In failed. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      stopEmailVerificationCheck(); // Stop any ongoing verification checks
      await _auth.signOut();
      await googleSignIn.disconnect();
      try {
      } catch (googleSignOutError) {
        print('Google sign out error: $googleSignOutError');
      }

      // Reset verification status
      isEmailVerified.value = false;

      Get.snackbar(
        'Signed Out',
        'You have been signed out successfully.',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred during sign out: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        errorMessage.value = 'Password is too weak. Please use at least 6 characters with a mix of letters and numbers.';
        break;
      case 'email-already-in-use':
        errorMessage.value = 'An account already exists with this email address. Please try signing in instead.';
        break;
      case 'user-not-found':
        errorMessage.value = 'No account found with this email address. Please check your email or sign up.';
        break;
      case 'wrong-password':
        errorMessage.value = 'Incorrect password. Please try again or reset your password.';
        break;
      case 'invalid-email':
        errorMessage.value = 'The email address format is invalid. Please enter a valid email.';
        break;
      case 'user-disabled':
        errorMessage.value = 'This account has been disabled. Please contact support.';
        break;
      case 'too-many-requests':
        errorMessage.value = 'Too many failed attempts. Please try again later.';
        break;
      case 'operation-not-allowed':
        errorMessage.value = 'This sign-in method is not enabled. Please contact support.';
        break;
      case 'invalid-credential':
        errorMessage.value = 'The provided credentials are invalid. Please check your email and password.';
        break;
      case 'network-request-failed':
        errorMessage.value = 'Network error. Please check your internet connection and try again.';
        break;
      default:
        errorMessage.value = e.message ?? 'An unexpected error occurred. Please try again.';
    }

    Get.snackbar(
      'Authentication Error',
      errorMessage.value,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }
}
