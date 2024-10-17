import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';

class DriverDeliverdOrdersSummaryScreen extends StatelessWidget {
  const DriverDeliverdOrdersSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Ahsan Store',
          style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.lightGreen1, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightGreen1.withOpacity(.3)),
                child: Expanded(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        Constants.backgroundImage,
                                        width: 100,
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
                                          'Iphone 15 pro max',
                                          style: AppTextStyles
                                              .simpleHeadingTextStyle(
                                                  fontSize: 14),
                                        ),
                                        Text(
                                          'New',
                                          style: AppTextStyles
                                              .nameHeadingTextStyle(
                                            size: 13,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Rs. 95000/-',
                                          style: AppTextStyles
                                              .belowMainHeadingTextStyle(
                                                  fontSize: 16),
                                        ),
                                      ],
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
                            '30',
                            style: AppTextStyles.simpleHeadingTextStyle(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '5%',
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
                            'xxxxx',
                            style: AppTextStyles.simpleHeadingTextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
