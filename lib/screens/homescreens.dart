// import 'package:flutter/material.dart';
// import 'package:ingarde_io_app/appcolors/appcolors.dart';
// import 'package:ingarde_io_app/screens/course_screen.dart';
// import '../customappbar/bottomnavigationbar.dart';
// import '../customappbar/customappbar.dart';
//
// class Homescreens extends StatefulWidget {
//   const Homescreens({super.key});
//
//   @override
//   State<Homescreens> createState() => _HomescreensState();
// }
//
// class _HomescreensState extends State<Homescreens> {
//
//   int currentIndex = 0;
//
//   void onTabTapped(int index) {
//     if (index == 1) {
//       // Navigate to Courses screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Courses_Screen()),
//       );
//     } else {
//       // You can manage other tabs similarly or stay on current screen
//       setState(() {
//         currentIndex = 0;
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomCourseAppBar(
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTabTapped),
//       floatingActionButton: FloatingActionButton(onPressed: (){},
//       backgroundColor: AppColors.primary,
//         child: const Icon(Icons.call_end_rounded),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:ingarde_io_app/appcolors/appcolors.dart';
// import 'package:ingarde_io_app/screens/course_screen.dart';
// import '../customappbar/bottomnavigationbar.dart';
// import '../customappbar/customappbar.dart';
//
// class Homescreens extends StatefulWidget {
//   const Homescreens({super.key});
//
//   @override
//   State<Homescreens> createState() => _HomescreensState();
// }
//
// class _HomescreensState extends State<Homescreens> {
//   int currentIndex = 0;
//
//   bool showFAB = true; // To hide/show FAB
//   double fabX = 100; // Initial X position
//   double fabY = 500; // Initial Y position
//
//   void onTabTapped(int index) {
//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Courses_Screen()),
//       );
//     } else {
//       setState(() {
//         currentIndex = 0;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomCourseAppBar(),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: currentIndex,
//         onTap: onTabTapped,
//       ),
//       body: Stack(
//         children: [
//           // Your main screen content here
//
//           // Movable FAB
//           if (showFAB)
//             Positioned(
//               left: fabX,
//               top: fabY,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   setState(() {
//                     fabX += details.delta.dx;
//                     fabY += details.delta.dy;
//                   });
//                 },
//                 onLongPress: () {
//                   setState(() {
//                     showFAB = false; // Hide FAB on long press
//                   });
//                 },
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     debugPrint("FAB Clicked");
//                   },
//                   backgroundColor: AppColors.primary,
//                   child: Text("Enroll",),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../appcolors/appcolors.dart';
import '../customappbar/bottomnavigationbar.dart';
import '../customappbar/customappbar.dart';
import 'course_screen.dart';

class Homescreens extends StatefulWidget {
  const Homescreens({super.key});

  @override
  State<Homescreens> createState() => _HomescreensState();
}

class _HomescreensState extends State<Homescreens> {

  int currentIndex = 0;

  void onTabTapped(int index) {
    if (index == 1) {
      // Navigate to Courses screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Courses_Screen()),
      );
    } else {
      // You can manage other tabs similarly or stay on current screen
      setState(() {
        currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomCourseAppBar(
      ),
        bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTabTapped),

      // floatingActionButton: CustomGradientFAB(
      //   onPressed: () {
      //     // Action on FAB tap
      //   },
      //   text: "Enroll",
      //   gradientColors: isDarkMode
      //       ? [Colors.black, Colors.grey.shade800] // Dark mode gradient
      //       : [Colors.amber, Colors.green.shade900], // Light mode gradient
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: ,
      //     onPressed: (){
      //   print("");
      // },child: Icon(Icons.add,)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(0.5), AppColors.secondary.withOpacity(0.9 )],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            print("Gradient FAB clicked");
          },
          backgroundColor: Colors.transparent, // Important: transparent
          elevation: 0, // No shadow from FAB itself
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
