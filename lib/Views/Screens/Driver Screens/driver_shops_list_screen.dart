import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_required_and_return_items_screen.dart';

class DriverShopsListScreen extends StatelessWidget {
  const DriverShopsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> productNames = [
      'Organic Ketchup',
      'Almond Butter',
      'Coconut Oil',
      'Quinoa',
      'Dark Chocolate',
      'Oat Milk',
      'Avocado Oil',
      'Chia Seeds',
      'Maple Syrup',
      'Brown Rice',
    ];
    List<int> productQuantities = [
      2, // Organic Ketchup
      1, // Almond Butter
      3, // Coconut Oil
      1, // Quinoa
      5, // Dark Chocolate
      4, // Oat Milk
      2, // Avocado Oil
      6, // Chia Seeds
      1, // Maple Syrup
      3, // Brown Rice
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Shops List',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
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
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DriverRequiredAndReturnItemsScreen()));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(Constants.logoImage),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Muhammad Ahsan Communications',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTextStyles.nameHeadingTextStyle(),
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Shah Faisal Colony, Shahra e Faisal Karachi',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
