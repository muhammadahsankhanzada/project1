import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/Shop%20Return%20Items/salesman_store_return_category_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/Shop%20Required%20Items/salesman_store_required_category_screen.dart';

class SalesmanStoreRequiredAndReturnItemsScreen extends StatefulWidget {
  final VoidCallback goToShopCart;
  const SalesmanStoreRequiredAndReturnItemsScreen(
      {super.key, required this.goToShopCart});

  @override
  State<SalesmanStoreRequiredAndReturnItemsScreen> createState() =>
      _SalesmanStoreRequiredAndReturnItemsScreenState();
}

class _SalesmanStoreRequiredAndReturnItemsScreenState
    extends State<SalesmanStoreRequiredAndReturnItemsScreen> {
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
                      // UniversalButton(
                      //   title: 'Deliver',
                      //   buttonWidth: 80,
                      //   buttonHeight: 35,
                      //   buttonColor: AppColors.universalButtonGreen,
                      //   textSize: 15,
                      //   ontap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 DriverStoreCartScreen()));
                      //   },
                      // ),
                      SizedBox(width: 40),
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
                SalesmanRequiredCategoryScreen(),
                SalesmanStoreReturnCategoryScreen(),
              ]),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 50,
          width: 200,
          child: FloatingActionButton(
            onPressed: () {
              widget.goToShopCart();
              Navigator.pop(context);
            },
            child: Text(
              'Go to Cart',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontWeight: FontWeight.bold,
                textColor: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.universalButtonGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
