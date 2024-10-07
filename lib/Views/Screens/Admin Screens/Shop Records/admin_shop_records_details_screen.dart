import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class AdminShopRecordsDetailsScreen extends StatelessWidget {
  const AdminShopRecordsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> storeDetails = {
      'Location': 'Shah Faisal Colony, Karachi',
      'Deliveries': '33',
      'Revenue': '50,000',
      'Type': 'General Store',
      'Timings': '8 AM to 10 PM',
      'Phone Number': '0302-8382845',
      'Email': 'info@communitystore.com',
      'Rating': 4.5,
    };

    //////////////////////////
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        title: Text(
          'Ahsan Store',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.store,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'General Store',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'A community-focused retail establishment located in the heart of the neighborhood, offering a diverse selection of groceries, household supplies, and personal care items, catering to all your daily needs.',
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: AppColors.grey,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var key in storeDetails.keys)
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
                        for (var value in storeDetails.values)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              value.toString(),
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: AppColors.grey,
              ),
              SizedBox(height: 10),
              Text(''),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}