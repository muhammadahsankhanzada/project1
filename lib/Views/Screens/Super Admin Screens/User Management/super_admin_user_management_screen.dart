import 'package:flutter/material.dart';
import 'package:project1/Models/admins_list_dummy_model.dart';
import 'package:project1/Models/driver_list_dummy_model.dart';
import 'package:project1/Models/manager_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_create_new_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_delete_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Manager%20Records/admin_manager_records_details_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Driver%20Records/manager_driver_records_details_screen.dart';

class SuperAdminUserManagementScreen extends StatefulWidget {
  const SuperAdminUserManagementScreen({super.key});

  @override
  State<SuperAdminUserManagementScreen> createState() =>
      _SuperAdminUserManagementScreenState();
}

class _SuperAdminUserManagementScreenState
    extends State<SuperAdminUserManagementScreen> {
  bool isUserDriver = true;
  bool isUserManager = false;
  bool isUserAdmin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'User Management',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AdminCreateNewAccountScreen()));
                  },
                  title: 'Create Account',
                ),
                SizedBox(width: 15),
                customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminDeleteAccountScreen()));
                  },
                  borderColor: AppColors.red,
                  title: 'Delete Account',
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isUserDriver = true;
                        isUserManager = false;
                        isUserAdmin = false;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            AppColors.white.withOpacity(isUserDriver ? .7 : .5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Drivers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isUserDriver = false;
                        isUserManager = true;
                        isUserAdmin = false;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white
                            .withOpacity(isUserManager ? .7 : .5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Managers'),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isUserDriver = false;
                        isUserManager = false;
                        isUserAdmin = true;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            AppColors.white.withOpacity(isUserAdmin ? .7 : .5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Admins'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: isUserDriver
                        ? driversListContents.length
                        : isUserManager
                            ? managersListContents.length
                            : adminsListContents.length,
                    itemBuilder: (context, index) {
                      String name;
                      String address;
                      if (isUserDriver) {
                        name = driversListContents[index].name;
                        address = driversListContents[index].address;
                      } else if (isUserManager) {
                        name = managersListContents[index].name;
                        address = managersListContents[index].address;
                      } else {
                        name = adminsListContents[index].name;
                        address = adminsListContents[index].address;
                      }
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => isUserDriver
                                          ? ManagerDriverRecordsDetailsScreen(
                                              driverName: name,
                                              driverRoute: address,
                                            )
                                          : isUserManager
                                              ? AdminManagerRecordsDetailsScreen(
                                                  managerName: name)
                                              : ManagerDriverRecordsDetailsScreen(
                                                  driverName: name,
                                                  driverRoute: address)));
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.white.withOpacity(.7),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.myImage),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                name,
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Address: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      address),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.assessment,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    })),
          ],
        ),
      ),
    );
  }

  //
  customContainer({
    required VoidCallback ontap,
    required String title,
    Color borderColor = AppColors.green,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.nameHeadingTextStyle(size: 15),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
