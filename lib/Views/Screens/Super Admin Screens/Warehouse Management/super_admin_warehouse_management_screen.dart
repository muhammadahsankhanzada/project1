import 'package:flutter/material.dart';
import 'package:project1/Models/warehouses_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Warehouse%20Records/admin_warehouse_details_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_add_warehouse_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_remove_warehouse_screen.dart';

class SuperAdminWarehouseManagementScreen extends StatelessWidget {
  const SuperAdminWarehouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Warehouse Management',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(width: 15),
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SuperAdminRemoveWarehouseScreen()));
                  },
                  borderColor: AppColors.red,
                  title: 'Remove Warehouse',
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Available Warehouses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: warehousesDummyListContents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminWarehouseDetailsScreen(
                                            warehouseName:
                                                warehousesDummyListContents[
                                                        index]
                                                    .name,
                                          )));
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.white.withOpacity(.7),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.backgroundImage),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                warehousesDummyListContents[
                                                        index]
                                                    .name,
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Location: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      warehousesDummyListContents[
                                                              index]
                                                          .address),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.store,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    })),
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
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.nameHeadingTextStyle(size: 15),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
