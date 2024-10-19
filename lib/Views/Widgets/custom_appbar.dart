import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final backgroundColor;
  const CustomAppbar(
      {super.key,
      required this.title,
      this.backgroundColor = AppColors.lightWhiteBackground});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: AppTextStyles.simpleHeadingTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: AppColors.universalButtonGreen,
          ),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
