import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_items_list_and_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_shops_list_screen.dart';
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
    List<String> productNames = [
      'Organic Ketchup',
      'Almond Butter',
      'Coconut Oil',
      'Quinoa',
      'Dark Chocolate',
      'Oat Milk',
      'Avocado Oil',
      'Chia Seeds',
      'Maple Syrup',
      'Brown Rice',
    ];
    List<int> productQuantities = [
      2, // Organic Ketchup
      1, // Almond Butter
      3, // Coconut Oil
      1, // Quinoa
      5, // Dark Chocolate
      4, // Oat Milk
      2, // Avocado Oil
      6, // Chia Seeds
      1, // Maple Syrup
      3, // Brown Rice
    ];
    List<double> productPrices = [
      250.0, // Organic Ketchup
      500.0, // Almond Butter
      300.0, // Coconut Oil
      400.0, // Quinoa
      150.0, // Dark Chocolate
      200.0, // Oat Milk
      450.0, // Avocado Oil
      100.0, // Chia Seeds
      350.0, // Maple Syrup
      150.0, // Brown Rice
    ];
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
                ...List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Constants.logoImage,
                          width: 120,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Organic Ketchup',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                            Text(
                              '20 Packs',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  quantity--;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  // size: 20,
                                  color: AppColors.green,
                                )),
                            Text(
                              quantity.toString(),
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                            IconButton(
                                onPressed: () {
                                  quantity++;
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
                    for (int i = 0; i < productQuantities.length; i++)
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              productNames[i],
                              style: AppTextStyles.belowMainHeadingTextStyle(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'x${productQuantities[i]}',
                              style: AppTextStyles.nameHeadingTextStyle(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Rs. ${productPrices[i]}',
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
                                          DriverItemsListAndCartScreen()));
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
                                            DriverItemsListAndCartScreen()));
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
