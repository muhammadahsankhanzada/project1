import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_items_list_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Models/products_model.dart' as Product;

class AdminCheckInventoryScreen extends StatefulWidget {
  const AdminCheckInventoryScreen({super.key});

  @override
  State<AdminCheckInventoryScreen> createState() =>
      _AdminCheckInventoryScreenState();
}

class _AdminCheckInventoryScreenState extends State<AdminCheckInventoryScreen> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
    // showProducts();
  }

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
                child: FutureBuilder<List<CategoriesModel>>(
                    future: fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
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
                            onTap: () {
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerAvailableProductsItemsListScreen(
                                              categoryName: category.name,
                                              categoryIndex: index)));
                            },
                            borderRadius: BorderRadius.circular(20),
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
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: 2,
                                            )),
                                        child: Center(
                                          child: Text(
                                            '${category.name} (${category.productsCount})',
                                            style: AppTextStyles
                                                .nameHeadingTextStyle(size: 15),
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
              SizedBox(height: 10),
              FutureBuilder<List<CategoriesModel>>(
                  future: fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No categories found.'));
                    }

                    final categories = snapshot.data!;

                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ManagerAvailableProductsItemsListScreen(
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
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                category.imageUrl,
                                              )),
                                          color:
                                              AppColors.white.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // border: Border.all(),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 20, top: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.loginBackground,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          '${category.productsCount} Products',
                                          style: AppTextStyles
                                              .simpleHeadingTextStyle(
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
                  }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show Products data
  showProducts() {
    List<Product.ProductModel> products = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc('Fashion')
        .collection('Products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      products = querySnapshot.docs
          .map((doc) => Product.ProductModel.fromFirestore(doc))
          .toList();
      setState(() {
        for (int i = 0; i < products.length; i++) {
          print(products[i].name);
        }
      });
    }).catchError((error) {
      print('Error getting data: $error');
    });
  }

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
}
