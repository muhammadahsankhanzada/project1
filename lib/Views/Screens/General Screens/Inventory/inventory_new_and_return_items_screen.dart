import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/inventory_new_and_return_items_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/inventory_new_items_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/inventory_return_items_screen.dart';
import 'package:provider/provider.dart';

class InventoryNewAndReturnItemsScreen extends StatefulWidget {
  final int categoryIndex;
  final String categoryName;
  const InventoryNewAndReturnItemsScreen({
    super.key,
    required this.categoryIndex,
    required this.categoryName,
  });

  @override
  State<InventoryNewAndReturnItemsScreen> createState() =>
      _InventoryNewAndReturnItemsScreenState();
}

class _InventoryNewAndReturnItemsScreenState
    extends State<InventoryNewAndReturnItemsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<InventoryNewAndReturnItemsViewModel>().resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                color: AppColors.lightWhiteBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    SizedBox(height: 20),
                    Consumer<InventoryNewAndReturnItemsViewModel>(
                        builder: (context, value, child) {
                      return TabBar(
                        labelPadding: EdgeInsets.zero,
                        onTap: value.onTabChanged,
                        dividerColor: AppColors.transparent,
                        labelColor: AppColors.black,
                        unselectedLabelColor: AppColors.white,
                        labelStyle: AppTextStyles.simpleHeadingTextStyle(),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tabs: [
                          Container(
                            decoration: BoxDecoration(
                              color: value.selectedTabIndex == 0
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
                                    'New Items',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: value.selectedTabIndex == 1
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
                                    'Return Items',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  InventoryNewItemsScreen(
                    categoryName: widget.categoryName,
                    categoryindex: widget.categoryIndex,
                  ),
                  InventoryReturnItemsScreen(
                    categoryName: widget.categoryName,
                    categoryIndex: widget.categoryIndex,
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
