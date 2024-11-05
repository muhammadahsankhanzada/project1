import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_check_inventory_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_shop_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/User%20Management/super_admin_user_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_warehouse_management_screen.dart';

class SuperAdminHomepage extends StatefulWidget {
  const SuperAdminHomepage({super.key});

  @override
  State<SuperAdminHomepage> createState() => _SuperAdminHomepageState();
}

class _SuperAdminHomepageState extends State<SuperAdminHomepage> {
  String? selectedReportsValue = 'Monthly';
  final List<String> reportValuesList = ['Weekly', 'Monthly', 'Yearly'];

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
      'title': 'Warehouse Management',
      'icon': Icons.store,
      'screen': SuperAdminWarehouseManagementScreen(),
    },
    {
      'title': 'Inventory',
      'icon': Icons.store,
      'screen': AdminCheckInventoryScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: AssetImage(ImageUrls.myImage),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Super Admin',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        // textColor: AppColors.universalButtonGreen,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.grid_view,
                      size: 18,
                      color: AppColors.universalButtonGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Dashboard',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        // textColor: AppColors.universalButtonGreen,
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
                          // Reports DropDown
                          reportsDropDownButton(
                            currentSelectedValue: selectedReportsValue,
                            dropDownValuesList: reportValuesList,
                            onChanged: (String? newSelectedValue) {
                              selectedReportsValue = newSelectedValue;
                              setState(() {});
                              print(selectedReportsValue);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder(
                        stream: fetchDashboardReports(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.data() == null) {
                            return Center(
                              child: Text('No Reports Found'),
                            );
                          } else if (snapshot.data!.data()!.isEmpty) {
                            return Center(
                              child: Text('No Data'),
                            );
                          } else if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            print(data!);
                            return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2.2,
                                ),
                                itemCount: (data.length ~/ 2).toInt(),
                                itemBuilder: (context, index) {
                                  final List<Map<String, dynamic>>
                                      reportsInfoContainerData = [
                                    {
                                      'title': 'Total Sales',
                                      'value': data['sales'],
                                      'percentage': data['salesPercentage'],
                                    },
                                    {
                                      'title': 'Total Orders',
                                      'value': data['orders'],
                                      'percentage': data['ordersPercentage'],
                                    },
                                    {
                                      'title': 'Available Stock',
                                      'value': data['stock'],
                                      'percentage': data['stockPercentage'],
                                    },
                                    {
                                      'title': 'Pending Orders',
                                      'value': data['pendingOrders'],
                                      'percentage':
                                          data['pendingOrdersPercentage'],
                                    },
                                  ];
                                  return reportsInfoContainer(
                                    reportsInfoContainerData[index]['title'],
                                    reportsInfoContainerData[index]['value'],
                                    '+${reportsInfoContainerData[index]['percentage']}%',
                                  );
                                });
                          } else {
                            return Center(
                              child: Text('Loading...'),
                            );
                          }
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
                color: AppColors.loginBackground,
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

  // Method to fetch dashboard reports
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchDashboardReports() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Management')
        .collection('Super Admins')
        .doc('Zeeshan')
        .collection('Dashboard Reports')
        .doc(selectedReportsValue)
        .snapshots();
    return data;
  }

  reportsDropDownButton({
    required String? currentSelectedValue,
    required List<String> dropDownValuesList,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 35,
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentSelectedValue,
          onChanged: onChanged,
          items:
              dropDownValuesList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      value,
                      style: AppTextStyles.simpleHeadingTextStyle(fontSize: 15),
                    ),
                  ],
                ));
          }).toList(),
        ),
      ),
    );
  }
}
