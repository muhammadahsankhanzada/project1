import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_available_items_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_return_items_screen.dart';

class ManagerAvailableProductsItemsListScreen extends StatefulWidget {
  final int categoryIndex;
  const ManagerAvailableProductsItemsListScreen({
    super.key,
    required this.categoryIndex,
  });

  @override
  State<ManagerAvailableProductsItemsListScreen> createState() =>
      _ManagerAvailableProductsItemsListScreenState();
}

class _ManagerAvailableProductsItemsListScreenState
    extends State<ManagerAvailableProductsItemsListScreen> {
  int selectedCategoryIndex = 0;
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.categoryIndex;
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
                    TabBar(
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
                                  'New Items',
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
                                  'Return Items',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  ManagerAvailableProductsAvailableItemsScreen(
                    categoryindex: selectedCategoryIndex,
                  ),
                  ManagerAvailableProductsReturnItemsScreen(
                    categoryIndex: widget.categoryIndex,
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
