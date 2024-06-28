import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class RegisterLoginLinkWidget extends StatelessWidget {
  final VoidCallback route;
  final String? text;
  final String? preText;

  const RegisterLoginLinkWidget({Key? key, required this.route, this.text, this.preText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            preText ?? "Don't have an account?", // Use provided preText or default
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.neutralDarkGreyColor,
            ),
          ),
        5.w,
          GestureDetector(
            onTap: route,
            child: Text(
              text ?? "Register here", // Use provided text or default
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
          ),
       5.w,
        ],
      ),
    );
  }
}

