import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class AdminCheckReportsScreen extends StatelessWidget {
  const AdminCheckReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Reports'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
