import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingrade_io/screens/Auth%20Screens/LogIn_Screen.dart';
import 'package:ingrade_io/screens/Home%20Screen/homescreens.dart';

import 'Controller/Auth Controller.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen ({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState(){
    super.initState();
    _checkAuthStatus();
  }
  void _checkAuthStatus() async {
    final AuthController authController = Get.find<AuthController>();

    // Wait for 3 seconds to show splash screen
    await Future.delayed(Duration(seconds: 3));

    // This initial check handles the very first navigation when the app starts.
    // Subsequent auth state changes (like sign out) will be handled by the
    // 'ever' listener in AuthController.
    if (authController.currentUser != null) {
      Get.offAll(() => HomeScreen()); // Navigate directly to HomePage
    } else {
      Get.offAll(() =>  LoginScreen()); // Navigate directly to LoginPage
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Center(child: Image.asset('assets/images/ingradelogo.png',height: 300,width: 600,)),
      ),
    );
  }
}
