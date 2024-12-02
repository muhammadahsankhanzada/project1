import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_check_reports_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AdminCheckReportsScreen extends StatelessWidget {
  const AdminCheckReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Reports'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Consumer<AdminCheckReportsViewModel>(
              builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(height: 20),
                _buildCustomPieChart(
                    'Delivery Reports',
                    value.deliveryReportsDataMap,
                    value.deliveryReportsColorList),
                _buildCustomPieChart(
                    'Inventory and Stock Reports',
                    value.inventoryAndStocksReportsDataMap,
                    value.inventoryAndStocksReportsColorList),
                _buildCustomPieChart('Order Reports', value.orderReportsDataMap,
                    value.orderReportsColorList),
              ],
            );
          }),
        ),
      ),
    );
  }

  //Pie Chart
  Widget _buildCustomPieChart(
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
