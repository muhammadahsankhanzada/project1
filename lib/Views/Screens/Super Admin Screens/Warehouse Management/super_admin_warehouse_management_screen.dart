import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_add_warehouse_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_registered_warehouses_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_remove_warehouse_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SuperAdminWarehouseManagementScreen extends StatelessWidget {
  const SuperAdminWarehouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Warehouse Management'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuperAdminAddWarehouseScreen()));
                  },
                  title: 'Add Warehouse',
                ),
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuperAdminRemoveWarehouseScreen()));
                  },
                  title: 'Remove Warehouse',
                ),
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuperAdminRegisteredWarehousesScreen()));
                  },
                  title: 'Registered Warehouses',
                ),
              ],
            ),
            // SizedBox(height: 20),
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
            //       'Registered Warehouses',
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
            //         itemCount: warehousesDummyListContents.length,
            //         itemBuilder: (context, index) {
            //           return Column(
            //             children: [
            //               InkWell(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                               AdminWarehouseDetailsScreen(
            //                                 warehouseName:
            //                                     warehousesDummyListContents[
            //                                             index]
            //                                         .name,
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
            //                         backgroundImage:
            //                             AssetImage(Constants.backgroundImage),
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
            //                                     warehousesDummyListContents[
            //                                             index]
            //                                         .name,
            //                                     style: AppTextStyles
            //                                         .nameHeadingTextStyle(
            //                                             size: 15),
            //                                   ),
            //                                 ),
            //                                 Row(
            //                                   children: [
            //                                     Text(
            //                                       'Location: ',
            //                                       style: TextStyle(
            //                                         fontWeight: FontWeight.w500,
            //                                       ),
            //                                     ),
            //                                     SizedBox(
            //                                       width: 150,
            //                                       child: Text(
            //                                           overflow:
            //                                               TextOverflow.ellipsis,
            //                                           warehousesDummyListContents[
            //                                                   index]
            //                                               .address),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                             Icon(
            //                               Icons.store,
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
              // width: 200,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: backgroundColor,
                // border: Border.all(
                //   color: borderColor,
                //   width: 2,
                // ),
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
