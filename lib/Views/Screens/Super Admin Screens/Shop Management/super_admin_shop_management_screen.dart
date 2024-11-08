import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  _buildCustomButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuperAdminAddShopScreen()));
                    },
                    title: 'Add Shop',
                  ),
                  _buildCustomButton(
                    backgroundColor: AppColors.black,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SuperAdminDeleteShopScreen()));
                    },
                    title: 'Delete Shop',
                  ),
                  _buildCustomButton(
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black,
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
          ],
        ),
      ),
    );
  }

  // Go to different screens button
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
