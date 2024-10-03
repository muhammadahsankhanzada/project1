import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_items_list_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_warehouse_cart_screen.dart';

class DriverItemsListAndCartScreen extends StatelessWidget {
  const DriverItemsListAndCartScreen({super.key});

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
                      labelColor: AppColors.black,
                      labelStyle: AppTextStyles.nameHeadingTextStyle(),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.list),
                              SizedBox(width: 5),
                              Text(
                                'Items',
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
                  DriverItemsListScreen(),
                  DriverWarehouseCartScreen(),
                ]),
              ),
            ],
          ),
        ));
  }
}
