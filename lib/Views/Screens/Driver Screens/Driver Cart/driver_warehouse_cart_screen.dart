import 'package:flutter/material.dart';
import 'package:project1/Models/cart_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/driver_cart_details_screen.dart';
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
      backgroundColor: AppColors.lightWhiteBackground,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Your Orders',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                textColor: AppColors.universalButtonGreen,
              ),
            ),
            SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightGreen1,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Active Orders',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 12,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: AppColors.lightGreen1,
                      ),
                      SizedBox(height: 10),
                      ...List.generate(driverCartContents.length, (index) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    Constants.backgroundImage,
                                    height: 80,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                driverCartContents[index].name,
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                'New',
                                                style: AppTextStyles
                                                    .belowMainHeadingTextStyle(
                                                        fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              // width: 80,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                '29 Nov, 01:20 pm',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.lightGrey
                                                        .withOpacity(.3)),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        if (driverCartContents[
                                                                    index]
                                                                .quantity >
                                                            0) {
                                                          driverCartContents[
                                                                  index]
                                                              .quantity--;
                                                          setState(() {});
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.remove_circle,
                                                        size: 20,
                                                      )),
                                                  Text(
                                                    driverCartContents[index]
                                                        .quantity
                                                        .toString(),
                                                    style: AppTextStyles
                                                        .nameHeadingTextStyle(
                                                            size: 15),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        driverCartContents[
                                                                index]
                                                            .quantity++;
                                                        setState(() {});
                                                      },
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(
                                                        Icons.add_circle,
                                                        size: 20,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                'Rs. ${(driverCartContents[index].price * driverCartContents[index].quantity).toStringAsFixed(0)}/-',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 15),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              '1 item(s)',
                                              style: AppTextStyles
                                                  .simpleHeadingTextStyle(
                                                      fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: AppColors.lightGreen1,
                              )
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: 10),
                      UniversalButton(
                          title: 'Confirm',
                          buttonColor: AppColors.universalButtonGreen,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DriverCartDetailsScreen()));
                          }),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
