import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class UniversalButton extends StatelessWidget {
  final String title;
  final double buttonWidth;
  final double buttonHeight;
  final VoidCallback ontap;
  final Color buttonColor;
  final double textSize;
  final double borderRadius;
  const UniversalButton({
    super.key,
    required this.title,
    this.buttonWidth = 200,
    required this.ontap,
    this.buttonColor = AppColors.universalButton,
    this.buttonHeight = 50,
    this.textSize = 17,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
        ),
        child: Center(
          child: Text(title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: textSize,
              )),
        ),
      ),
    );
  }
}
