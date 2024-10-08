import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SuperAdminReportsAndAnalyticsScreen extends StatelessWidget {
  const SuperAdminReportsAndAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Reports and Analytics',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            child: SfCartesianChart(),
          ),
        ],
      ),
    );
  }
}
