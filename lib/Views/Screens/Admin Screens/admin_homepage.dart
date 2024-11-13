import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_accounts_management_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/check_inventory_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/Approved%20Requests/managers_list_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Shop%20Management/registered_shops_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Warehouse%20Management/registered_warehouses_screen.dart';

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
        'screen': CheckInventoryScreen(),
      },
      {
        'title': 'Salesman Records',
        'icon': Icons.directions_car,
        'screen': SalesmanRecordsScreen(),
      },
      {
        'title': 'Shop Records',
        'icon': Icons.shop,
        'screen': RegisteredShopsScreen(),
      },
      {
        'title': 'Manager Records',
        'icon': Icons.supervisor_account,
        'screen': ManagersListScreen(),
      },
      {
        'title': 'Warehouse Details',
        'icon': Icons.store,
        'screen': RegisteredWarehousesScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(
                    ImageUrls.myImage,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Admin',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Text(
              'Welcome!',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontWeight: FontWeight.bold,
                textColor: AppColors.red,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.grid_view_outlined,
                  color: AppColors.universalButtonGreen,
                ),
                SizedBox(width: 5),
                Text(
                  'Dashboard',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightWhiteBackground,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(30),
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
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1.7,
                                ),
                                // itemCount: data.length ~/ 3,

                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  final List<Map<String, dynamic>>
                                      reportsContainerData = [
                                    {
                                      'type': 'Sales',
                                      'amount': data['sales'],
                                      'percentage': data['salesPercentage'],
                                      'previousAmount': data['lastYearSales'],
                                    },
                                    {
                                      'type': 'Purchase',
                                      'amount': data['purchase'],
                                      'percentage': data['purchasePercentage'],
                                      'previousAmount':
                                          data['lastYearPurchase'],
                                    },
                                    {
                                      'type': 'Return',
                                      'amount': data['return'],
                                      'percentage': data['returnPercentage'],
                                      'previousAmount': data['lastYearReturn'],
                                    },
                                    {
                                      'type': 'Marketing',
                                      'amount': data['marketing'],
                                      'percentage': data['marketingPercentage'],
                                      'previousAmount':
                                          data['lastYearMarketing'],
                                    },
                                  ];
                                  // final data = infoContainerData[index];
                                  return customInfoContainer(
                                    type: reportsContainerData[index]['type'],
                                    percentage: reportsContainerData[index]
                                            ['percentage']
                                        .toString(),
                                    percentageColor: reportsContainerData[index]
                                                ['amount'] <
                                            reportsContainerData[index]
                                                ['previousAmount']
                                        ? AppColors.red
                                        : AppColors.green,
                                    amount: reportsContainerData[index]
                                            ['amount']
                                        .toString(),
                                    previousAmount: reportsContainerData[index]
                                            ['previousAmount']
                                        .toString(),
                                  );
                                });
                          } else {
                            return Center(
                              child: Text('Loading...'),
                            );
                          }
                        }),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         ...infoContainerData.map((info) {
                    //           return customInfoContainer(
                    //               info['type'],
                    //               info['percentage'],
                    //               info['amount'],
                    //               info['previousAmount']);
                    //         }).toList(),
                    //       ],
                    //     ),
                    //     SizedBox(height: 10),
                    //   ],
                    // ),
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
          borderRadius: BorderRadius.circular(10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.loginBackground,
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
                      textColor: AppColors.white,
                      fontWeight: FontWeight.bold,
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

  // Custom Container
  customInfoContainer({
    required String type,
    required String percentage,
    required String amount,
    required String previousAmount,
    Color percentageColor = AppColors.green,
  }) {
    return Container(
      width: 180,
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
                type,
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '+${percentage}%',
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: percentageColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '\$${amount}',
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
            '(\$${previousAmount} last year)',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 12,
            ),
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
        .collection('Admins')
        .doc('Ali')
        .collection('Reports')
        .doc('Dashboard Reports')
        .snapshots();
    return data;
  }
}
