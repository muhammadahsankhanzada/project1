import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Category/salesman_items_list_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_profile_screen.dart';

class SalesmanHomepageScreen extends StatefulWidget {
  const SalesmanHomepageScreen({super.key});

  @override
  State<SalesmanHomepageScreen> createState() => _SalesmanHomepageScreenState();
}

class _SalesmanHomepageScreenState extends State<SalesmanHomepageScreen> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: AppColors.lightWhiteBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: fetchSalesmanDetails(),
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
                              child: Text('Record not Found'),
                            );
                          } else if (snapshot.hasData) {
                            final salesman =
                                snapshot.data?.data() as Map<String, dynamic>?;
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) =>
                                                SalesmanProfileScreen(
                                                  salesmanName:
                                                      salesman?['name'],
                                                )));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: AppColors.loginBackground
                                          .withOpacity(.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          // width: 40,
                                          // height: 40,
                                          salesman?['imageUrl'],
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              Constants.errorImage,
                                              fit: BoxFit.cover,
                                              // width: 40,
                                              // height: 40,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      salesman?['name'],
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 15),
                                    ),
                                    Text(
                                      'Salesman',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text('Loading...'),
                            );
                          }
                        }),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
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
                    fillColor: AppColors.grey.withOpacity(.2),
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
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(Constants.salesmanBannerImage)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 200,
                        //   child: Text(
                        //     'Celebrate the season with us',
                        //     style: AppTextStyles.simpleHeadingTextStyle(
                        //       fontSize: 25,
                        //       textColor: AppColors.white,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 200,
                        //   child: Text(
                        //     'Get discount up to 50% for every product',
                        //     style: AppTextStyles.simpleHeadingTextStyle(
                        //       fontSize: 12,
                        //       textColor: AppColors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Categories',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: fetchCategories(),
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
                            child: Text('No Categories Found'),
                          );
                        } else if (snapshot.hasData) {
                          final categories = snapshot.data?.docs ?? [];
                          return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // mainAxisSpacing: 20,
                                // crossAxisSpacing: 20,
                              ),
                              itemCount: categories.length,
                              // productCategoriesDummyModelContents.length,
                              itemBuilder: (context, index) {
                                // print(categories?[index]['imageUrl']);
                                return Container(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SalesmanItemsListScreen(
                                                          categoryName:
                                                              categories[index]
                                                                  ['name'],
                                                          // productCategoriesDummyModelContents[
                                                          //         index]
                                                          //     .name,
                                                          categoryIndex: index,
                                                        )));
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              // image: DecorationImage(
                                              //   fit: BoxFit.fill,
                                              //   image: NetworkImage(
                                              //     // productCategoriesDummyModelContents[
                                              //     //         index]
                                              //     //     .imageUrl,
                                              //     categories[index]['imageUrl'],
                                              //   ),
                                              // ),
                                              color: AppColors.white
                                                  .withOpacity(.9),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                categories[index]['imageUrl'],
                                                fit: BoxFit.fill,
                                                // width: 80,
                                                // height: 120,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    fit: BoxFit.cover,
                                                    Constants.errorImage,
                                                    // width: 80,
                                                    // height: 120,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        SizedBox(
                                          width: 100,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              categories[index]['name'],
                                              // productCategoriesDummyModelContents[
                                              //         index]
                                              //     .name,
                                              style: AppTextStyles
                                                  .nameHeadingTextStyle(
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Text('Loading...'),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to get salesman details
  Stream<DocumentSnapshot> fetchSalesmanDetails() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Salesmen')
        .doc('Muhammad Ahsan')
        .snapshots();
    return data;
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
}
