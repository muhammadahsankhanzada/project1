import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerPendingRequestDetailsScreen extends StatelessWidget {
  const ManagerPendingRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: AppTextStyles.simpleHeadingTextStyle(
            textColor: AppColors.universalButtonGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Request Summary',
                style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightGreen1.withOpacity(.3)),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Iphone 15 pro max',
                                        style: AppTextStyles
                                            .simpleHeadingTextStyle(
                                                fontSize: 14),
                                      ),
                                      Text(
                                        'New',
                                        style:
                                            AppTextStyles.nameHeadingTextStyle(
                                          size: 13,
                                        ),
                                      ),
                                      Text(
                                        '29Nov, 01:20 pm',
                                        style: AppTextStyles
                                            .simpleHeadingTextStyle(
                                                fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.remove_circle,
                                              size: 15,
                                            ),
                                            Text('0'),
                                            Icon(
                                              Icons.add_circle,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Rs. 95000/-',
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
                        SizedBox(
                          height: 30,
                          width: 40,
                          child: TextFormField(
                            // controller: _searchController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Enter driver name here';
                            //   }
                            //   return null;
                            // },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '5%',
                              hintStyle: AppTextStyles.simpleHeadingTextStyle(
                                fontSize: 12,
                              ),
                              filled: true,
                              fillColor: AppColors.lightGreen1.withOpacity(.3),
                              // contentPadding:
                              //     EdgeInsets.symmetric(horizontal: 30),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UniversalButton(
                    title: 'Approve',
                    buttonColor: AppColors.universalButtonGreen,
                    buttonWidth: 150,
                    ontap: () {
                      customSnackbar(context, 'Request Approved');
                    },
                  ),
                  UniversalButton(
                    title: 'Disapprove',
                    buttonColor: AppColors.red,
                    buttonWidth: 150,
                    ontap: () {
                      customSnackbar(context, 'Request Disapproved');
                    },
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
