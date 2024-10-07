import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';

class ManagerDriverRecordsDetailsScreen extends StatelessWidget {
  const ManagerDriverRecordsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Driver Info',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(Constants.logoImage),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muhammad Ahsan',
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
                          Text('Shah Faisal to Saddar'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'CNIC:',
                  style: AppTextStyles.nameHeadingTextStyle(size: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
