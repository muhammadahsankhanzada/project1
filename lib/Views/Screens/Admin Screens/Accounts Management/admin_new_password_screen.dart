import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class AdminNewPasswordScreen extends StatefulWidget {
  const AdminNewPasswordScreen({super.key});

  @override
  State<AdminNewPasswordScreen> createState() => _AdminNewPasswordScreenState();
}

class _AdminNewPasswordScreenState extends State<AdminNewPasswordScreen> {
  Map<String, dynamic> driverDetails = {
    'Warehouse': 'Warehouse 01',
    'CNIC': '45402-6789012-3',
    'Phone Number': '0304-1234567',
    'Address': 'Shah Faisal Colony, Karachi',
    'Email': 'ahsan@gmail.com',
    'Password': '12345',
    'Age': 24,
    'Requests Approved': '30',
    'Requests Rejected': '10',
  };
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
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Constants.myImage),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen1.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var key in driverDetails.keys)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${key}:',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var value in driverDetails.values)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              value.toString(),
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Material(
                  elevation: 3,
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
                      hintText: 'Enter New Password',
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      // suffixIcon: Icon(
                      //   Icons.search,
                      // ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              UniversalButton(
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
                                    style: AppTextStyles
                                        .belowMainHeadingTextStyle(),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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

                                            customSnackbar(
                                                context, 'Password Changed.');
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
