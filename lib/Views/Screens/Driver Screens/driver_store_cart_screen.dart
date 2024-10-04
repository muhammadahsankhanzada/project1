import 'package:flutter/material.dart';
import 'package:project1/Models/products_dummy_data_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverStoreCartScreen extends StatelessWidget {
  const DriverStoreCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Order Summary',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.assignment_add,
                        color: AppColors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delivered items',
                        style: AppTextStyles.nameHeadingTextStyle(size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Quantity',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Price',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.black,
                  ),
                  for (int i = 0; i < productsDummyDataModelContent.length; i++)
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            productsDummyDataModelContent[i].name,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'x${productsDummyDataModelContent[i].quantity}',
                            style: AppTextStyles.nameHeadingTextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Rs. ${productsDummyDataModelContent[i].price}',
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Divider(
                    color: AppColors.black,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Quantity',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        'x26',
                        style: AppTextStyles.nameHeadingTextStyle(size: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Price',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '5000',
                        style: AppTextStyles.nameHeadingTextStyle(size: 18),
                      ),
                    ],
                  ),
                  //////////////////////////////
                  SizedBox(height: 50),

                  Row(
                    children: [
                      Icon(
                        Icons.assignment_return_outlined,
                        color: AppColors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Returned items',
                        style: AppTextStyles.nameHeadingTextStyle(size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Quantity',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Price',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.black,
                  ),
                  for (int i = 0; i < productsDummyDataModelContent.length; i++)
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            productsDummyDataModelContent[i].name,
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'x${productsDummyDataModelContent[i].quantity}',
                            style: AppTextStyles.nameHeadingTextStyle(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Rs. ${productsDummyDataModelContent[i].price}',
                            style: AppTextStyles.belowMainHeadingTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Divider(
                    color: AppColors.black,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Quantity',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        'x26',
                        style: AppTextStyles.nameHeadingTextStyle(size: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Price',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '5000',
                        style: AppTextStyles.nameHeadingTextStyle(size: 18),
                      ),
                    ],
                  ),
                  //////////////////////
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: AppColors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Total',
                        style: AppTextStyles.nameHeadingTextStyle(size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total price',
                        style: AppTextStyles.nameHeadingTextStyle(size: 15),
                      ),
                      Text(
                        'Rs. 5000',
                        style: AppTextStyles.nameHeadingTextStyle(size: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
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
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
