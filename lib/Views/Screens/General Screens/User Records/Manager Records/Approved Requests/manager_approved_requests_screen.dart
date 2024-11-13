import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class ManagerApprovedRequestsScreen extends StatelessWidget {
  const ManagerApprovedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Approved Requests',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
