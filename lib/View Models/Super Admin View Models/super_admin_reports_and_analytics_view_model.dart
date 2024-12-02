import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';

class SuperAdminReportsAndAnalyticsViewModel with ChangeNotifier {
  // Data for pie chart
  final Map<String, double> acquisionReportsDataMap = {
    "Social": 60,
    "Organic Search": 25,
    "Direct": 15,
  };

  // Color list for pie chart
  final List<Color> acquisionReportsColorList = [
    AppColors.universalButtonGreen,
    AppColors.green,
    AppColors.lightGreen1,
  ];

  // Data for bar chart
  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData('Mon', 35),
      SalesData('Tue', 28),
      SalesData('Wed', 34),
      SalesData('Thu', 32),
      SalesData('Fri', 50),
      SalesData('Sat', 45),
      SalesData('Sun', 30),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
