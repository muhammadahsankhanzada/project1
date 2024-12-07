import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/login_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/forget_password_screen.dart';
import 'package:project1/Views/Widgets/universal_button_with_custom_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              width: 150,
              height: 150,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.loginBackground.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              child: Image.asset(ImageUrls.logoImage),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome Back!',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                textColor: AppColors.loginBackground,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 30, left: 30, top: 25),
                decoration: BoxDecoration(
                    color: AppColors.loginBackground.withOpacity(.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                width: screenWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login to your Account",
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter / Phone Number',
                          filled: true,
                          fillColor: AppColors.white,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: AppColors.white,
                          prefixIcon: Icon(
                            Icons.shield_outlined,
                            color: AppColors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordScreen()));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: AppTextStyles.belowMainHeadingTextStyle(
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Consumer<LoginViewModel>(
                          builder: (context, value, child) {
                        return UniversalButtonWithCustomWidget(
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.login(context, emailController.text,
                                    passwordController.text);
                              }
                            },
                            child: value.isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text('Login',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 15,
                                    )));
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
