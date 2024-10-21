import 'package:flutter/material.dart';
import 'package:project1/Models/shops_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Shop%20Records/admin_shop_records_details_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_add_shop_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_delete_shop_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_registered_shops_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SuperAdminShopManagementScreen extends StatelessWidget {
  const SuperAdminShopManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Shop Management'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  customContainer(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuperAdminAddShopScreen()));
                    },
                    title: 'Add New Shop',
                  ),
                  customContainer(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SuperAdminDeleteShopScreen()));
                    },
                    title: 'Delete a Shop',
                  ),
                  customContainer(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SuperAdminRegisteredShopsScreen()));
                    },
                    title: 'Registered Shops',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Material(
            //   elevation: 4,
            //   borderRadius: BorderRadius.circular(10),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            //     decoration: BoxDecoration(
            //       color: AppColors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Text(
            //       'Registered Shops',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // Expanded(
            //     child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: shopsListContents.length,
            //         itemBuilder: (context, index) {
            //           return Column(
            //             children: [
            //               InkWell(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                               AdminShopRecordsDetailsScreen(
            //                                 shopName:
            //                                     shopsListContents[index].name,
            //                                 shopAddress:
            //                                     shopsListContents[index]
            //                                         .address,
            //                               )));
            //                 },
            //                 borderRadius: BorderRadius.circular(40),
            //                 child: Container(
            //                   width: double.infinity,
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 30, vertical: 15),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(40),
            //                     color: AppColors.white.withOpacity(.7),
            //                   ),
            //                   child: Row(
            //                     children: [
            //                       CircleAvatar(
            //                         backgroundImage: AssetImage(
            //                             shopsListContents[index].imageUrl),
            //                       ),
            //                       SizedBox(width: 15),
            //                       Expanded(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 SizedBox(
            //                                   width: 200,
            //                                   child: Text(
            //                                     overflow: TextOverflow.ellipsis,
            //                                     shopsListContents[index].name,
            //                                     style: AppTextStyles
            //                                         .nameHeadingTextStyle(
            //                                             size: 15),
            //                                   ),
            //                                 ),
            //                                 Row(
            //                                   children: [
            //                                     Text(
            //                                       'Address: ',
            //                                       style: TextStyle(
            //                                         fontWeight: FontWeight.w500,
            //                                       ),
            //                                     ),
            //                                     SizedBox(
            //                                       width: 150,
            //                                       child: Text(
            //                                           overflow:
            //                                               TextOverflow.ellipsis,
            //                                           shopsListContents[index]
            //                                               .address),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                             Icon(
            //                               Icons.assessment,
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 10),
            //             ],
            //           );
            //         })),
          ],
        ),
      ),
    );
  }

  //
  customContainer({
    required VoidCallback ontap,
    required String title,
    Color borderColor = AppColors.green,
    Color backgroundColor = AppColors.green,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  title,
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
