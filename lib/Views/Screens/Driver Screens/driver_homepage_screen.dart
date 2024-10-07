import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Delivered/driver_end_trip_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/driver_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Category/driver_category_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class DriverHomepageScreen extends StatelessWidget {
  const DriverHomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: PopScope(
          canPop: false,
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
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(Constants.logoImage),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Wick',
                                    style:
                                        AppTextStyles.belowMainHeadingTextStyle(
                                            fontSize: 18),
                                  ),
                                  Text(
                                    'Driver',
                                    style:
                                        AppTextStyles.belowMainHeadingTextStyle(
                                            fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));

                                    customSnackbar(context, 'Logout');
                                  },
                                  child: Icon(Icons.logout)),
                              SizedBox(width: 30),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TabBar(
                        labelColor: AppColors.white,
                        labelStyle: AppTextStyles.nameHeadingTextStyle(),
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.grid_view),
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
          ),
        ));
  }
}
