import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/forgetPassword.json', width: 200),
              Text(
                'Request a Password Reset',
                style: AppTextStyles.nameHeadingTextStyle(),
              ),
              SizedBox(height: 30),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              SizedBox(height: 30),
              UniversalButton(
                  title: 'Reset Password',
                  ontap: () {
                    customSnackbar(
                        context, 'Password reset request submitted.');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
