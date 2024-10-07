import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_create_new_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_delete_account_screen.dart';

class AdminAccountsManagementScreen extends StatelessWidget {
  const AdminAccountsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Accounts',
            style: AppTextStyles.nameHeadingTextStyle(),
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
                  'Accounts Management',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Manage user accounts, including creation, modification, and deletion, from a centralized interface.',
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 13),
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
              border: Border.all(
                color: AppColors.grey,
              ),
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
