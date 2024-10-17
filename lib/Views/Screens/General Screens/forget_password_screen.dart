import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Reset Password',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Icon(
              Icons.shield,
              size: 100,
              color: AppColors.loginBackground.withOpacity(.3),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome!',
              style: AppTextStyles.nameHeadingTextStyle(
                size: 40,
                color: AppColors.lightGreen1,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 30, left: 30, top: 25),
                decoration: BoxDecoration(
                    color: AppColors.loginBackground.withOpacity(.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password Reset',
                          style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter Email',
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UniversalButton(
                              title: 'Confirm',
                              buttonWidth: 150,
                              buttonColor: AppColors.universalButtonGreen,
                              ontap: () {
                                customSnackbar(context,
                                    'Password reset request submitted.');
                              }),
                          UniversalButton(
                              title: 'Cancel',
                              buttonWidth: 150,
                              ontap: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
