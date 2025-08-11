// import 'package:flutter/material.dart';
// import 'package:ingarde_io_app/customappbar/themecontroler.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = ThemeController.isDarkMode;
//
//     final Color bgColor = isDarkMode ? Colors.black : Color(0xffBF9B42);
//     final Color selectedColor = isDarkMode? const Color(0xffBF9B42): Color(0xff033631);
//     final Color unselectedColor = isDarkMode ? Colors.white70 : Colors.black54;
//
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       backgroundColor: bgColor,
//       elevation: 10,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: selectedColor,
//       unselectedItemColor: unselectedColor,
//       selectedFontSize: 12,
//       unselectedFontSize: 11,
//       showUnselectedLabels: true,
//       items:  [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           activeIcon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.play_circle_outline),
//           activeIcon: Icon(Icons.play_circle_filled),
//           label: 'Courses',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Explore',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_outline),
//           activeIcon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:ingrade_io/customappbar/themecontroler.dart';

import '../appcolors/appcolors.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ThemeController.isDarkMode;

    final Color selectedColor =
    isDarkMode ? const Color(0xffBF9B42) : const Color(0xff033631);
    final Color unselectedColor =
    isDarkMode ? Colors.white70 : Colors.black54;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? const LinearGradient(
          colors: [Colors.black, Color(0xFF1C1C1C)], // black to gold
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : LinearGradient(
          colors: [AppColors.primary.withOpacity(0.4),AppColors.secondary.withOpacity(0.9)], // gold to dark green
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent, // transparent for gradient
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school_sharp ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            activeIcon: Icon(Icons.play_circle_filled),
            label: 'InLearn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
