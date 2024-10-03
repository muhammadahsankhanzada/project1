import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

customSnackbar(BuildContext context, String message,
    [Duration duration = const Duration(seconds: 5),
    Color backgroundColor = AppColors.grey5]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTextStyles.nameHeadingTextStyle(
            color: AppColors.white, size: 15),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      action: SnackBarAction(
          label: 'Dismiss',
          textColor: AppColors.white,
          backgroundColor: AppColors.green,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
    ),
  );
}
