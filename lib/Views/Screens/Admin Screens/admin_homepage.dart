import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Admin'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
