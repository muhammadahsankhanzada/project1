import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminWarehouseDetailsScreen extends StatefulWidget {
  final String warehouseName;
  final String warehouseImageUrl;
  final String warehouseAddress;
  final String warehouseSpaceAvailable;
  final String warehouseLoadingDocks;
  final String warehouseStorageCapacity;
  final String warehouseEntries;
  final String warehouseManagerName;
  final String warehouseContact;
  final String warehouseEmail;

  const AdminWarehouseDetailsScreen({
    super.key,
    required this.warehouseName,
    required this.warehouseImageUrl,
    required this.warehouseAddress,
    required this.warehouseSpaceAvailable,
    required this.warehouseLoadingDocks,
    required this.warehouseStorageCapacity,
    required this.warehouseEntries,
    required this.warehouseManagerName,
    required this.warehouseContact,
    required this.warehouseEmail,
  });

  @override
  State<AdminWarehouseDetailsScreen> createState() =>
      _AdminWarehouseDetailsScreenState();
}

class _AdminWarehouseDetailsScreenState
    extends State<AdminWarehouseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Warehouse Info'),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: fetchWarehouseRecords(),
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
                var warehouse = snapshot.data?.data() as Map<String, dynamic>?;
                Map<String, dynamic> warehouseDummyDetails = {
                  'Total Area': widget.warehouseSpaceAvailable,
                  'Manager': widget.warehouseManagerName,
                  'Phone': warehouse?['contact'],
                  'Email': warehouse?['email'],
                  'Ceiling Height': '25 ft',
                  'Loading Docks': widget.warehouseLoadingDocks,
                  'Entry Doors': widget.warehouseEntries,
                  'Storage Capacity': widget.warehouseStorageCapacity,
                  'Total Employees': 50,
                  'Daily Shipments': 200,
                  'Receiving Hours': '8 AM - 5 PM',
                  'Shipping Hours': '9 AM - 6 PM',
                };
                return Column(
                  children: [
                    SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          // backgroundImage: NetworkImage(widget.warehouseImageUrl),
                          child: ClipOval(
                            child: Image.network(
                              warehouse?['imageUrl'],
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  Constants.errorImage,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.warehouseName,
                          style: AppTextStyles.simpleHeadingTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          warehouse?['address'],
                          style: AppTextStyles.simpleHeadingTextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      // height: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColors.lightGreen1.withOpacity(.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            // topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(30),
                          )),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Space',
                                style:
                                    AppTextStyles.belowMainHeadingTextStyle(),
                              ),
                              Text(
                                'Storage Capacity',
                                style:
                                    AppTextStyles.belowMainHeadingTextStyle(),
                              ),
                              Text(
                                'Loading Docks',
                                style:
                                    AppTextStyles.belowMainHeadingTextStyle(),
                              ),
                              Text(
                                'Entries',
                                style:
                                    AppTextStyles.belowMainHeadingTextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.warehouseSpaceAvailable,
                                style: AppTextStyles.simpleHeadingTextStyle(),
                              ),
                              Text(
                                widget.warehouseStorageCapacity,
                                style: AppTextStyles.simpleHeadingTextStyle(),
                              ),
                              Text(
                                widget.warehouseLoadingDocks,
                                style: AppTextStyles.simpleHeadingTextStyle(),
                              ),
                              Text(
                                widget.warehouseEntries,
                                style: AppTextStyles.simpleHeadingTextStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen1.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var key in warehouseDummyDetails.keys)
                                Text(
                                  '${key}:',
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(),
                                ),
                              SizedBox(height: 5),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var value in warehouseDummyDetails.values)
                                Text(
                                  value.toString(),
                                  style: AppTextStyles.simpleHeadingTextStyle(),
                                ),
                              SizedBox(height: 5),
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
    );
  }

  // Method to fetch warehouse records
  Stream<DocumentSnapshot> fetchWarehouseRecords() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Warehouses')
        .doc(widget.warehouseName)
        .snapshots();
    return data;
  }
}
