import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerProductCollectionProductsScreen extends StatefulWidget {
  final String warehouseName;
  final String salesmanName;

  const ManagerProductCollectionProductsScreen({
    super.key,
    required this.warehouseName,
    required this.salesmanName,
  });

  @override
  State<ManagerProductCollectionProductsScreen> createState() =>
      _ManagerProductCollectionProductsScreenState();
}

class _ManagerProductCollectionProductsScreenState
    extends State<ManagerProductCollectionProductsScreen> {
  int selectedCategoryIndex = 0;
  bool isProductSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Product Collection'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              child: Text(
                'Categories',
                style: AppTextStyles.nameHeadingTextStyle(size: 20),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: ListView.builder(
              itemCount: productCategoriesDummyModelContents.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            selectedCategoryIndex = index;
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: selectedCategoryIndex == index
                                    ? AppColors.loginBackground
                                    : AppColors.white,
                              ),
                              child: Center(
                                child: Text(
                                  productCategoriesDummyModelContents[index]
                                      .name,
                                  style: AppTextStyles.nameHeadingTextStyle(
                                      size: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ...List.generate(
                      productCategoriesDummyModelContents[selectedCategoryIndex]
                          .products
                          .length, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen1.withOpacity(.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              ImageUrls.backgroundImage,
                              width: 100,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                productCategoriesDummyModelContents[
                                        selectedCategoryIndex]
                                    .products[index]
                                    .name,
                                style: AppTextStyles.simpleHeadingTextStyle(
                                    fontSize: 14),
                              ),
                              Text(
                                'New',
                                style: AppTextStyles.nameHeadingTextStyle(
                                  size: 13,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Rs. ${(productCategoriesDummyModelContents[selectedCategoryIndex].products[index].price * productCategoriesDummyModelContents[selectedCategoryIndex].products[index].quantity).toStringAsFixed(0)}/-',
                                style: AppTextStyles.belowMainHeadingTextStyle(
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Row(
                              //   children: [
                              //     Transform.scale(
                              //       scale: 1.5,
                              //       child: Checkbox(
                              //           activeColor: AppColors.green,
                              //           value: isProductSelected,
                              //           onChanged: (bool? value) {
                              //             setState(() {
                              //               isProductSelected = value!;
                              //             });
                              //           }),
                              //     )
                              //   ],
                              // ),
                              Row(
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (productCategoriesDummyModelContents[
                                                    selectedCategoryIndex]
                                                .products[index]
                                                .quantity >
                                            0) {
                                          productCategoriesDummyModelContents[
                                                  selectedCategoryIndex]
                                              .products[index]
                                              .quantity--;
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                      )),
                                  Text(
                                    productCategoriesDummyModelContents[
                                            selectedCategoryIndex]
                                        .products[index]
                                        .quantity
                                        .toString(),
                                    style: AppTextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        productCategoriesDummyModelContents[
                                                selectedCategoryIndex]
                                            .products[index]
                                            .quantity++;
                                        setState(() {});
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.add_circle,
                                      )),
                                ],
                              ),
                              // UniversalButton(
                              //   title: 'Add',
                              //   buttonWidth: 100,
                              //   buttonHeight: 35,
                              //   buttonColor: AppColors.universalButtonGreen,
                              //   textSize: 15,
                              //   ontap: () {},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  UniversalButton(
                      title: 'Collect and Update',
                      buttonColor: AppColors.green,
                      ontap: () {
                        customSnackbar(
                          context,
                          'Inventory updated successfully',
                        );
                      }),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
