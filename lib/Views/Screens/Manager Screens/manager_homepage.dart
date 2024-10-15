import 'package:flutter/material.dart';
import 'package:project1/Models/manager_homepage_items.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Delete%20Products/manager_delete_product_warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Driver%20Records/manager_driver_records_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_requests_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class ManagerHomepage extends StatelessWidget {
  const ManagerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 10),
                    Text(
                      'Manager',
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
            backgroundColor: AppColors.green,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 25,
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
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Warehouse Manager',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.3,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
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
          border: Border.all(color: AppColors.green),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 60,
            ),
            SizedBox(height: 10),
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
