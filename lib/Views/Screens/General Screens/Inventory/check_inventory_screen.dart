import 'package:flutter/material.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/check_inventory_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/inventory_new_and_return_items_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckInventoryScreen extends StatefulWidget {
  const CheckInventoryScreen({super.key});

  @override
  State<CheckInventoryScreen> createState() => _CheckInventoryScreenState();
}

class _CheckInventoryScreenState extends State<CheckInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Inventory'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Categories',
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.universalButtonGreen,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: _buildShowCategoriesInListView(),
              ),
              SizedBox(height: 10),
              _buildShowCategoriesInGridView(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Show categories in listview
  Widget _buildShowCategoriesInListView() {
    return FutureBuilderHelperWidget<List<CategoriesModel>>(
      future: context.read<CheckInventoryViewModel>().fetchCategories(),
      onSuccess: (categories) {
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InventoryNewAndReturnItemsScreen(
                                        categoryName: category.name,
                                        categoryIndex: index)));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.white,
                                width: 2,
                              )),
                          child: Center(
                            child: Text(
                              '${category.name} (${category.productsCount})',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            );
          },
          scrollDirection: Axis.horizontal,
        );
      },
      loadingWidget: _buildListViewLoading(),
      emptyWidget: Text('No Categories Found'),
      errorWidget: Text('Error Fetching Categories'),
    );
  }

  // Show categories in gridview
  Widget _buildShowCategoriesInGridView() {
    return FutureBuilderHelperWidget<List<CategoriesModel>>(
      future: context.read<CheckInventoryViewModel>().fetchCategories(),
      onSuccess: (categories) {
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  InventoryNewAndReturnItemsScreen(
                                    categoryName: category.name,
                                    categoryIndex: index,
                                  )));
                    },
                    child: Stack(
                      children: [
                        Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 150,
                            width: 180,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                fit: BoxFit.cover,
                                category.imageUrl,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    ImageUrls.errorImage,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 20, top: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.loginBackground,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '${category.productsCount} Products',
                              style: AppTextStyles.simpleHeadingTextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    category.name,
                    style: AppTextStyles.nameHeadingTextStyle(
                      size: 16,
                    ),
                  )
                ],
              );
            });
      },
      loadingWidget: _buildGridViewLoading(),
      emptyWidget: Text('No Categories Found'),
      errorWidget: Text('Error Fetching Categories'),
    );
  }

  // Loading effect for listview builder
  Widget _buildListViewLoading() {
    return Shimmer.fromColors(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.white,
                            width: 2,
                          )),
                      child: Center(
                        child: Text(
                          '',
                          style: AppTextStyles.nameHeadingTextStyle(size: 15),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            );
          },
          scrollDirection: Axis.horizontal,
        ),
        baseColor: AppColors.grey.withOpacity(.3),
        highlightColor: AppColors.grey.withOpacity(.1));
  }

  // Loading effect for gridview builder
  Widget _buildGridViewLoading() {
    return Shimmer.fromColors(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 150,
                    width: 180,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              );
            }),
        baseColor: AppColors.grey.withOpacity(.3),
        highlightColor: AppColors.grey.withOpacity(.1));
  }
}
