import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ingrade_io/appcolors/appcolors.dart';
import 'package:ingrade_io/screens/Auth%20Screens/sign%20A.dart';


 // Dark Green

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        ),          child: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
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
                     SizedBox(height: 80,),
                     Center(
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           children: [
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


                             // Forgot Password
                             Align(
                               alignment: Alignment.centerRight,
                               child: TextButton(
                                 onPressed: () {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(content: Text('Forgot password feature coming soon!')),
                                   );
                                 },
                                 child:  Text('Forgot Password?',style: Theme.of(context).textTheme.labelLarge,),
                               ),
                             ),
                             const SizedBox(height: 30),
                             ElevatedButton(
                               onPressed: () {
                                 // Handle login
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: AppColors.primary,
                                 minimumSize: const Size(double.infinity, 50),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                               ),
                               child: Text(
                                 "Login",
                                 style: GoogleFonts.poppins(
                                   color:AppColors.secondary,
                                   fontWeight: FontWeight.w700,
                                   fontSize: 25,
                                 ),
                               ),
                             ),

                           ],
                         ),
                       ),
                     ),

                  SizedBox(height: 10.h),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('or continue with'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon:  Image.asset(
                          'assets/Icon/google.png',
                          width: 30.sp,
                          height: 30.sp,
                        ),),
                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.facebook,size: 43.sp,color: Colors.blue,), onPressed: () {}),

                      ],
                    ),
                    SizedBox(height: 70.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          children: [
                            TextSpan(text:  "Don't have an account? ",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900,color: Colors.white)),
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => SignupScreen());
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
