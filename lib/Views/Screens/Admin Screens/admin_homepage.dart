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
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grid_view_outlined,
                        color: AppColors.universalButtonGreen,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Admin Dashboard',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Welcome!',
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
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
          backgroundColor: AppColors.lightWhiteBackground),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              // controller: _searchController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                suffixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    // SizedBox(height: 20),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'Welcome, Admin!',
                    //     style: AppTextStyles.nameHeadingTextStyle(),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'Let\'s manage controls and access.',
                    //     style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                    //   ),
                    // ),

                    SizedBox(height: 10),
                    for (int i = 0; i < 2; i++)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              customInfoContainer(),
                              customInfoContainer(),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
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
          ),
        ],
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
              color: AppColors.lightGreen1,
              // border: Border.all(
              //   color: AppColors.grey,
              // ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.simpleHeadingTextStyle(
                      textColor: AppColors.white),
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
        SizedBox(height: 10),
      ],
    );
  }

  // Custom Container
  customInfoContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Sales',
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '+2.5%',
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '\$27632',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Compared to',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '(\$21340 last year)',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
