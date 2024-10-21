import 'package:flutter/material.dart';
import 'package:project1/Models/manager_homepage_items.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Delete%20Products/manager_delete_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Driver%20Records/manager_driver_records_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_requests_screen.dart';

class ManagerHomepage extends StatelessWidget {
  const ManagerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.lightWhiteBackground,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      color: AppColors.universalButtonGreen,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Manager',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
            backgroundColor: AppColors.lightWhiteBackground,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      Constants.myImage,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Robert Williamson',
                        style: AppTextStyles.nameHeadingTextStyle(size: 13),
                      ),
                      Text(
                        'Warehouse Manager',
                        style:
                            AppTextStyles.simpleHeadingTextStyle(fontSize: 13),
                      ),
                    ],
                  )
                ],
              ),
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
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(Constants.managerBack)),
                        ),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.9,
                            crossAxisCount: 2,
                            // mainAxisSpacing: 5,
                            // crossAxisSpacing: 5,
                          ),
                          itemCount: managerHomepageContents.length,
                          itemBuilder: (context, index) {
                            return categoryContainer(() {
                              if (index % 6 == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerPendingRequestsScreen()));
                              }
                              if (index % 6 == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerApprovedRequestsScreen()));
                              }
                              if (index % 6 == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerAddProductWarehouseSelectionScreen()));
                              }
                              if (index % 6 == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerDeleteProductWarehouseSelectionScreen()));
                              }
                              if (index % 6 == 4) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerAvailableProductsScreen()));
                              }
                              if (index % 6 == 5) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagerDriverRecordsScreen()));
                              }
                            }, managerHomepageContents[index].image,
                                managerHomepageContents[index].title);
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

categoryContainer(VoidCallback ontap, String image, String title) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   image,
            //   width: 100,
            //   height: 60,
            // ),
            // SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}
