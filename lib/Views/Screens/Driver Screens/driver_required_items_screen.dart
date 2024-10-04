import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverRequiredItemsScreen extends StatefulWidget {
  const DriverRequiredItemsScreen({super.key});

  @override
  State<DriverRequiredItemsScreen> createState() =>
      _DriverRequiredItemsScreenState();
}

class _DriverRequiredItemsScreenState extends State<DriverRequiredItemsScreen> {
  bool isProductSelected = false;
  int quantity = 1;
  int price = 200;
  @override
  Widget build(BuildContext context) {
    // List<String> productNames = [
    //   'Organic Ketchup',
    //   'Almond Butter',
    //   'Coconut Oil',
    //   'Quinoa',
    //   'Dark Chocolate',
    //   'Oat Milk',
    //   'Avocado Oil',
    //   'Chia Seeds',
    //   'Maple Syrup',
    //   'Brown Rice',
    // ];
    // List<int> productQuantities = [
    //   2, // Organic Ketchup
    //   1, // Almond Butter
    //   3, // Coconut Oil
    //   1, // Quinoa
    //   5, // Dark Chocolate
    //   4, // Oat Milk
    //   2, // Avocado Oil
    //   6, // Chia Seeds
    //   1, // Maple Syrup
    //   3, // Brown Rice
    // ];
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Required Items',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 30),
            // Text(
            //   'Inventory',
            //   style: AppTextStyles.mainHeadingTextStyle(),
            // ),
            // SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Flexible(
            //       child: Wrap(
            //         alignment: WrapAlignment.center,
            //         spacing: 5,
            //         runSpacing: 5,
            //         children: [
            //           for (int i = 0; i < 10; i++)
            //             Container(
            //               height: 40,
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 20, vertical: 10),
            //               decoration: BoxDecoration(
            //                 color: AppColors.lightGrey,
            //                 borderRadius: BorderRadius.circular(30),
            //               ),
            //               child: Text(
            //                 '${productNames[i]} (${productQuantities[i]})',
            //                 style:
            //                     AppTextStyles.belowMainHeadingTextStyle(),
            //               ),
            //             ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20),
            // Divider(
            //   color: AppColors.black,
            //   indent: 10,
            //   endIndent: 10,
            // ),
            SizedBox(height: 20),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'Select required items',
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
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green,
                          width: 2,
                        )),
                    child: Text(
                      'Tomato',
                      style: AppTextStyles.nameHeadingTextStyle(size: 15),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            ...List.generate(2, (index) {
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
                          'Organic Ketchup',
                          style: AppTextStyles.nameHeadingTextStyle(size: 15),
                        ),
                        Text(
                          '(4 available)',
                          style: AppTextStyles.nameHeadingTextStyle(
                            size: 13,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Rs. ${price * quantity}',
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
                                  activeColor: AppColors.green,
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
                                  quantity--;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  // size: 20,
                                  color: AppColors.green,
                                )),
                            Text(
                              quantity.toString(),
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                            IconButton(
                                onPressed: () {
                                  quantity++;
                                  setState(() {});
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.add_circle,
                                  color: AppColors.green,
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
            // SizedBox(height: 20),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => DriverReturnItemScreen()));
            //   },
            //   child: Align(
            //     alignment: Alignment.centerRight,
            //     child: Container(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //       decoration: BoxDecoration(
            //         border: Border.all(color: AppColors.green),
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       child: Text(
            //         "Return Items",
            //         style: AppTextStyles.nameHeadingTextStyle(size: 16),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: 20),
            UniversalButton(
                title: 'Add items',
                ontap: () {
                  customSnackbar(
                    context,
                    'Required items added to cart',
                  );
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
