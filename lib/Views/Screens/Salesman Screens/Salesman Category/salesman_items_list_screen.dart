import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SalesmanItemsListScreen extends StatefulWidget {
  final String categoryName;
  final int categoryIndex;

  const SalesmanItemsListScreen({
    super.key,
    required this.categoryName,
    required this.categoryIndex,
  });

  @override
  State<SalesmanItemsListScreen> createState() =>
      _SalesmanItemsListScreenState();
}

class _SalesmanItemsListScreenState extends State<SalesmanItemsListScreen> {
  var _searchController = TextEditingController();
  int quantity = 1;
  String selectedCategoryName = '';
  int selectedCategoryIndex = 0;
  String searchedText = '';

  void _onChanged(String value) {
    setState(() {
      searchedText = value.toLowerCase();
    });
  }

  // Initial Index of Category
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.categoryIndex;
    selectedCategoryName = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(
        title: '',
        // title: productCategoriesDummyModelContents[selectedCategoryIndex].name,
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
          // SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Container(
              height: 35,
              // margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              child: StreamBuilder(
                  stream: fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: Text('No Categories Found'),
                      );
                    } else if (snapshot.hasData) {
                      final categories = snapshot.data?.docs ?? [];

                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      setState(() {
                                        selectedCategoryIndex = index;
                                        selectedCategoryName =
                                            categories[index]['name'];
                                        searchedText = '';
                                        _searchController.text = '';
                                      });

                                      // categoryBackgroundColor = AppColors.green;
                                    },
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        // margin: EdgeInsets.only(left: 5, right: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: selectedCategoryIndex == index
                                              ? AppColors.lightGreen1
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          categories[index]['name'],
                                          style: AppTextStyles
                                              .nameHeadingTextStyle(size: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(width: 10),
                            ],
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      );
                    } else {
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                  }),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _searchController,
              onChanged: _onChanged,
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
                        StreamBuilder(
                            stream: fetchProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (!snapshot.hasData) {
                                return Center(
                                  child: Text('No Products Found'),
                                );
                              } else if (snapshot.hasData) {
                                final products = snapshot.data?.docs ?? [];
                                // print(products.length);
                                // Filter shops based on the searchedText
                                final filteredProducts =
                                    products.where((product) {
                                  final productName =
                                      (product['name'] ?? '').toLowerCase();
                                  return productName.contains(searchedText);
                                }).toList();
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15),
                                    itemCount: filteredProducts.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 180,
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 5,
                                            top: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                  child: Image.network(
                                                    filteredProducts[index]
                                                        ['imageUrl'],
                                                    fit: BoxFit.fill,
                                                    width: 80,
                                                    height: 120,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        fit: BoxFit.fill,
                                                        Constants.errorImage,
                                                        width: 80,
                                                        height: 120,
                                                      );
                                                    },
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
                                                        filteredProducts[index]
                                                            ['name'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (quantity >
                                                                  1) {
                                                                quantity--;
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          Text(quantity
                                                              .toString()),
                                                          InkWell(
                                                            onTap: () {
                                                              quantity++;
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              Icons.add_circle,
                                                              size: 15,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rs. ${((filteredProducts[index]['price'] as double) * quantity).toStringAsFixed(0)}/-',
                                                      style: AppTextStyles
                                                          .simpleHeadingTextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      'Rate',
                                                      style: AppTextStyles
                                                          .simpleHeadingTextStyle(
                                                              textColor:
                                                                  AppColors.red,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 4;
                                                            i++)
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
                                                    AppColors.cartButton,
                                                textSize: 12,
                                                ontap: () {
                                                  customSnackbar(
                                                    context,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    'Item added to cart',
                                                  );
                                                }),
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Text('Loading...'),
                                );
                              }
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

  // Method to fetch categories
  Stream<QuerySnapshot> fetchCategories() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .snapshots();
    return data;
  }

  // Method to fetch products
  Stream<QuerySnapshot> fetchProducts() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryName)
        .collection('Products')
        .snapshots();
    return data;
  }

  // Method to add products to cart
  // addToCart(){
  //   FirebaseFirestore firestore= FirebaseFirestore.instance;
  //   firestore.collection('Users').doc('Staff').collection('Salesmen').doc('Muhammad Ahsan').collection('Requests').doc('').set();
  // }
}
