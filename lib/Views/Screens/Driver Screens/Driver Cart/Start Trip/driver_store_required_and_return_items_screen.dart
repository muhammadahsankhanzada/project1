import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Final%20Order%20Summary/driver_store_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Return%20Items/driver_store_return_category_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Required%20Items/driver_store_required_category_screen.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverStoreRequiredAndReturnItemsScreen extends StatefulWidget {
  const DriverStoreRequiredAndReturnItemsScreen({super.key});

  @override
  State<DriverStoreRequiredAndReturnItemsScreen> createState() =>
      _DriverStoreRequiredAndReturnItemsScreenState();
}

class _DriverStoreRequiredAndReturnItemsScreenState
    extends State<DriverStoreRequiredAndReturnItemsScreen> {
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightWhiteBackground,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Icon(Icons.arrow_back),
                          )),
                      Text(
                        'Ahsan Store',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.universalButtonGreen,
                        ),
                      ),
                      UniversalButton(
                        title: 'Deliver',
                        buttonWidth: 80,
                        buttonHeight: 35,
                        buttonColor: AppColors.universalButtonGreen,
                        textSize: 15,
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DriverStoreCartScreen()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        onTap: _onTabChanged,
                        dividerColor: AppColors.transparent,
                        labelColor: AppColors.black,
                        unselectedLabelColor: AppColors.white,
                        labelStyle: AppTextStyles.simpleHeadingTextStyle(),
                        indicator: BoxDecoration(
                          // color: AppColors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tabs: [
                          Container(
                            decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? AppColors.lightWhiteBackground
                                  : AppColors.black,
                              border: Border.all(),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            child: Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: AppColors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Required',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? AppColors.lightWhiteBackground
                                  : AppColors.black,
                              border: Border.all(),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 5),
                                Tab(
                                  child: Text(
                                    'Return',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
