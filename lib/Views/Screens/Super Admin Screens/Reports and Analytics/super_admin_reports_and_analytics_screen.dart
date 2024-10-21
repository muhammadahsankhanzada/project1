import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SuperAdminReportsAndAnalyticsScreen extends StatefulWidget {
  const SuperAdminReportsAndAnalyticsScreen({super.key});

  @override
  State<SuperAdminReportsAndAnalyticsScreen> createState() =>
      _SuperAdminReportsAndAnalyticsScreenState();
}

class _SuperAdminReportsAndAnalyticsScreenState
    extends State<SuperAdminReportsAndAnalyticsScreen> {
  final Map<String, double> acquisionReportsDataMap = {
    "Social": 60,
    "Organic Search": 25,
    "Direct": 15,
  };

  final List<Color> acquisionReportsColorList = [
    AppColors.universalButtonGreen,
    AppColors.green,
    AppColors.lightGreen1,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Reports and Analytics'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  // height: 200,
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
                        'AUDIENCE',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '493 Visitors',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          // title: ChartTitle(text: 'Sales Data'),
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
                              dataSource: getChartData(),
                              width: 0.3,
                              color: AppColors.lightGreen1,
                              borderRadius: BorderRadius.circular(20),
                              xValueMapper: (SalesData data, _) => data.year,
                              yValueMapper: (SalesData data, _) => data.sales,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  // height: 200,
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
                        'ACQUISION',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      customPieChart(
                          acquisionReportsDataMap, acquisionReportsColorList),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Pie Chart
  customPieChart(Map<String, double> dataMap, List<Color> colorList) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 350,
            child: pie.PieChart(
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
    );
  }

  //
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
