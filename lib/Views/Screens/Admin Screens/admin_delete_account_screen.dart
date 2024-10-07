import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class AdminDeleteAccountScreen extends StatelessWidget {
  const AdminDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Delete Account'),
          centerTitle: true,
          backgroundColor: AppColors.green),
    );
  }
}
