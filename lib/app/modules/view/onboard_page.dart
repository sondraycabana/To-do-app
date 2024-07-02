import 'package:accessment/app/components/custom_button.dart';
import 'package:accessment/app/constants/app_colors.dart';
import 'package:accessment/app/modules/view/login_page.dart';
import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:accessment/app/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';

import '../../constants/asset_paths.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Container(
          color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                128.h,
                Image.asset(
                  AssetPath.onboardingImage,
                  height: 280,
                  width: 280,
                ),
                24.h,
                const Text(
                  AppStrings.coverPageString,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                154.h,
                CustomButton(
                  text: "Let's Get Started",
                  color: Colors.white,
                  textColor: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
