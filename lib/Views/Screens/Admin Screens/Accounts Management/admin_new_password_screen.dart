import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_new_password_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class AdminNewPasswordScreen extends StatefulWidget {
  const AdminNewPasswordScreen({super.key});

  @override
  State<AdminNewPasswordScreen> createState() => _AdminNewPasswordScreenState();
}

class _AdminNewPasswordScreenState extends State<AdminNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              _buildShowUserInfo(),
              SizedBox(height: 20),
              _buildEnterPasswordField(),
              SizedBox(height: 20),
              _buildChangePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Show user details
  Widget _buildShowUserInfo() {
    return Consumer<AdminNewPasswordViewModel>(
        builder: (context, value, child) {
      return Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(ImageUrls.myImage),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Muhammad Ahsan',
                style: AppTextStyles.nameHeadingTextStyle(size: 15),
              ),
              Text(
                'Warehouse Manager',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.lightGreen1.withOpacity(.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var key in value.userInfo.keys)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${key}:',
                          style: AppTextStyles.nameHeadingTextStyle(size: 15),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var value in value.userInfo.values)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          value.toString(),
                          style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 15),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  // Enter password field
  Widget _buildEnterPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          // controller: _newPasswordController,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Enter new password';
          //   }
          //   return null;
          // },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Enter New Password',
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            // suffixIcon: Icon(
            //   Icons.search,
            // ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  // Change password button
  Widget _buildChangePasswordButton() {
    return UniversalButton(
        title: 'Change Password',
        ontap: () {
          // if (_formKey.currentState!.validate()) {}
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    height: 200,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.lightGreen,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Change Password?',
                          style: AppTextStyles.nameHeadingTextStyle(),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Are you sure you want to change this user\'s password.',
                          style: AppTextStyles.belowMainHeadingTextStyle(),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UniversalButton(
                                title: 'Cancel',
                                buttonHeight: 40,
                                buttonWidth: 110,
                                buttonColor: AppColors.black,
                                ontap: () {
                                  Navigator.pop(context);
                                }),
                            UniversalButton(
                                title: 'Confirm',
                                buttonHeight: 40,
                                buttonWidth: 110,
                                buttonColor: AppColors.green,
                                ontap: () {
                                  Navigator.pop(context);

                                  customSnackbar(context, 'Password Changed.');
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
