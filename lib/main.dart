import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ingrade_io/splash_screen.dart';

import 'customappbar/themecontroler.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ScreenUtilInit(
          designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context,child){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'InGrade',
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: currentMode,
              home: Splashscreen(), // Your main screen
            );
          },
        );
      },
    );
  }
}