import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_end_trip_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_category_screen.dart';

class DriverHomepageScreen extends StatelessWidget {
  const DriverHomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     'Items and Cart',
          //     style: AppTextStyles.nameHeadingTextStyle(),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: AppColors.green,
          //   bottom: TabBar(
          //     tabs: [
          //       Tab(text: 'Items'),
          //       Tab(text: 'Cart'),
          //     ],
          //   ),
          // ),
          body: Column(
            children: [
              // SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(top: 20),
                color: AppColors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                      ],
                    ),
                    TabBar(
                      labelColor: AppColors.white,
                      labelStyle: AppTextStyles.nameHeadingTextStyle(),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.category),
                              SizedBox(width: 5),
                              Text(
                                'Categories',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 5),
                            Tab(
                              child: Text(
                                'Cart',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle),
                            SizedBox(width: 5),
                            Tab(
                              child: Text(
                                'Delivered',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  DriverCategoryScreen(),
                  DriverWarehouseCartScreen(),
                  DriverEndTripScreen(),
                ]),
              ),
            ],
          ),
        ));
  }
}
