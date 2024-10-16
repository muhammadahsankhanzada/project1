import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/Models/cart_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_homepage_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/driver_shops_list_screen.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverWarehouseCartScreen extends StatefulWidget {
  const DriverWarehouseCartScreen({super.key});

  @override
  State<DriverWarehouseCartScreen> createState() =>
      _DriverWarehouseCartScreenState();
}

class _DriverWarehouseCartScreenState extends State<DriverWarehouseCartScreen> {
  bool isRequestButtonClicked = false;
  bool isRequestApproved = false;

  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                ...List.generate(driverCartContents.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Constants.logoImage,
                          width: 120,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      driverCartContents[index].name,
                                      style: AppTextStyles.nameHeadingTextStyle(
                                          size: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      'Rs. ${(driverCartContents[index].price * driverCartContents[index].quantity).toStringAsFixed(0)}',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (driverCartContents[index].quantity >
                                            0) {
                                          driverCartContents[index].quantity--;
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                        // size: 20,
                                        color: AppColors.green,
                                      )),
                                  Text(
                                    driverCartContents[index]
                                        .quantity
                                        .toString(),
                                    style: AppTextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        driverCartContents[index].quantity++;
                                        setState(() {});
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: AppColors.green,
                                        // size: 20,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Order Summary',
                      style: AppTextStyles.mainHeadingTextStyle(),
                    ),
                    SizedBox(height: 15),
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
                    for (int i = 0; i < driverCartContents.length; i++)
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              driverCartContents[i].name,
                              style: AppTextStyles.belowMainHeadingTextStyle(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'x${driverCartContents[i].quantity}',
                              style: AppTextStyles.nameHeadingTextStyle(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Rs. ${(driverCartContents[i].price * driverCartContents[i].quantity).toStringAsFixed(0)}',
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
                    SizedBox(height: 60),
                    Align(
                      alignment: Alignment.center,
                      child: isRequestButtonClicked
                          ? Lottie.asset(
                              !isRequestApproved
                                  ? 'assets/animations/waiting.json'
                                  : 'assets/animations/approved.json',
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            )
                          : SizedBox(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: isRequestButtonClicked
                          ? Text(
                              !isRequestApproved
                                  ? 'Waiting for Approval...'
                                  : 'Request Approved',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 20),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: !isRequestButtonClicked,
                        child: UniversalButton(
                            title: 'Request',
                            ontap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: Container(
                                        height: 200,
                                        width: 300,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: AppColors.lightGreen,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20),
                                            Text(
                                              'Request Order',
                                              style: AppTextStyles
                                                  .nameHeadingTextStyle(),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              'Are you sure you want to request these items.',
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
                                                      isRequestButtonClicked =
                                                          true;
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                      Future.delayed(
                                                          Duration(seconds: 7),
                                                          () {
                                                        isRequestApproved =
                                                            true;
                                                        setState(() {});
                                                      });

                                                      // Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             DriverSummaryScreen()));
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
                    ),
                    Visibility(
                      visible: isRequestButtonClicked && !isRequestApproved,
                      child: Align(
                        alignment: Alignment.center,
                        child: UniversalButton(
                            title: 'Cancel Request',
                            buttonColor: AppColors.red.withOpacity(.7),
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DriverHomepageScreen()));
                            }),
                      ),
                    ),
                    SizedBox(height: 40),
                    if (isRequestApproved)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UniversalButton(
                              buttonWidth: 150,
                              title: 'Start trip',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriverShopsListScreen()));
                              }),
                          UniversalButton(
                              buttonColor: AppColors.red.shade300,
                              buttonWidth: 150,
                              title: 'Cancel',
                              ontap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriverHomepageScreen()));
                              }),
                        ],
                      ),
                    SizedBox(height: 40),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
