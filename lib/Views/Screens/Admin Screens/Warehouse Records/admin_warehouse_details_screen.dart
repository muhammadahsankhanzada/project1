import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminWarehouseDetailsScreen extends StatefulWidget {
  final String warehouseName;

  const AdminWarehouseDetailsScreen({super.key, required this.warehouseName});

  @override
  State<AdminWarehouseDetailsScreen> createState() =>
      _AdminWarehouseDetailsScreenState();
}

class _AdminWarehouseDetailsScreenState
    extends State<AdminWarehouseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> warehouseDummyDetails = {
      'Name': 'Central Logistics Hub',
      'Location': '123 Industrial Park, Cityville',
      'Total Area': '75,000 sq ft',
      'Manager': 'John Doe',
      'Phone': '123-456-7890',
      'Email': 'johndoe@warehouse.com',
      'Ceiling Height': '25 ft',
      'Loading Docks': 6,
      'Entry Doors': 3,
      'Storage Capacity': '3000 pallets',
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
                  backgroundImage: NetworkImage(
                      'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2'),
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
                      'Shah Faisal Colony, Karachi',
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
                            'Space: 3000 ft',
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
                            'Storage Capacity: 500',
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
                            'Loading Docks: 03',
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
                            'Entries: 02',
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
