import 'package:flutter/material.dart';


import '../../constants/app_colors.dart'; // Assuming AppColors is in a separate file

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
            color: Color(0xFFEFEEF0),
          ),
        ),
        Text(
          "Or",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.neutralDarkGreyColor,
          ),
        ),
        Expanded(
          child: Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
            color: Color(0xFFEFEEF0),
          ),
        ),
      ],
    );
  }
}
