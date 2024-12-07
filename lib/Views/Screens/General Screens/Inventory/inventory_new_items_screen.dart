import 'package:flutter/material.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Models/products_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/inventory_new_items_view_model.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class InventoryNewItemsScreen extends StatefulWidget {
  final categoryName;
  final int categoryindex;
  const InventoryNewItemsScreen({
    super.key,
    required this.categoryName,
    required this.categoryindex,
  });

  @override
  State<InventoryNewItemsScreen> createState() =>
      _InventoryNewItemsScreenState();
}

class _InventoryNewItemsScreenState extends State<InventoryNewItemsScreen> {
  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<InventoryNewItemsViewModel>(context, listen: false);
    viewModel.selectedCategoryIndex = widget.categoryindex;
    viewModel.selectedCategoryName = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Categories',
                style: AppTextStyles.simpleHeadingTextStyle(
                    fontSize: 20, textColor: AppColors.universalButtonGreen),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: _buildShowCategories(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _buildShowProducts(),
            ),
          ),
        ]),
      ),
    );
  }

  // Show categories in listview
  Widget _buildShowCategories() {
    return FutureBuilderHelperWidget<List<CategoriesModel>>(
      future: context.read<InventoryNewItemsViewModel>().fetchCategories(),
      onSuccess: (categories) {
        return Consumer<InventoryNewItemsViewModel>(
            builder: (context, value, child) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          value.updateCategory(index, category.name);
                        },
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: value.selectedCategoryIndex == index
                                  ? AppColors.loginBackground
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '${category.name} (${category.productsCount})',
                                style: AppTextStyles.nameHeadingTextStyle(
                                    size: 15),
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
        });
      },
      loadingWidget: _buildListViewLoading(),
      emptyWidget: Text('No Categories Found'),
      errorWidget: Text('Error Fetching Categories'),
    );
  }

  // Show products in gridview
  Widget _buildShowProducts() {
    return Consumer<InventoryNewItemsViewModel>(
        builder: (context, value, child) {
      return FutureBuilderHelperWidget<List<ProductModel>>(
        future: context.read<InventoryNewItemsViewModel>().fetchProducts(),
        onSuccess: (products) {
          return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  product.imageUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(ImageUrls.errorImage);
                                  },
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: EdgeInsets.only(right: 10, top: 10),
                              decoration: BoxDecoration(
                                color: AppColors.loginBackground,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '${product.quantity} available',
                                style: AppTextStyles.simpleHeadingTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        product.name,
                        style: AppTextStyles.nameHeadingTextStyle(
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        loadingWidget: _buildGridViewLoading(),
        emptyWidget: Text('No Products Found'),
        errorWidget: Text('Error Fetching Products'),
      );
    });
  }

  // Shimmer for listview loading
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
                      height: 35,
                      width: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
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
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }

  // Shimmer for gridview loading
  Widget _buildGridViewLoading() {
    return Shimmer.fromColors(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              );
            }),
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }
}
