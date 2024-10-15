import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_check_inventory_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Delete%20Products/manager_delete_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Delete%20Products/manager_delete_products_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_edit_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_edit_products_screen.dart';

class SuperAdminProductManagementScreen extends StatelessWidget {
  const SuperAdminProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Product Management',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // customContainer(
          //     icon: Icons.visibility,
          //     ontap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => AdminCheckInventoryScreen()));
          //     },
          //     title: 'View All Products'),
          customContainer(
              icon: Icons.add_card,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ManagerAddProductWarehouseSelectionScreen()));
              },
              title: 'Add Products'),
          customContainer(
              icon: Icons.edit,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SuperAdminEditProductWarehouseSelectionScreen()));
              },
              title: 'Edit Products'),
          customContainer(
              icon: Icons.delete,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ManagerDeleteProductWarehouseSelectionScreen()));
              },
              title: 'Delete Products'),
          customContainer(
              icon: Icons.inventory,
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminCheckInventoryScreen()));
              },
              title: 'Inventory'),
        ],
      ),
    );
  }

  //
  customContainer({
    required VoidCallback ontap,
    required String title,
    required IconData icon,
    Color borderColor = AppColors.green,
  }) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(width: 50),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: ontap,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
