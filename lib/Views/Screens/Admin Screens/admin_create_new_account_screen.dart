import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class AdminCreateNewAccountScreen extends StatelessWidget {
  const AdminCreateNewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Create Account'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
