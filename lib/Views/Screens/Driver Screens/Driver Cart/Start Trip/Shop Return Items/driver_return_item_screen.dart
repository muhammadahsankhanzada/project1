import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverReturnItemScreen extends StatefulWidget {
  final categoryIndex;
  const DriverReturnItemScreen({
    super.key,
    required this.categoryIndex,
  });

  @override
  State<DriverReturnItemScreen> createState() => _DriverReturnItemScreenState();
}

class _DriverReturnItemScreenState extends State<DriverReturnItemScreen> {
  bool isProductSelected = false;
  int selectedCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.categoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red.shade100,
      appBar: AppBar(
          title: Text(
            'Return Items',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'Select return items',
            //     style: AppTextStyles.nameHeadingTextStyle(),
            //   ),
            // ),
            // SizedBox(height: 20),
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
                  return InkWell(
                    onTap: () {
                      selectedCategoryIndex = index;
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: selectedCategoryIndex == index
                              ? AppColors.green
                              : AppColors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.red,
                            width: 2,
                          )),
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
            ...List.generate(
                productCategoriesDummyModelContents[selectedCategoryIndex]
                    .products
                    .length, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Constants.logoImage,
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productCategoriesDummyModelContents[
                                  selectedCategoryIndex]
                              .products[index]
                              .name,
                          style: AppTextStyles.nameHeadingTextStyle(size: 15),
                        ),
                        Text(
                          '(${productCategoriesDummyModelContents[selectedCategoryIndex].products[index].quantity} available)',
                          style: AppTextStyles.nameHeadingTextStyle(
                            size: 13,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Rs. ${(productCategoriesDummyModelContents[selectedCategoryIndex].products[index].price * productCategoriesDummyModelContents[selectedCategoryIndex].products[index].quantity).toStringAsFixed(0)}',
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 13, textColor: AppColors.green),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  activeColor: AppColors.red.shade400,
                                  value: isProductSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isProductSelected = value!;
                                    });
                                  }),
                            )
                          ],
                        ),
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
                                  // size: 20,
                                  color: AppColors.red.shade400,
                                )),
                            Text(
                              productCategoriesDummyModelContents[
                                      selectedCategoryIndex]
                                  .products[index]
                                  .quantity
                                  .toString(),
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
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
                                  color: AppColors.red.shade400,
                                  // size: 20,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 20),
            UniversalButton(
                title: 'Return items',
                ontap: () {
                  customSnackbar(
                    context,
                    'Return items added to cart',
                  );
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
