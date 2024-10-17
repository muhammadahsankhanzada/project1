import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class AppTextStyles {
  // Onboarding Title TextStyle
  static TextStyle onboardingTitleTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: AppColors.black,
    );
  }

  // Onboarding Description TextStyle
  static TextStyle onboardingDescriptionTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: AppColors.black,
    );
  }

  // Name Heading TextStyle
  static TextStyle nameHeadingTextStyle(
      {double size = 18, Color color = AppColors.black}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      fontFamily: 'Poppins',
      color: color,
    );
  }

  // Main Heading TextStyle
  static TextStyle mainHeadingTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily: 'Poppins',
      color: AppColors.black,
    );
  }

  // Below Main Heading TextStyle
  static TextStyle belowMainHeadingTextStyle(
      {double fontSize = 15, Color textColor = AppColors.black}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      color: textColor,
    );
  }

  // Simple Heading TextStyle
  static TextStyle simpleHeadingTextStyle(
      {double fontSize = 15,
      Color textColor = AppColors.black,
      FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Poppins',
      color: textColor,
    );
  }
}
