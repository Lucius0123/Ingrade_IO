// signup_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool _agreeToTerms = false;
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
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: false,
                      prefixIcon:  Icon(Icons.person_outline, color: AppColors.secondary),
                      hintText: 'NAME',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 1.2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: false,
                      prefixIcon:  Icon(Icons.person_outline, color: AppColors.secondary),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 1.2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(

                      filled: false,
                      prefixIcon:  Icon(Icons.lock_outline,color:  AppColors.secondary),
                      suffixIcon: Icon(Icons.visibility_off,color:  AppColors.secondary),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color:AppColors.secondary, width: 1.2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
                      ),
                    ),
                  ),


                  // Terms and Conditions
                  Row(
                    children: [
                      Checkbox(
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
                  ElevatedButton(
                    onPressed: () {
                      // Handle signup
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
    );
  }
}





