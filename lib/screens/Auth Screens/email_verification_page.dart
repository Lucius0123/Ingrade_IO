import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/Auth Controller.dart';
import '../../appcolors/appcolors.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    print('EmailVerificationPage: Starting verification check');
    // Start checking for email verification
    authController.startEmailVerificationCheck();
  }

  @override
  void dispose() {
    print('EmailVerificationPage: Stopping verification check');
    // Stop checking when leaving the page
    authController.stopEmailVerificationCheck();
    super.dispose();
  }

  void _showResendDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.email, color: Colors.blue),
            SizedBox(width: 8),
            Text('Resend Email'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Still haven\'t received the verification email?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.sp),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Before requesting a new email:',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✓ Check your spam/junk folder\n'
                        '✓ Look for emails from Firebase\n'
                        '✓ Wait 2-3 minutes for delivery\n'
                        '✓ Check all email tabs (Promotions, etc.)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you still don\'t see it, we can send another verification email.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: authController.resendCooldown.value > 0 || authController.isSendingVerification.value
                ? null
                : () {
              Get.back();
              authController.sendEmailVerification();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: authController.isSendingVerification.value
                ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(authController.resendCooldown.value > 0
                ? 'Wait ${authController.resendCooldown.value}s'
                : 'Send New Email'),
          )),
        ],
      ),
    );
  }

  void _changeEmail() {
    Get.dialog(
      AlertDialog(
        title: Text('Change Email Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To change your email address, you\'ll need to create a new account.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'This will delete your current account. Are you sure you want to continue?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              // Delete current user and go back to signup
              try {
                await authController.currentUser?.delete();
                authController.signOut();
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to delete account. Please try signing out and creating a new account.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete & Start Over'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primary.withOpacity(0.4),AppColors.secondary, ],
          ),),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                        onPressed: () async {
                         Get.back();
                   // Delete current user and go back to signup
                   try {
                await authController.currentUser?.delete();
                authController.signOut();
                   } catch (e) {
                     Get.snackbar(
                     'Error',
                     'Failed to delete account. Please try signing out and creating a new account.',
                     backgroundColor: Colors.red,
                     colorText: Colors.white,
                     );
                    }
                   },
                      ),
              
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 110.sp,
                        height: 110.sp,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mark_email_unread,
                          size: 60,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 12.sp),

                      // Title
                      Text(
                        'Verify Your Email',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 12.sp),

                      // Description
                      Text(
                        'We\'ve sent a verification email to:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),

                      // Email address
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondary),
                        ),
                        child: Text(
                          user?.email ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 12.sp),

                      // Instructions
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.info_outline, color: AppColors.secondary, size: 24),
                            SizedBox(height: 8),
                            Text(
                              'Click the verification link in your email. The app will automatically detect when you\'ve verified.',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.orange[200]!),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.warning_amber, color: Colors.orange[600], size: 16),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Email in Spam Folder?',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '• Check your spam/junk folder\n'
                                        '• Look for emails from "noreply@[your-project].firebaseapp.com"\n'
                                        '• Mark as "Not Spam" if found\n'
                                        '• Wait 2-3 minutes for delivery',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.sp),

                      // Resend email button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => OutlinedButton(
                          onPressed: authController.resendCooldown.value > 0 || authController.isSendingVerification.value
                              ? null
                              : _showResendDialog,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: AppColors.primary),
                          ),
                          child: authController.isSendingVerification.value
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Sending...'),
                            ],
                          )
                              : Text(
                            authController.resendCooldown.value > 0
                                ? 'Resend in ${authController.resendCooldown.value}s'
                                : 'Didn\'t Receive Email?',
                            style: TextStyle(
                              fontSize: 16,
                              color: authController.resendCooldown.value > 0
                                  ? Colors.grey
                                  : AppColors.primary,
                            ),
                          ),
                        )),
                      ),

                      SizedBox(height: 12.sp),

                      // Change email option
                      TextButton(
                        onPressed: _changeEmail,
                        child: Text(
                          'Wrong email address?',
                          style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.sp),

                      // Auto-refresh indicator
                      Padding(
                        padding:  EdgeInsets.only(bottom: 18.sp),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.green[600],
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Auto-checking every 3 seconds...',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
