import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_trip_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

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
    Map<String, dynamic> driverDetails = {
      'Age': 24,
      'CNIC': '45402-6789012-3',
      'Phone Number': '03041234567',
      'Address': 'Shah Faisal Colony, Karachi',
      'Email': 'ahsan@gmail.com',
      'Total trips': '30',
    };
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Salesman Info'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
              stream: fetchSalesmanRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('Record not Found'),
                  );
                } else if (snapshot.hasData) {
                  var salesman = snapshot.data?.data() as Map<String, dynamic>?;

                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                salesman?['imageUrl'],
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(ImageUrls.errorImage);
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
                                style: AppTextStyles.nameHeadingTextStyle(
                                    size: 15),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Route: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(salesman?['route']),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var key in driverDetails.keys)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${key}:',
                                      style: AppTextStyles.nameHeadingTextStyle(
                                          size: 15),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var value in driverDetails.values)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      value.toString(),
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
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
                      Column(
                        children: [
                          SizedBox(height: 10),
                          for (int i = 0; i < 4; i++)
                            Column(
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
                                    // margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightGrey,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '6th Oct 2024',
                                              style: AppTextStyles
                                                  .belowMainHeadingTextStyle(),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Route: ',
                                                  style: AppTextStyles
                                                      .nameHeadingTextStyle(
                                                          size: 12),
                                                ),
                                                Text(
                                                  'Shahra-e-Faisal, Karachi',
                                                  style: AppTextStyles
                                                      .belowMainHeadingTextStyle(
                                                          fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Products Requested: 30',
                                              style: AppTextStyles
                                                  .belowMainHeadingTextStyle(
                                                      fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, right: 10),
                                                child: Icon(
                                                  Icons.done_rounded,
                                                  color: AppColors.green,
                                                ),
                                              ),
                                              // SizedBox(height: 20),
                                              // Text(
                                              //   'Amount recieved: 3000',
                                              //   style: AppTextStyles.belowMainHeadingTextStyle(
                                              //       fontSize: 12),
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              }),
        ),
      ),
    );
  }

  // Method to fetch salesman records
  Stream<DocumentSnapshot> fetchSalesmanRecords() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Salesmen')
        .doc(widget.salesmanName)
        .snapshots();
    return data;
  }
}
