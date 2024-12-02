import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_records_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AdminRecordsScreen extends StatelessWidget {
  final String adminName;
  const AdminRecordsScreen({
    super.key,
    required this.adminName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Admin Info'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _buildShowAdminDetails(),
        ),
      ),
    );
  }

  // Show admin details
  Widget _buildShowAdminDetails() {
    return Consumer<AdminRecordsViewModel>(builder: (context, value, child) {
      return Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/p2.jpeg'),
          ),
          SizedBox(height: 10),
          Text(
            adminName,
            style: AppTextStyles.nameHeadingTextStyle(size: 15),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.lightGreen1.withOpacity(.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var key in value.adminDetails.keys)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${key}:',
                          style: AppTextStyles.nameHeadingTextStyle(size: 15),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var value in value.adminDetails.values)
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
        ],
      );
    });
  }
}
