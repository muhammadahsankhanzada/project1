import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/available_products_model.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ManagerAvailableProductsAvailableItemsScreen extends StatefulWidget {
  final categoryName;
  final int categoryindex;
  const ManagerAvailableProductsAvailableItemsScreen({
    super.key,
    required this.categoryName,
    required this.categoryindex,
  });

  @override
  State<ManagerAvailableProductsAvailableItemsScreen> createState() =>
      _ManagerAvailableProductsAvailableItemsScreenState();
}

class _ManagerAvailableProductsAvailableItemsScreenState
    extends State<ManagerAvailableProductsAvailableItemsScreen> {
  int selectedCategoryIndex = 0;
  String selectedCategory = '';
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.categoryindex;
    selectedCategory = widget.categoryName;
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
            child: FutureBuilder(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: _buildListViewLoading());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No categories found.'));
                  }

                  final categories = snapshot.data!;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          selectedCategoryIndex = index;
                          selectedCategory = category.name;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    // margin: EdgeInsets.only(left: 5, right: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: selectedCategoryIndex == index
                                          ? AppColors.loginBackground
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${category.name} (${category.productsCount})',
                                        style:
                                            AppTextStyles.nameHeadingTextStyle(
                                                size: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  );
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: _buildGridViewLoading());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No products found.'));
                    }

                    final products = snapshot.data!;
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
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                NetworkImage(product.imageUrl)),
                                        color: AppColors.white.withOpacity(.9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        margin:
                                            EdgeInsets.only(right: 10, top: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.loginBackground,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          '${product.quantity} available',
                                          style: AppTextStyles
                                              .simpleHeadingTextStyle(
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
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  // Method to fetch products from firestore
  Future<List<AvailableProductsModel>> fetchProducts() async {
    List<AvailableProductsModel> products = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .doc(selectedCategory)
          .collection('Products')
          .get();

      for (var doc in querySnapshot.docs) {
        String productId = doc.id;

        final data = doc.data() as Map<String, dynamic>?;
        String name = data?['name'] ?? productId;
        String imageUrl = data?['imageUrl'] ?? '';
        int quantity = data?['quantity'];

        products.add(AvailableProductsModel(
            name: name, imageUrl: imageUrl, quantity: quantity));
      }
    } catch (error) {
      print('Error getting products: $error');
    }
    print(products);
    return products;
  }

  // Method to fetch categories
  Future<List<CategoriesModel>> fetchCategories() async {
    List<CategoriesModel> categories = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .get();

      for (var doc in querySnapshot.docs) {
        String categoryId = doc.id;
        // Fetch product count for each category
        QuerySnapshot productSnapshot = await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(categoryId)
            .collection('Products')
            .get();

        int productsCount = productSnapshot.docs.length;

        // Get category details

        final data = doc.data() as Map<String, dynamic>?;
        String name = data?['name'] ?? categoryId;
        String imageUrl = data?['imageUrl'] ?? '';

        categories.add(CategoriesModel(
            name: name, imageUrl: imageUrl, productsCount: productsCount));
      }
    } catch (error) {
      print('Error getting categories: $error');
    }
    return categories;
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
