import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ingrade_io/Utils/customText.dart';
import 'package:ingrade_io/appcolors/appcolors.dart';
import 'package:ingrade_io/screens/Auth%20Screens/LogIn_Screen.dart';

import '../../Controller/Auth Controller.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _emailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primary.withOpacity(0.4),AppColors.secondary, ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.sp,vertical: 5.sp),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: AppColors.secondary),
                        onPressed: () => Get.back(),
                      ),
                      CustomText(text: "Reset Password",fontSize: 24.sp,)

                    ],
                  ),
                  SizedBox(height: 35.sp),

                  // Icon
                  Container(
                    width: 100.sp,
                    height: 100.sp,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _emailSent ? Icons.mark_email_read : Icons.lock_reset,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 32.sp),

                  // Title
                  Text(
                    _emailSent ? 'Check Your Email' : 'Forgot Password?',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16.sp),

                  // Description
                  Text(
                    _emailSent
                        ? 'We\'ve sent password reset instructions to your email address.'
                        : 'Don\'t worry! Enter your email address and we\'ll send you instructions to reset your password.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 40.sp),

                  if (!_emailSent) ...[
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: AppColors.primary),
                        hintText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email,color: AppColors.secondary,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary,width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary,width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!authController.isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 32.sp),

                    // Send Reset Email Button
                    Obx(() => ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () => _sendResetEmail(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor:AppColors.secondary,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: authController.isLoading.value
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Sending...'),
                        ],
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, size: 20.sp),
                          SizedBox(width: 8.sp),
                          Text(
                            'Send Reset Instructions',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),

                    SizedBox(height: 24.sp),

                    // Help Text
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.primary, size: 20.sp),
                          SizedBox(height: 8.sp),
                          Text(
                            'Make sure to check your spam folder if you don\'t see the email in your inbox.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Success State
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green[200]!),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                            size: 48.sp,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Email Sent Successfully!',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                          SizedBox(height: 8.sp),
                          Text(
                            'Password reset instructions have been sent to:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              emailController.text,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32),

                    // Instructions
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb_outline, color: Colors.orange[600], size: 20),
                              SizedBox(width: 8),
                              Text(
                                'What to do next:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            '1. Check your email inbox (and spam folder)\n'
                                '2. Click the reset link in the email\n'
                                '3. Create a new password\n'
                                '4. Return to the app and sign in',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Resend Button
                    OutlinedButton.icon(
                      onPressed: () => _resendEmail(),
                      icon: Icon(Icons.refresh, size: 18),
                      label: Text('Resend Email'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ],

                  SizedBox(height: 32),

                  // Back to Login
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        children: [
                          TextSpan(text:  "Already have an account? ",style: TextStyle(fontSize: 16.sp)),
                          TextSpan(
                            text: 'Sign In',
                            style:  TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Action on tap (e.g., navigate to Sign Up screen)
                                 Get.offAll(() => LoginScreen());
                              },
                          ),
                        ],
                      ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendResetEmail() async {
    if (formKey.currentState!.validate()) {
      print('Form is valid, attempting to send reset email...');

      bool success = await authController.resetPassword(emailController.text.trim());

      if (success) {
        print('Reset email sent successfully');
        setState(() {
          _emailSent = true;
        });

        // Show success message
        Get.snackbar(
          'Email Sent',
          'Password reset instructions have been sent to your email.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        print('Failed to send reset email');
        // Error message is already shown by the controller
      }
    } else {
      print('Form validation failed');
    }
  }

  void _resendEmail() async {
    print('Attempting to resend email...');

    bool success = await authController.resetPassword(emailController.text.trim());

    if (success) {
      Get.snackbar(
        'Email Resent',
        'Password reset instructions have been sent again.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
    // Error handling is done in the AuthController
  }

  void _showHelpDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: Colors.blue),
            SizedBox(width: 8),
            Text('Need Help?'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If you\'re having trouble resetting your password:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            Text(
              '• Make sure you\'re using the correct email address\n'
                  '• Check your spam/junk folder\n'
                  '• Wait a few minutes for the email to arrive\n'
                  '• Try using a different email if you have multiple accounts',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              'Still having issues? Contact our support team.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Here you could open email app or contact support
              Get.snackbar(
                'Contact Support',
                'Please email us at support@yourapp.com',
                backgroundColor: Colors.blue,
                colorText: Colors.white,
                duration: Duration(seconds: 4),
              );
            },
            child: Text('Contact Support'),
          ),
        ],
      ),
    );
  }
}
