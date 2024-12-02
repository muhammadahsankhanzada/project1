import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Super%20Admin%20View%20Models/super_admin_reports_and_analytics_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SuperAdminReportsAndAnalyticsScreen extends StatefulWidget {
  const SuperAdminReportsAndAnalyticsScreen({super.key});

  @override
  State<SuperAdminReportsAndAnalyticsScreen> createState() =>
      _SuperAdminReportsAndAnalyticsScreenState();
}

class _SuperAdminReportsAndAnalyticsScreenState
    extends State<SuperAdminReportsAndAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<SuperAdminReportsAndAnalyticsViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Reports and Analytics'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              _buildAudienceReports('AUDIENCE', 493, viewModel.getChartData()),
              SizedBox(height: 15),
              _buildAcquisionReports(
                  'ACQUISION',
                  viewModel.acquisionReportsDataMap,
                  viewModel.acquisionReportsColorList),
            ],
          ),
        ),
      ),
    );
  }

  // Audience reports widget
  Widget _buildAudienceReports(
    String reportsTitle,
    int visitors,
    List<SalesData> dataSource,
  ) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reportsTitle,
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$visitors Visitors',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  axisLine: AxisLine(width: 0),
                  labelStyle: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: false,
                  majorGridLines: MajorGridLines(width: 0),
                ),
                series: <ColumnSeries<SalesData, String>>[
                  ColumnSeries<SalesData, String>(
                    dataSource: dataSource,
                    width: 0.3,
                    color: AppColors.lightGreen1,
                    borderRadius: BorderRadius.circular(20),
                    xValueMapper: (SalesData data, _) => data.year,
                    yValueMapper: (SalesData data, _) => data.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Acquision reports widget
  Widget _buildAcquisionReports(
    String reportsTitle,
    Map<String, double> dataMap,
    List<Color> colorList,
  ) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reportsTitle,
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 350,
                    child: pie.PieChart(
                      animationDuration: Duration(seconds: 1),
                      dataMap: dataMap,
                      colorList: colorList,
                      legendOptions: pie.LegendOptions(
                        legendShape: BoxShape.rectangle,
                        legendPosition: pie.LegendPosition.left,
                      ),
                      chartType: pie.ChartType.disc,
                      ringStrokeWidth: 10,
                      chartValuesOptions: pie.ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
