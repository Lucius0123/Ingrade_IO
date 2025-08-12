import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ingrade_io/customappbar/themecontroler.dart';
import '../Controller/Auth Controller.dart';
import '../appcolors/appcolors.dart';

class CustomCourseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomCourseAppBar({Key? key})
      : preferredSize = const Size.fromHeight(80.0),
        super(key: key);
  final AuthController authController = Get.find<AuthController>();
  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              authController.signOut();
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ThemeController.isDarkMode;

    final Color textColor = isDarkMode ? const Color(0xffBF9B42) : const Color(0xff033631) ;
    final Color iconColor = textColor;

    return AppBar(
      backgroundColor: Colors.transparent, // Transparent to show gradient
      elevation: 6,
      shadowColor: Colors.white.withOpacity(0.1),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: 70,

      // Gradient background
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
            colors: [Colors.black, Color(0xFF1C1C1C)], // black to dark grey
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              :  LinearGradient(
            colors: [AppColors.primary.withOpacity(0.4),AppColors.secondary.withOpacity(0.9)], // gold to dark green
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),

      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            // App Name
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
              child: RichText(
                text: TextSpan(
                  text: "in",
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                  children:  [
                    TextSpan(
                      text: "Grade",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Notification Button
            IconButton(
              icon: Icon(
                  size: 28,
                  Icons.notifications_outlined, color: iconColor),
              tooltip: 'Notifications',
              onPressed: () {},
            ),

            // Theme Toggle Button
            IconButton(
              icon: Icon(
                size: 28,
                isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: iconColor,
              ),
              tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
              onPressed: () {
                ThemeController.toggleTheme();
              },
            ),

            // User Avatar
            IconButton(
              icon: Icon(Icons.person_2_outlined,size: 28,color: iconColor,),
              onPressed: () => _showLogoutDialog(context),
            ),

          ],
        ),
      ),
    );
  }
}
