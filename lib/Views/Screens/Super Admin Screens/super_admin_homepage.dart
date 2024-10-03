import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class SuperAdminHomepage extends StatelessWidget {
  const SuperAdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Super Admin'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
