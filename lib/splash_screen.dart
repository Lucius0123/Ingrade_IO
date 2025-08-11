import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingrade_io/screens/Auth%20Screens/LogIn_Screen.dart';
import 'package:ingrade_io/screens/homescreens.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen ({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Get.to((() => LoginScreen()));
    });
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
