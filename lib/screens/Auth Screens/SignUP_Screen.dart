import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/Auth Controller.dart';
import '../../appcolors/appcolors.dart';
import 'LogIn_Screen.dart';

 // Dark Green

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;
  bool _isPasswordVisible = false; // State for password visibility
  bool _isConfirmPasswordVisible = false; // State for confirm password visibility

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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "in",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold,color: AppColors.secondary),),
                            WidgetSpan(child: SizedBox(width: 5,)),
                            TextSpan(
                              text: "Grade",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primary),
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 50,),
                    Text(
                      "Create an Account",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.normal,color: Colors.white),

                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(
                          color:AppColors.secondary, // Change text color
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500// Optional: Change font size
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        prefixIcon:  Icon(Icons.person, color: AppColors.secondary),
                        hintText: 'NAME',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(
                          color:AppColors.secondary, // Change text color
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500// Optional: Change font size
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        prefixIcon:  Icon(Icons.email, color: AppColors.secondary),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!authController.isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      style: TextStyle(
                          color:AppColors.secondary, // Change text color
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500// Optional: Change font size
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        prefixIcon:  Icon(Icons.lock,color:  AppColors.secondary),
                        suffixIcon: IconButton( // Add suffix icon
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.secondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color:AppColors.secondary, width: 1.2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                          return 'Password must contain both letters and numbers';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      style: TextStyle(
                          color:AppColors.secondary, // Change text color
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500// Optional: Change font size
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        prefixIcon:  Icon(Icons.lock,color:  AppColors.secondary),
                        suffixIcon: IconButton( // Add suffix icon
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.secondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color:AppColors.secondary, width: 1.2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),


                    // Terms and Conditions
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primary,
                          checkColor: AppColors.secondary,
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                              children: [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.secondary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Action on tap (e.g., navigate to Sign Up screen)
                                      Get.to(() => LoginScreen());
                                    },
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.secondary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Action on tap (e.g., navigate to Sign Up screen)
                                      Get.to(() => LoginScreen());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Obx(()=>ElevatedButton(
                      onPressed: authController.isLoading.value || !_agreeToTerms
                          ? null
                          : () {
                        if (formKey.currentState!.validate()) {
                          authController.signUpWithEmailAndPassword(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text,
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: authController.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                          :Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    )),
                   SizedBox(height: 50.h),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                          children: [
                                             TextSpan(text:  "Already have an account? ",style: TextStyle(fontSize: 16.sp)),
                                            TextSpan(
                                              text: "Login",
                                              style:  TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: AppColors.secondary),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Action on tap (e.g., navigate to Sign Up screen)
                                                  Get.to(() => LoginScreen());
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
      ),
    );
  }
}





