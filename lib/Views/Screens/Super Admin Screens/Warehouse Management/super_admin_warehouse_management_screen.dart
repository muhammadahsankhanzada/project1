import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/Warehouse%20Management/add_warehouse_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Warehouse%20Management/registered_warehouses_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Warehouse%20Management/delete_warehouse_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SuperAdminWarehouseManagementScreen extends StatelessWidget {
  const SuperAdminWarehouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Warehouse Management'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                _buildCustomButton(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddWarehouseScreen()));
                  },
                  title: 'Add Warehouse',
                ),
                _buildCustomButton(
                  backgroundColor: AppColors.black,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteWarehouseScreen()));
                  },
                  title: 'Delete Warehouse',
                ),
                _buildCustomButton(
                  backgroundColor: AppColors.white,
                  textColor: AppColors.black,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisteredWarehousesScreen()));
                  },
                  title: 'Registered Warehouses',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Go to different screens
  Widget _buildCustomButton({
    required VoidCallback ontap,
    required String title,
    Color textColor = AppColors.white,
    Color backgroundColor = AppColors.loginBackground,
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
                    textColor: textColor,
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
