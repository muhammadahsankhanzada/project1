import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Category/driver_items_list_screen.dart';

class DriverCategoryScreen extends StatefulWidget {
  const DriverCategoryScreen({super.key});

  @override
  State<DriverCategoryScreen> createState() => _DriverCategoryScreenState();
}

class _DriverCategoryScreenState extends State<DriverCategoryScreen> {
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
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Constants.myImage),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Wick',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                            Text(
                              'Driver',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                          image: AssetImage(Constants.driverBack)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Celebrate the season with us',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 25,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Get discount up to 50% for every product',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 12,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Categories',
                        style: AppTextStyles.simpleHeadingTextStyle(),
                      ),
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // mainAxisSpacing: 20,
                        // crossAxisSpacing: 20,
                      ),
                      itemCount: productCategoriesDummyModelContents.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DriverItemsListScreen(
                                                  categoryName:
                                                      productCategoriesDummyModelContents[
                                                              index]
                                                          .name,
                                                  categoryIndex: index,
                                                )));
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              productCategoriesDummyModelContents[
                                                      index]
                                                  .imageUrl)),
                                      color: AppColors.white.withOpacity(.9),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    productCategoriesDummyModelContents[index]
                                        .name,
                                    style: AppTextStyles.nameHeadingTextStyle(
                                      size: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
