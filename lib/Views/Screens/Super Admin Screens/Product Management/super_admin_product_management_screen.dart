import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Delete%20Products/manager_delete_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_edit_product_warehouse_selection_screen.dart';

class SuperAdminProductManagementScreen extends StatelessWidget {
  const SuperAdminProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Text(
            'Products',
            style: AppTextStyles.simpleHeadingTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColors.universalButtonGreen,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightWhiteBackground),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Products Management',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add, Edit, and Delete Products.',
                  style: AppTextStyles.simpleHeadingTextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: 20),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ManagerAddProductWarehouseSelectionScreen()));
                },
                title: 'Add Products',
                icon: Icons.add_card,
              ),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuperAdminEditProductWarehouseSelectionScreen()));
                },
                title: 'Edit Products',
                icon: Icons.edit,
              ),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ManagerDeleteProductWarehouseSelectionScreen()));
                },
                title: 'Delete Products',
                icon: Icons.delete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //

  customContainer(
      {required VoidCallback ontap,
      required String title,
      required IconData icon}) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.universalButtonGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    icon,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
