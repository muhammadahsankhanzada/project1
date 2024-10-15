import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class UniversalButton extends StatelessWidget {
  final String title;
  final double buttonWidth;
  final double buttonHeight;
  final VoidCallback ontap;
  final Color buttonColor;
  const UniversalButton({
    super.key,
    required this.title,
    this.buttonWidth = 200,
    required this.ontap,
    this.buttonColor = AppColors.universalButton,
    this.buttonHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
          child: Text(title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 17,
              )),
        ),
      ),
    );
  }
}
