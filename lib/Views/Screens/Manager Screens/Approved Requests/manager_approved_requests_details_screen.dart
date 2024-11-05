import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagerApprovedRequestsDetailsScreen extends StatefulWidget {
  final salesmanId;
  final salesmanName;
  const ManagerApprovedRequestsDetailsScreen(
      {super.key, required this.salesmanId, required this.salesmanName});

  @override
  State<ManagerApprovedRequestsDetailsScreen> createState() =>
      _ManagerApprovedRequestsDetailsScreenState();
}

class _ManagerApprovedRequestsDetailsScreenState
    extends State<ManagerApprovedRequestsDetailsScreen> {
  int totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    // print(widget.salesmanId);
    // print(widget.salesmanName);
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Order Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: fetchApprovedRequestSummary(),
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
                    child: Text('No Data Found'),
                  );
                } else if (snapshot.hasData) {
                  final products = snapshot.data?.docs ?? [];
                  // Calculating total amount
                  totalAmount = 0;
                  for (var product in products) {
                    totalAmount += int.parse(product['price'].toString());
                  }
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.salesmanName,
                          style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.lightGreen1.withOpacity(.3)),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  // Formatting date time of product addition
                                  DateTime dateTime =
                                      products[index]['dateTime'].toDate();
                                  String formattedDate =
                                      DateFormat('dd MMM, hh:mm a')
                                          .format(dateTime);
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                              products[index]['imageUrl'],
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  ImageUrls.errorImage,
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100,
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                products[index][
                                                    'name'], // 'Iphone 15 pro max',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 14),
                                              ),
                                              Text(
                                                products[index]['new']
                                                    ? 'New'
                                                    : 'Old',
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
                                                  size: 13,
                                                ),
                                              ),
                                              Text(
                                                formattedDate,
                                                // '29Nov, 01:20 pm',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 14),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Rs. ${products[index]['price']}/-',
                                                  style: AppTextStyles
                                                      .belowMainHeadingTextStyle(
                                                          fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Divider(
                                        color: AppColors.lightGreen1,
                                      )
                                    ],
                                  );
                                }),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Orders',
                                  style: AppTextStyles.simpleHeadingTextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  products.length.toString(),
                                  style: AppTextStyles.simpleHeadingTextStyle(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: AppTextStyles.nameHeadingTextStyle(),
                                ),
                                Text(
                                  totalAmount.toString(),
                                  style: AppTextStyles.simpleHeadingTextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
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

  // Method to get approved request summary
  Stream<QuerySnapshot> fetchApprovedRequestSummary() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc('Ahsan')
        .collection('Approved Requests')
        .doc(widget.salesmanId)
        .collection('Requested Products')
        .snapshots();
    return data;
  }
}
