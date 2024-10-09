import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class SuperAdminShopManagementScreen extends StatelessWidget {
  const SuperAdminShopManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Shop Management',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Column(
        children: [
          Text('view shops\nadd shops\ndelete shops'),
        ],
      ),
    );
  }
}
