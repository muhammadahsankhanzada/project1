import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_accounts_management_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_check_inventory_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_check_reports_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Manager%20Records/admin_managers_list_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Shop%20Records/admin_shop_records_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Warehouse%20Records/admin_warehouse_list_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Driver%20Records/manager_driver_records_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        'title': 'Accounts Management',
        'icon': Icons.person,
        'screen': AdminAccountsManagementScreen(),
      },
      {
        'title': 'Product Management',
        'icon': Icons.fastfood,
        'screen': SuperAdminProductManagementScreen(),
      },
      {
        'title': 'Check Inventory',
        'icon': Icons.inventory,
        'screen': AdminCheckInventoryScreen(),
      },
      {
        'title': 'Driver Records',
        'icon': Icons.directions_car,
        'screen': ManagerDriverRecordsScreen(),
      },
      {
        'title': 'Shop Records',
        'icon': Icons.shop,
        'screen': AdminShopRecordsScreen(),
      },
      {
        'title': 'Manager Records',
        'icon': Icons.supervisor_account,
        'screen': AdminManagersListScreen(),
      },
      {
        'title': 'Check Reports',
        'icon': Icons.assessment,
        'screen': AdminCheckReportsScreen(),
      },
      {
        'title': 'Warehouse Details',
        'icon': Icons.store,
        'screen': AdminWarehouseListScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.admin_panel_settings),
                  SizedBox(width: 10),
                  Text(
                    'Admin Dashboard',
                    style: AppTextStyles.nameHeadingTextStyle(),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));

                        customSnackbar(context, 'Logout');
                      },
                      child: Icon(Icons.logout)),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome, Admin!',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Let\'s manage controls and access.',
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
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(.2),
              // border: Border.all(
              //   color: AppColors.grey,
              // ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                SizedBox(width: 10),
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
