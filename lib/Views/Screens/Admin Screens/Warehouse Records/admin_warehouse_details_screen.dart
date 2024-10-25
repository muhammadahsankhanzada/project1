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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.warehouseImageUrl),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.warehouseName,
                      style: AppTextStyles.nameHeadingTextStyle(),
                    ),
                    Text(
                      widget.warehouseAddress,
                      style: AppTextStyles.belowMainHeadingTextStyle(),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightGreen1.withOpacity(.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.store_outlined,
                            color: AppColors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.warehouseSpaceAvailable,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.apartment_outlined,
                            color: AppColors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.warehouseStorageCapacity,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            color: AppColors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.warehouseLoadingDocks,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.door_front_door_outlined,
                            color: AppColors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.warehouseEntries,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var value in warehouseDummyDetails.values)
                        Text(
                          value.toString(),
                          style: AppTextStyles.belowMainHeadingTextStyle(),
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
