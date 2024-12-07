import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_records_details_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_trip_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class SalesmanRecordsDetailsScreen extends StatefulWidget {
  final String salesmanName;
  final String salesmanRoute;
  const SalesmanRecordsDetailsScreen({
    super.key,
    required this.salesmanName,
    required this.salesmanRoute,
  });

  @override
  State<SalesmanRecordsDetailsScreen> createState() =>
      _SalesmanRecordsDetailsScreenState();
}

class _SalesmanRecordsDetailsScreenState
    extends State<SalesmanRecordsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Salesman Info'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _buildShowSalesmanDetails(),
        ),
      ),
    );
  }

  // Show salesman details
  Widget _buildShowSalesmanDetails() {
    return Consumer<SalesmanRecordsDetailsViewModel>(
        builder: (context, value, child) {
      return FutureBuilderHelperWidget(
        future: value.fetchSalesmanRecords(widget.salesmanName),
        onSuccess: (result) {
          final salesman = result['salesmanDetails'];
          Map<String, dynamic> salesmanDetails = {
            'Age': salesman['age'],
            'CNIC': salesman['cnic'],
            'Phone Number': salesman['contact'],
            'Address': salesman['address'],
            'Email': salesman['email'],
            'Total trips': salesman['totalTrips'],
          };
          return Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Image.network(
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        salesman['imageUrl'],
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              ImageUrls.errorImage);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.salesmanName,
                        style: AppTextStyles.nameHeadingTextStyle(size: 15),
                      ),
                      Row(
                        children: [
                          Text(
                            'Route: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(salesman['route']),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var key in salesmanDetails.keys)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${key}:',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var value in salesmanDetails.values)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              value.toString(),
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Trips',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: result['trips'].length,
                  itemBuilder: (context, index) {
                    final trip = result['trips'][index];

                    // Formatting date time of product addition
                    Timestamp timestamp = Timestamp(
                        trip['dateTime']['_seconds'],
                        trip['dateTime']['_nanoseconds']);
                    DateTime dateTime = timestamp.toDate();
                    String formattedDate =
                        DateFormat('dd MMM, hh:mm a').format(dateTime);
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SalesmanRecordsTripDetailsScreen()));
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightGrey,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Route: ',
                                          style: AppTextStyles
                                              .nameHeadingTextStyle(size: 12),
                                        ),
                                        Text(
                                          trip['route'],
                                          style: AppTextStyles
                                              .belowMainHeadingTextStyle(
                                                  fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Products Requested: ${trip['productsRequested']}',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 12),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 10),
                                        child: Icon(
                                          Icons.done_rounded,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
            ],
          );
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('No Records Found'),
        errorWidget: Text('Error Fetching Records'),
      );
    });
  }
}
