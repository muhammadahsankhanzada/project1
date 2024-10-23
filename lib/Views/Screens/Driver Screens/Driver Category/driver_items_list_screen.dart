import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverItemsListScreen extends StatefulWidget {
  final String categoryName;
  final int categoryIndex;

  const DriverItemsListScreen({
    super.key,
    required this.categoryName,
    required this.categoryIndex,
  });

  @override
  State<DriverItemsListScreen> createState() => _DriverItemsListScreenState();
}

class _DriverItemsListScreenState extends State<DriverItemsListScreen> {
  var _searchController = TextEditingController();
  int quantity = 0;
  int selectedCategoryIndex = 0;

  // Initial Index of Category
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.categoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(
        title: productCategoriesDummyModelContents[selectedCategoryIndex].name,
      ),
      body: Column(
        children: [
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 10, left: 10),
          //     child: Text(
          //       'Categories',
          //       style: AppTextStyles.nameHeadingTextStyle(size: 20),
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),
          Container(
            height: 35,
            margin: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: ListView.builder(
              itemCount: productCategoriesDummyModelContents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });

                    // categoryBackgroundColor = AppColors.green;
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? AppColors.green
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      productCategoriesDummyModelContents[index].name,
                      style: AppTextStyles.nameHeadingTextStyle(size: 15),
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _searchController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                suffixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: SizedBox(
              // height: 570,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: productCategoriesDummyModelContents[
                                    selectedCategoryIndex]
                                .products
                                .length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 180,
                                padding: EdgeInsets.only(
                                    left: 10, right: 5, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            fit: BoxFit.fill,
                                            Constants.backgroundImage,
                                            width: 80,
                                            height: 120,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              child: Text(
                                                'Iphone 15 pro max',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 10),
                                              ),
                                            ),
                                            Text(
                                              'New',
                                              style: AppTextStyles
                                                  .simpleHeadingTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Container(
                                              width: 60,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.remove_circle,
                                                    size: 15,
                                                  ),
                                                  Text('0'),
                                                  Icon(
                                                    Icons.add_circle,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Rs. 95000/-',
                                              style: AppTextStyles
                                                  .simpleHeadingTextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Text(
                                              'Rate',
                                              style: AppTextStyles
                                                  .simpleHeadingTextStyle(
                                                      textColor: AppColors.red,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                for (int i = 0; i < 4; i++)
                                                  Icon(
                                                    Icons.star,
                                                    size: 13,
                                                  ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    UniversalButton(
                                        title: 'Add to Cart',
                                        buttonWidth: 120,
                                        buttonHeight: 35,
                                        buttonColor:
                                            AppColors.universalButtonGreen,
                                        textSize: 12,
                                        ontap: () {}),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   height: 50,
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //         Colors.transparent,
          //         Colors.transparent,
          //       ])),
          // ),
        ],
      ),
    );
  }
}
