import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ingrade_io/appcolors/appcolors.dart';
import '../../Controller/Auth Controller.dart';
import 'SignUP_Screen.dart';
import 'forgot_password_page.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

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
                child: Form(
                  key: formKey,
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
                                 style: TextStyle(
                                   color:AppColors.secondary, // Change text color
                                   fontSize: 16.sp,
                                   fontWeight: FontWeight.w500// Optional: Change font size
                                 ),
                                 controller: emailController,

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
                                   return null;
                                 },
                               ),


                               // Forgot Password
                               Align(
                                 alignment: Alignment.centerRight,
                                 child: TextButton(
                                   onPressed: () => Get.to(() => ForgotPasswordPage()),
                                   child:  Text('Forgot Password?',style: Theme.of(context).textTheme.labelLarge,),
                                 ),
                               ),
                               const SizedBox(height: 30),
                               Obx(()=>ElevatedButton(
                                 onPressed: authController.isLoading.value
                                     ? null
                                     : () {
                                   if (formKey.currentState!.validate()) {
                                     authController.signInWithEmailAndPassword(
                                       emailController.text.trim(),
                                       passwordController.text,
                                     );
                                   }
                                 },
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: AppColors.primary,
                                   minimumSize: const Size(double.infinity, 50),
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(20),
                                   ),
                                 ),
                                 child:  authController.isLoading.value
                                     ? CircularProgressIndicator(color: AppColors.secondary)
                                     :Text(
                                   "Login",
                                   style: GoogleFonts.poppins(
                                     color:AppColors.secondary,
                                     fontWeight: FontWeight.w700,
                                     fontSize: 25,
                                   ),
                                 ),
                               )),

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
                            onPressed: (){
                              authController.SingInWithGoole();
                            },
                            icon:  Image.asset(
                            'assets/Icon/google.png',
                            width: 30.sp,
                            height: 30.sp,
                          ),),
                          SizedBox(width: 20,),

                          Obx(() => IconButton( icon: Icon(Icons.apple,size: 43.sp,color:Colors.white,),
                              onPressed: authController.isLoading.value
                              ? null
                              : () => authController.signInWithApple(),)),

                        ],
                      ),
                      SizedBox(height: 70.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            children: [
                              TextSpan(text:  "Don't have an account? ",style: TextStyle(fontSize: 16.sp)),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: AppColors.secondary),
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
      ),
    );
  }
}
