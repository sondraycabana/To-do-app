import 'package:accessment/app/constants/asset_paths.dart';
import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:accessment/app/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          153.h,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: Center(
              child: Image.asset(
                AssetPath.homePage,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          24.h,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                child: const Text(
                  AppStrings.homeScreenText1,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutralBlackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              16.h,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 62.0),
                child: const Text(
                  AppStrings.homeScreenText2,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Inter",
                    color: AppColors.neutralDarkGreyColor,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          21.h,
          Center(
            child: Image.asset(
              AssetPath.homePageArrowImg,
              width: double.infinity,
              height: 170,
            ),
          ),
        ],
      ),
    );
  }
}
