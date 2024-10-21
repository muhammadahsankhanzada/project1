import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagerDeliveredScreen extends StatelessWidget {
  const ManagerDeliveredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Delivered'),
      body: Center(
        child: Text('Delivered'),
      ),
    );
  }
}
