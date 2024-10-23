import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/driver_store_required_and_return_items_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverShopsListScreen extends StatelessWidget {
  const DriverShopsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Shops List'),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(Constants.myImage),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Ahsan Store',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTextStyles.simpleHeadingTextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
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
                                style: AppTextStyles.simpleHeadingTextStyle(
                                  fontSize: 12,
                                  // textColor: AppColors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            UniversalButton(
                                title: 'View All',
                                buttonWidth: 120,
                                buttonHeight: 45,
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverStoreRequiredAndReturnItemsScreen()));
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
