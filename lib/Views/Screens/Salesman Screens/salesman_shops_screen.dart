import 'package:flutter/material.dart';
import 'package:project1/Utils/text_styles.dart';

class SalesmanShopsScreen extends StatelessWidget {
  const SalesmanShopsScreen({super.key});

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
