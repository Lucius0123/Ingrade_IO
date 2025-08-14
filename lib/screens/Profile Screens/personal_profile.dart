import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ingrade_io/appcolors/appcolors.dart';
import '../../Controller/Auth Controller.dart';


class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenHeight * 0.080;
    final editIconSize = avatarRadius * 0.30;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx((){
        final user = authController.user.value;
        return Stack(
          clipBehavior: Clip.none, // allows CircleAvatar to overflow
          children: [
            Column(
              children: [
                // Top Container - 20%
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: double.infinity,
                  color: AppColors.primary,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 14.sp,vertical: 20.sp),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,size: 24.sp, color: AppColors.secondary),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                ),
                // Bottom Container - 80%
                Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.09,left: 30.h,right: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                        user?.displayName ?? 'User Name',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                        SizedBox(height: 8),
                        // Email
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            user?.email ?? 'user@email.com',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Expanded(
                          child: Column(
                            children: [
                              _buildMenuItem(
                                context: context,
                                icon: Icons.edit_outlined,
                                title: 'Edit Profile',
                                onTap: (){},
                                iconColor: AppColors.secondary,
                              ),

                              SizedBox(height: 12),

                              _buildMenuItem(
                                context: context,
                                icon: Icons.monetization_on_outlined,
                                title: 'My Subscription',
                                onTap: () {},

                                iconColor: AppColors.secondary,
                              ),

                              SizedBox(height: 12),

                              _buildMenuItem(
                                context: context,
                                icon: Icons.notifications_outlined,
                                title: 'Notification Settings',
                                onTap: (){},
                                iconColor: AppColors.secondary,
                              ),

                              SizedBox(height: 12),
                              _buildMenuItem(
                                context:context,
                                icon: Icons.help_outline_outlined,
                                title: 'Help & Support',
                                onTap: (){},
                                iconColor: AppColors.secondary,
                              ),

                              SizedBox(height: 12),

                              _buildMenuItem(
                                context: context,
                                icon: Icons.logout,
                                title: 'Logout',
                                onTap: () => _showLogoutConfirmation(context),
                                iconColor: Colors.red,
                                titleColor: Colors.red,
                                ArrowColor: Colors.red,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Circle Avatar positioned in middle
            Positioned(
              top: MediaQuery.of(context).size.height* 0.20 - MediaQuery.of(context).size.height*0.070, // half in top, half in bottom
              left: MediaQuery.of(context).size.width / 2 -  MediaQuery.of(context).size.height*0.070, // center horizontally
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius:MediaQuery.of(context).size.height*0.070,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*0.065,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(
                          user!.photoURL!,
                        ):null,

                      ),
                    ),
                  Positioned(
                    top: 0,
                    left: avatarRadius - (editIconSize / 50),
                    right:0,
                    child: GestureDetector(
                      onTap: (){},
                      child: CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        radius: editIconSize,
                        child: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                          size: editIconSize +5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }


  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color iconColor,
    Color? titleColor,
    Color? ArrowColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 48.sp,
          height: 48.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24.sp,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: titleColor ?? AppColors.secondary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: ArrowColor ?? AppColors.secondary,
          size: 20.sp,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }




  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.9),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Icon
                CircleAvatar(
                  radius: 30.sp,
                  backgroundColor: AppColors.secondary.withOpacity(0.1),
                  child: Icon(Icons.help_outline, size: 30, color: AppColors.secondary),
                ),
                const SizedBox(height: 16),
          
                // Title
                Text(
                  "Are You Sure?",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
          
                // Subtitle
                Text(
                  "Are you sure you want to logout from this account? You can log in back easily.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
                const SizedBox(height: 20),
          
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child:  Text("Cancel", style: TextStyle(fontSize: 14.sp,color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 10),
          
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.red),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // close sheet
                      authController.signOut();
                    },
                    child:Text("Logout", style: TextStyle(fontSize: 14.sp,color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
