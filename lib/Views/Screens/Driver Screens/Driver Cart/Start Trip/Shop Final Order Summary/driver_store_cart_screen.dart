import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverStoreCartScreen extends StatelessWidget {
  const DriverStoreCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Complete Summary'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.green,
                ),
                child: Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
              SizedBox(height: 30),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /////////////////////////////////
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Icon(
                  //       Icons.assignment_add,
                  //       color: AppColors.red,
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Delivered items',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Items',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //     Text(
                  //       'Quantity',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //     Text(
                  //       'Price',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   color: AppColors.black,
                  // ),
                  // for (int i = 0; i < productsDummyDataModelContent.length; i++)
                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: Text(
                  //           productsDummyDataModelContent[i].name,
                  //           style: AppTextStyles.belowMainHeadingTextStyle(),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'x${productsDummyDataModelContent[i].quantity}',
                  //           style: AppTextStyles.nameHeadingTextStyle(),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Rs. ${productsDummyDataModelContent[i].price}',
                  //           style: AppTextStyles.belowMainHeadingTextStyle(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // SizedBox(height: 10),
                  // Divider(
                  //   color: AppColors.black,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Total Quantity',
                  //       style: AppTextStyles.belowMainHeadingTextStyle(
                  //           fontSize: 18),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       'x26',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Total Price',
                  //       style: AppTextStyles.belowMainHeadingTextStyle(
                  //           fontSize: 18),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       '5000',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  //     ),
                  //   ],
                  // ),
                  // //////////////////////////////
                  // SizedBox(height: 50),

                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.assignment_return_outlined,
                  //       color: AppColors.red,
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Returned items',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Items',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //     Text(
                  //       'Quantity',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //     Text(
                  //       'Price',
                  //       style: AppTextStyles.nameHeadingTextStyle(),
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   color: AppColors.black,
                  // ),
                  // for (int i = 0; i < productsDummyDataModelContent.length; i++)
                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: Text(
                  //           productsDummyDataModelContent[i].name,
                  //           style: AppTextStyles.belowMainHeadingTextStyle(),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'x${productsDummyDataModelContent[i].quantity}',
                  //           style: AppTextStyles.nameHeadingTextStyle(),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'Rs. ${productsDummyDataModelContent[i].price}',
                  //           style: AppTextStyles.belowMainHeadingTextStyle(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // SizedBox(height: 10),
                  // Divider(
                  //   color: AppColors.black,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Total Quantity',
                  //       style: AppTextStyles.belowMainHeadingTextStyle(
                  //           fontSize: 18),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       'x26',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Total Price',
                  //       style: AppTextStyles.belowMainHeadingTextStyle(
                  //           fontSize: 18),
                  //     ),
                  //     Spacer(),
                  //     Text(
                  //       '5000',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  //     ),
                  //   ],
                  // ),
                  // //////////////////////
                  // SizedBox(height: 50),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.list_alt,
                  //       color: AppColors.red,
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Total',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total price',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 15),
                  //     ),
                  //     Text(
                  //       'Rs. 5000',
                  //       style: AppTextStyles.nameHeadingTextStyle(size: 15),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: UniversalButton(
                        title: 'Confirm delivery',
                        ontap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    height: 220,
                                    width: 300,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.lightGreen,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Confirm Order',
                                          style: AppTextStyles
                                              .nameHeadingTextStyle(),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Selected items will be delivered and retuned.\nAre you sure to confirm.',
                                          style: AppTextStyles
                                              .belowMainHeadingTextStyle(),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            UniversalButton(
                                                title: 'Confirm',
                                                buttonHeight: 40,
                                                buttonWidth: 110,
                                                buttonColor: AppColors.green
                                                    .withOpacity(.7),
                                                ontap: () {
                                                  Navigator.pop(context);
                                                  customSnackbar(context,
                                                      'Order delivered successfully');
                                                }),
                                            UniversalButton(
                                                title: 'Cancel',
                                                buttonHeight: 40,
                                                buttonWidth: 110,
                                                buttonColor:
                                                    AppColors.red.shade300,
                                                ontap: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
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
