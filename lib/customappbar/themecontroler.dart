import 'package:flutter/material.dart';

class ThemeController {
  // This will hold and notify the theme mode change
  static ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  static void toggleTheme() {
    themeNotifier.value =
    themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  static bool get isDarkMode => themeNotifier.value == ThemeMode.dark;
}
