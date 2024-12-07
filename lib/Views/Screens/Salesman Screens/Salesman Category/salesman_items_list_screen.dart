import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_items_list_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<SalesmanItemsListViewModel>(context, listen: false);
    viewModel.selectedCategoryIndex = widget.categoryIndex;
    viewModel.selectedCategoryName = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(
        title: '',
      ),
      body: Column(
        children: [
          _buildShowCategories(),
          SizedBox(height: 10),
          _buildShowSearchBar(),
          SizedBox(height: 15),
          _buildShowProducts(),
        ],
      ),
    );
  }

  // Show categories list
  Widget _buildShowCategories() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        height: 35,
        width: double.infinity,
        child: FutureBuilderHelperWidget(
          future: context.read<SalesmanItemsListViewModel>().fetchCategories(),
          onSuccess: (categories) {
            return Consumer<SalesmanItemsListViewModel>(
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
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              value.updateSelectedCategory(
                                  index, category.name);
                              _searchController.text = '';
                            },
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: value.selectedCategoryIndex == index
                                      ? AppColors.lightGreen1
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  category.name,
                                  style: AppTextStyles.nameHeadingTextStyle(
                                      size: 15),
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
            });
          },
          loadingWidget: _buildListViewLoading(),
          emptyWidget: Text('No Categories Found'),
          errorWidget: Text('Error Getting Categories'),
        ),
      ),
    );
  }

  // Search bar
  Widget _buildShowSearchBar() {
    final viewModel =
        Provider.of<SalesmanItemsListViewModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: _searchController,
        onChanged: viewModel.onChanged,
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
    );
  }

  // Show products
  Widget _buildShowProducts() {
    return Expanded(
      child: SizedBox(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<SalesmanItemsListViewModel>(
                      builder: (context, value, child) {
                    return FutureBuilderHelperWidget(
                      future: value.fetchProducts(),
                      onSuccess: (products) {
                        // Filter shops based on the searchedText
                        final filter = products.where((product) {
                          final productName = (product.name).toLowerCase();
                          return productName.contains(value.searchedText);
                        }).toList();
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: filter.length,
                            itemBuilder: (context, index) {
                              final filteredProducts = filter[index];
                              final productId = filteredProducts.id;

                              value.initializeProductDetails(filteredProducts);
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
                                          child: Image.network(
                                            filteredProducts.imageUrl,
                                            fit: BoxFit.fill,
                                            width: 80,
                                            height: 120,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                fit: BoxFit.fill,
                                                ImageUrls.errorImage,
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
                                                filteredProducts.name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 10),
                                              ),
                                            ),
                                            Text(
                                              filteredProducts.isProductNew!
                                                  ? 'New'
                                                  : 'Old',
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
                                                  InkWell(
                                                    onTap: () {
                                                      value.updateQuantity(
                                                          productId, false);
                                                    },
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      size: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 18,
                                                    child: Center(
                                                      child: Text(
                                                        '${value.getProductQuantity(productId)}',
                                                        maxLines: 1,
                                                        style: AppTextStyles
                                                            .simpleHeadingTextStyle(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value.updateQuantity(
                                                          productId, true);
                                                    },
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      size: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                'Rs. ${(value.getProductPrice(productId) * value.getProductQuantity(productId)).toStringAsFixed(0)}/-',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
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
                                        buttonColor: AppColors.cartButton,
                                        textSize: 12,
                                        ontap: () {
                                          final now = DateTime.now();
                                          String dateTime =
                                              DateFormat('d MMM, hh:mm a')
                                                  .format(now);
                                          // DatabaseHelper.dbInstance
                                          //     .deleteTheDatabase(
                                          //         databaseName:
                                          //             TablesData.dbName);
                                          value.saveDataLocally(
                                            productId: productId,
                                            productName: filteredProducts.name,
                                            productImageUrl:
                                                filteredProducts.imageUrl,
                                            productType:
                                                filteredProducts.isProductNew!
                                                    ? 'New'
                                                    : 'Old',
                                            productQuantity: value
                                                .getProductQuantity(productId),
                                            productPrice: value
                                                .getProductPrice(productId),
                                            dateTime: dateTime,
                                          );

                                          customSnackbar(
                                            context,
                                            duration: Duration(seconds: 1),
                                            'Item added to cart',
                                          );
                                          print('Product Id: $productId');
                                          print(
                                              'Product ImageUrl: ${filteredProducts.imageUrl}');
                                          print(
                                              'Product Name: ${filteredProducts.name}');
                                          print(
                                              'Product Type: ${filteredProducts.isProductNew! ? 'New' : 'Old'}');
                                          print(
                                              'Product Quantity: ${value.getProductQuantity(productId)}');
                                          print(
                                              'Product Price: ${value.getProductPrice(productId)}');
                                          print(
                                              'Total Price: ${value.getProductPrice(productId) * value.getProductQuantity(productId)}');
                                        }),
                                  ],
                                ),
                              );
                            });
                      },
                      loadingWidget: _buildGridViewLoading(),
                      emptyWidget: Text('No Products Found'),
                      errorWidget: Text('Error Getting Products'),
                    );
                  }),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Listview loading
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
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(width: 10),
              ],
            );
          },
          scrollDirection: Axis.horizontal,
        ),
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }

  // Listview loading
  Widget _buildGridViewLoading() {
    return Shimmer.fromColors(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }

  // Method to fetch categories
  // Stream<QuerySnapshot> fetchCategories() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .snapshots();
  //   return data;
  // }

  // Method to fetch products
  // Stream<QuerySnapshot> fetchProducts() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .doc(context.read<SalesmanItemsListViewModel>().selectedCategoryName)
  //       .collection('Products')
  //       .snapshots();
  //   return data;
  // }

  // Method to add products to cart
  // addToCart(){
  //   FirebaseFirestore firestore= FirebaseFirestore.instance;
  //   firestore.collection('Users').doc('Staff').collection('Salesmen').doc('Muhammad Ahsan').collection('Requests').doc('').set();
  // }
}
