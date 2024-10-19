import 'package:flutter/material.dart';
import 'package:project1/Utils/text_styles.dart';

class DriverShopsScreen extends StatelessWidget {
  const DriverShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Start trip first...',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
      ),
    );
  }
}
