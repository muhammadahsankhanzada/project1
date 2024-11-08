import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/super_admin_user_management_view_model.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_create_new_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_delete_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Manager%20Records/admin_manager_records_details_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Salesman%20Records/manager_salesman_records_details_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/User%20Management/super_admin_admin_records_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class SuperAdminUserManagementScreen extends StatefulWidget {
  const SuperAdminUserManagementScreen({super.key});

  @override
  State<SuperAdminUserManagementScreen> createState() =>
      _SuperAdminUserManagementScreenState();
}

class _SuperAdminUserManagementScreenState
    extends State<SuperAdminUserManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(
        title: 'User Management',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButtonContainer(
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
                  _buildButtonContainer(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminDeleteAccountScreen()));
                    },
                    buttonColor: AppColors.black,
                    title: 'Delete Account',
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Consumer<SuperAdminUserManagementViewModel>(
                builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        value.isUserSalesman = true;
                        value.isUserManager = false;
                        value.isUserAdmin = false;
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: value.isUserSalesman
                                ? AppColors.lightGreen1
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Salesmen',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        value.isUserSalesman = false;
                        value.isUserManager = true;
                        value.isUserAdmin = false;
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: value.isUserManager
                                ? AppColors.lightGreen1
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Managers',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        value.isUserSalesman = false;
                        value.isUserManager = false;
                        value.isUserAdmin = true;
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: value.isUserAdmin
                                ? AppColors.lightGreen1
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Admins',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 10),
            Consumer<SuperAdminUserManagementViewModel>(
                builder: (context, value, child) {
              return StreamBuilderHelperWidget(
                stream: value.fetchUserRecords(),
                onSuccess: (result) {
                  var data = result.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => value
                                                .isUserSalesman
                                            ? ManagerSalesmanRecordsDetailsScreen(
                                                salesmanName: data[index]
                                                    ['name'],
                                                salesmanRoute: data[index]
                                                    ['address'],
                                              )
                                            : value.isUserManager
                                                ? AdminManagerRecordsDetailsScreen(
                                                    managerName: data[index]
                                                        ['name'])
                                                : SuperAdminAdminRecordsScreen(
                                                    adminName: data[index]
                                                        ['name'],
                                                  )));
                              },
                              borderRadius: BorderRadius.circular(40),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: AppColors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: ClipOval(
                                          child: Image.network(
                                            data[index]['imageUrl'],
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                ImageUrls.errorImage,
                                              );
                                            },
                                          ),
                                        ),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    data[index]['name'],
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          data[index]
                                                              ['address']),
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
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      });
                },
                loadingWidget: CircularProgressIndicator(),
                errorWidget: Text('Error Fetching Records'),
                emptyWidget: Text('No Records Found'),
              );
            }),
          ],
        ),
      ),
    );
  }

  // For create and delete account buttons
  Widget _buildButtonContainer({
    required VoidCallback ontap,
    required String title,
    Color buttonColor = AppColors.loginBackground,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.white,
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
