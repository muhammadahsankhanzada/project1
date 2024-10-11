import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

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
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            productCategoriesDummyModelContents[selectedCategoryIndex].name,
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
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
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()),
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
                                    crossAxisSpacing: 1),
                            itemCount: productCategoriesDummyModelContents[
                                    selectedCategoryIndex]
                                .products
                                .length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  Constants.backgroundImage)),
                                          color:
                                              AppColors.white.withOpacity(.9),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColors.white
                                                      .withOpacity(.9),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          onPressed: () {
                                                            if (productCategoriesDummyModelContents[
                                                                        selectedCategoryIndex]
                                                                    .products[
                                                                        index]
                                                                    .quantity >
                                                                0) {
                                                              productCategoriesDummyModelContents[
                                                                      selectedCategoryIndex]
                                                                  .products[
                                                                      index]
                                                                  .quantity--;
                                                              //
                                                              print(productCategoriesDummyModelContents[
                                                                      selectedCategoryIndex]
                                                                  .products[
                                                                      index]
                                                                  .quantity);
                                                              setState(() {});
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.remove_circle,
                                                            size: 20,
                                                          )),
                                                      Flexible(
                                                        child: Text(
                                                          productCategoriesDummyModelContents[
                                                                  selectedCategoryIndex]
                                                              .products[index]
                                                              .quantity
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .nameHeadingTextStyle(
                                                                  size: 15),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            productCategoriesDummyModelContents[
                                                                    selectedCategoryIndex]
                                                                .products[index]
                                                                .quantity++; //
                                                            print(productCategoriesDummyModelContents[
                                                                    selectedCategoryIndex]
                                                                .products[index]
                                                                .quantity);
                                                            setState(() {});
                                                          },
                                                          padding:
                                                              EdgeInsets.zero,
                                                          icon: Icon(
                                                            Icons.add_circle,
                                                            size: 20,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productCategoriesDummyModelContents[
                                                    selectedCategoryIndex]
                                                .products[index]
                                                .name,
                                            style: AppTextStyles
                                                .belowMainHeadingTextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${productCategoriesDummyModelContents[selectedCategoryIndex].products[index].price.toStringAsFixed(0)}',
                                            style: AppTextStyles
                                                .belowMainHeadingTextStyle(
                                                    fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }),
                        SizedBox(height: 50),
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
      floatingActionButton: SizedBox(
          width: 300,
          child: FloatingActionButton(
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'Add to Cart',
                style: AppTextStyles.nameHeadingTextStyle(),
              ),
              onPressed: () {
                customSnackbar(context, 'Items added to cart');
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
