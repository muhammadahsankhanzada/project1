import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Reports%20and%20Analytics/super_admin_reports_and_analytics_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_shop_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/User%20Management/super_admin_user_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_warehouse_management_screen.dart';

class SuperAdminHomepage extends StatelessWidget {
  const SuperAdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        'title': 'User Management',
        'icon': Icons.people,
        'screen': SuperAdminUserManagementScreen(),
      },
      {
        'title': 'Product Management',
        'icon': Icons.inventory,
        'screen': SuperAdminProductManagementScreen(),
      },
      {
        'title': 'Shop Management',
        'icon': Icons.shop,
        'screen': SuperAdminShopManagementScreen(),
      },
      {
        'title': 'Reports and Analytics',
        'icon': Icons.assessment,
        'screen': SuperAdminReportsAndAnalyticsScreen(),
      },
      {
        'title': 'Warehouse Management',
        'icon': Icons.store,
        'screen': SuperAdminWarehouseManagementScreen(),
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    color: AppColors.universalButtonGreen,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Super Admin Dashboard',
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      textColor: AppColors.universalButtonGreen,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     InkWell(
              //         onTap: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => LoginScreen()));

              //           customSnackbar(context, 'Logout');
              //         },
              //         child: Icon(Icons.logout)),
              //     SizedBox(width: 10),
              //   ],
              // ),
            ],
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightWhiteBackground),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome, Super Admin!',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'You can manage all controls and access.',
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              ...options.map((option) {
                return customContainer(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => option['screen']));
                    },
                    title: option['title'],
                    icon: option['icon']);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  customContainer(
      {required VoidCallback ontap,
      required String title,
      required IconData icon}) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.nameHeadingTextStyle(size: 15),
                ),
                SizedBox(width: 30),
                Icon(
                  icon,
                  color: AppColors.green,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
