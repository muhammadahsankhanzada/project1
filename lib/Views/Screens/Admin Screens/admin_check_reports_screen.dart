import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminCheckReportsScreen extends StatelessWidget {
  const AdminCheckReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> deliveryReportsDataMap = {
      "Total Deliveries": 40,
      "Pending Deliveries": 20,
      "Late Deliveries": 10,
      "On time Deliveries": 30,
    };

    final List<Color> deliveryReportsColorList = [
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.green,
    ];
    final Map<String, double> inventoryAndStocksReportsDataMap = {
      "Stock Available": 70,
      "Stock Required": 20,
      "Incoming Shipments": 10,
    };

    final List<Color> inventoryAndStocksReportsColorList = [
      Colors.blue,
      Colors.red,
      Colors.green,
    ];
    final Map<String, double> orderReportsDataMap = {
      "Orders Recieved": 50,
      "Orders Canceled": 10,
      "Orders Completed": 40,
    };

    final List<Color> orderReportsColorList = [
      Colors.blue,
      Colors.red,
      Colors.green,
    ];

    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Reports'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // SizedBox(height: 20),

              SizedBox(height: 20),
              customPieChart('Delivery Reports', deliveryReportsDataMap,
                  deliveryReportsColorList),
              customPieChart(
                  'Inventory and Stock Reports',
                  inventoryAndStocksReportsDataMap,
                  inventoryAndStocksReportsColorList),
              customPieChart(
                  'Order Reports', orderReportsDataMap, orderReportsColorList),
            ],
          ),
        ),
      ),
    );
  }

  //Pie Chart
  customPieChart(
      String title, Map<String, double> dataMap, List<Color> colorList) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 350,
            child: PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartType: ChartType.ring,
              ringStrokeWidth: 10,
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValues: true,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
