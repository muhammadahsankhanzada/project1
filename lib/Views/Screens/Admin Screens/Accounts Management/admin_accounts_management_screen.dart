import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_create_new_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_delete_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_password_reset_requests_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminAccountsManagementScreen extends StatelessWidget {
  const AdminAccountsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Accounts'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Accounts Management',
                  style: AppTextStyles.belowMainHeadingTextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Manage user accounts, including creation, modification, and deletion.',
                  style: AppTextStyles.simpleHeadingTextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: 20),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminCreateNewAccountScreen()));
                },
                title: 'Create New Account',
                icon: Icons.person,
              ),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDeleteAccountScreen()));
                },
                title: 'Delete an Account',
                icon: Icons.delete,
              ),
              customContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdminPasswordResetRequestsScreen()));
                },
                title: 'Password Reset Requests',
                icon: Icons.lock,
              ),
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
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.white,
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
}
