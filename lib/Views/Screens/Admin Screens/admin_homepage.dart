import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_check_reports_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_create_new_account_screen.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_delete_account_screen.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.admin_panel_settings),
              SizedBox(width: 10),
              Text('Admin Dashboard'),
            ],
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
                  'Welcome, Admin!',
                  style: AppTextStyles.nameHeadingTextStyle(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Let\'s manage controls and access.',
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AdminCreateNewAccountScreen()));
                  },
                  title: 'Create New Account',
                  icon: Icons.person),
              customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminDeleteAccountScreen()));
                  },
                  title: 'Delete an Account',
                  icon: Icons.delete),
              customContainer(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminCheckReportsScreen()));
                  },
                  title: 'Check Reports',
                  icon: Icons.assessment),
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
