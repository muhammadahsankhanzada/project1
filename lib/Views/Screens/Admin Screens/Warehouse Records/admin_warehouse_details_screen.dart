import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
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
    Map<String, dynamic> warehouseDummyDetails = {
      'Total Area': widget.warehouseSpaceAvailable,
      'Manager': widget.warehouseManagerName,
      'Phone': widget.warehouseContact,
      'Email': widget.warehouseEmail,
      'Ceiling Height': '25 ft',
      'Loading Docks': widget.warehouseLoadingDocks,
      'Entry Doors': widget.warehouseEntries,
      'Storage Capacity': widget.warehouseStorageCapacity,
      'Total Employees': 50,
      'Daily Shipments': 200,
      'Receiving Hours': '8 AM - 5 PM',
      'Shipping Hours': '9 AM - 6 PM',
    };
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Warehouse Info'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.warehouseImageUrl),
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
                  widget.warehouseAddress,
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              // height: 100,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                      Text(
                        'Storage Capacity',
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                      Text(
                        'Loading Docks',
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                      Text(
                        'Entries',
                        style: AppTextStyles.belowMainHeadingTextStyle(),
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                          style: AppTextStyles.belowMainHeadingTextStyle(),
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
        ),
      ),
    );
  }
}
