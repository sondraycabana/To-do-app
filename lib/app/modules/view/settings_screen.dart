import 'package:assessment/app/utils/Extensions/size_box_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';
import '../../utils/app_strings/app_strings.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  // final FireAuth _fireAuth = FireAuth();

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    void showLogoutDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter",
                    fontSize: 20),
              ),
            ),
            content: const Text(
              'Are you sure you want to log out from the application?',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.neutralDarkGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(color: AppColors.primaryColor),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FireAuth.signOut(context); // Sign out the user
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
                color: AppColors.primaryColor,
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  66.w,
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    ),
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                        color: AppColors.neutralBlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 0.0,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1.0,
                color: const Color(0xffC8C5CB),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.h,
            Text(
              user?.displayName ?? 'No display name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AssetPath.emailIcon,
                  height: 40,
                  width: 40,
                  color: AppColors.neutralDarkGreyColor,
                ),
                6.w,
                Text(
                  user?.email ?? 'No email address',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutralDarkGreyColor,
                  ),
                ),
              ],
            ),
            24.h,
            const Divider(
              color: AppColors.neutralBaseGreyColor,
              thickness: 1.0,
              height: 40,
            ),
            17.h,
            Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: showLogoutDialog,
                    child: Row(
                      children: [
                        Image.asset(
                          AssetPath.logOutIcon,
                          height: 24,
                          width: 24,
                        ),
                        12.w,
                        const Text(
                          AppStrings.logOutText,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFCE3A54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
