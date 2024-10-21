import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
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
    final List<Map<String, dynamic>> reportsInfoContainerData = [
      {
        'title': 'Total Sales',
        'value': 234500,
        'percentage': 2.5,
      },
      {
        'title': 'Total Orders',
        'value': 5300,
        'percentage': 1.5,
      },
      {
        'title': 'Available Stock',
        'value': 4000,
        'percentage': 0.5,
      },
      {
        'title': 'Pending Orders',
        'value': 2000,
        'percentage': 3.5,
      },
    ];
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
      // {
      //   'title': 'Reports and Analytics',
      //   'icon': Icons.assessment,
      //   'screen': SuperAdminReportsAndAnalyticsScreen(),
      // },
      {
        'title': 'Warehouse Management',
        'icon': Icons.store,
        'screen': SuperAdminWarehouseManagementScreen(),
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(Constants.myImage),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Super Admin',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        textColor: AppColors.universalButtonGreen,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Dashboard',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    textColor: AppColors.universalButtonGreen,
                  ),
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
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightWhiteBackground),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overview',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('Monthly')),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.2,
                        ),
                        itemCount: reportsInfoContainerData.length,
                        itemBuilder: (context, index) {
                          final data = reportsInfoContainerData[index];
                          return reportsInfoContainer(
                            data['title'],
                            data['value'],
                            '+${data['percentage']}%',
                          );
                        }),
                    SizedBox(height: 10),
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
          borderRadius: BorderRadius.circular(15),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontSize: 15,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(width: 30),
                  // Icon(
                  //   icon,
                  //   color: AppColors.green,
                  // ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // Reports Container
  reportsInfoContainer(String title, value, percentage) {
    return Container(
      width: 180,
      padding: EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 13,
            ),
          ),
          // SizedBox(height: 5),
          Row(
            children: [
              Text(
                value.toString(),
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Text(
                percentage.toString(),
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
