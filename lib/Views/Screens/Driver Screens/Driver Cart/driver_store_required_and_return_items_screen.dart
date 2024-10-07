import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Final%20Order%20Summary/driver_store_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/driver_store_return_category_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_store_required_category_screen.dart';

class DriverStoreRequiredAndReturnItemsScreen extends StatelessWidget {
  const DriverStoreRequiredAndReturnItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              color: AppColors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(Constants.logoImage),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Ahsan Store',
                            style: AppTextStyles.nameHeadingTextStyle(),
                          ),
                          // SizedBox(width: 40),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DriverStoreCartScreen()));
                          },
                          child: Icon(Icons.shopping_cart_outlined)),
                    ],
                  ),
                  TabBar(
                    labelColor: AppColors.black,
                    labelStyle: AppTextStyles.nameHeadingTextStyle(),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.assignment_add),
                            SizedBox(width: 5),
                            Text(
                              'Required',
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_return_outlined),
                          SizedBox(width: 5),
                          Tab(
                            child: Text(
                              'Return',
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
                DriverRequiredCategoryScreen(),
                DriverStoreReturnCategoryScreen(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
