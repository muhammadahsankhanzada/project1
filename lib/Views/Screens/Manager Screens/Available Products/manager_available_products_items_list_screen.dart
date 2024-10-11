import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_available_items_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_return_items_screen.dart';

class ManagerAvailableProductsItemsListScreen extends StatefulWidget {
  // final categoryIndex;
  const ManagerAvailableProductsItemsListScreen({
    super.key,
    // required this.categoryIndex,
  });

  @override
  State<ManagerAvailableProductsItemsListScreen> createState() =>
      _ManagerAvailableProductsItemsListScreenState();
}

class _ManagerAvailableProductsItemsListScreenState
    extends State<ManagerAvailableProductsItemsListScreen> {
  // int selectedCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    // selectedCategoryIndex = widget.categoryIndex;
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
                color: AppColors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
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
                                'New Items',
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
                                'Return Items',
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
                  ManagerAvailableProductsAvailableItemsScreen(
                      // categoryindex: selectedCategoryIndex,
                      ),
                  ManagerAvailableProductsReturnItemsScreen(),
                ]),
              ),
            ],
          ),
        ));
  }
}
