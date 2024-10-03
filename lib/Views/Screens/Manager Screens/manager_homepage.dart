import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class ManagerHomepage extends StatelessWidget {
  const ManagerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Manager'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
