import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/salesman_store_required_and_return_items_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SalesmanShopsListScreen extends StatefulWidget {
  final VoidCallback goToShopCart;
  final isTripStarted;
  const SalesmanShopsListScreen(
      {super.key, required this.isTripStarted, required this.goToShopCart});

  @override
  State<SalesmanShopsListScreen> createState() =>
      _SalesmanShopsListScreenState();
}

class _SalesmanShopsListScreenState extends State<SalesmanShopsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Shops List'),
      body: widget.isTripStarted == true
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: 30),
                    // Text(
                    //   'Inventory',
                    //   style: AppTextStyles.mainHeadingTextStyle(),
                    // ),
                    // SizedBox(height: 20),
                    // Row(
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
                    //                 style: AppTextStyles.belowMainHeadingTextStyle(),
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
                    // ),
                    SizedBox(height: 20),
                    for (int i = 0; i < 5; i++)
                      Column(
                        children: [
                          Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.containerBackground,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        width: 100,
                                        ImageUrls.myImage,
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 50,
                                    //   backgroundImage: AssetImage(Constants.myImage),
                                    // ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            'Ahsan Store',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppTextStyles
                                                .simpleHeadingTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              // textColor: AppColors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            'Shah Faisal Colony, Shahra e Faisal Karachi',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: AppTextStyles
                                                .simpleHeadingTextStyle(
                                              fontSize: 12,
                                              // textColor: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        UniversalButton(
                                            title: 'View All',
                                            buttonWidth: 120,
                                            buttonHeight: 35,
                                            textSize: 15,
                                            ontap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalesmanStoreRequiredAndReturnItemsScreen(
                                                            goToShopCart: widget
                                                                .goToShopCart,
                                                          )));
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                'Trip not started yet...',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
