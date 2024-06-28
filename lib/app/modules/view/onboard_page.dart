import 'package:accessment/app/components/custom_button.dart';
import 'package:accessment/app/constants/app_colors.dart';
import 'package:accessment/app/modules/view/login_page.dart';
import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:flutter/material.dart';


class OnboardingPage extends StatelessWidget {
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
                  'assets/images/png/cover-img.png',
                  height: 280,
                  width: 280,
                ),
                24.h,
                const Text(
                  'Jot down anything you want to achieve, today or in the future ',
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
                        builder: (BuildContext context) => LoginPage(),
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
