import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_homepage.dart';
import 'package:project1/Views/Screens/General%20Screens/forget_password_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_homepage_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_homepage.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/super_admin_homepage.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Login',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/login.json',
                width: 200,
                fit: BoxFit.fill,
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    // color: AppColors.white,
                    ),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(right: 20, left: 20),
                  width: screenWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login to your Account",
                          style: AppTextStyles.mainHeadingTextStyle(),
                        ),
                        SizedBox(height: 30),
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
                            hintText: 'Email',
                            hintStyle:
                                AppTextStyles.nameHeadingTextStyle(size: 15),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
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
                            hintStyle:
                                AppTextStyles.nameHeadingTextStyle(size: 15),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: AppColors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
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
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        UniversalButton(
                            ontap: () {
                              // if (_formKey.currentState!.validate()) {
                              //   // login();
                              //   if (emailController.text == 'driver' &&
                              //       passwordController.text == '123') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 DriverHomepageScreen()));
                              //   }
                              //   if (emailController.text == 'manager' &&
                              //       passwordController.text == '123') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 ManagerHomepage()));
                              //   }
                              //   if (emailController.text == 'admin' &&
                              //       passwordController.text == '123') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 AdminHomepage()));
                              //   }
                              //   if (emailController.text == 'superadmin' &&
                              //       passwordController.text == '123') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 SuperAdminHomepage()));
                              //   }
                              // }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManagerHomepage()));
                            },
                            title: 'Login'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Login Function
  login() async {
    isLoading = true;
    setState(() {});
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );

    //   // To store data locally
    //   final data = await FirestoreDatabaseMethods.getUserDataFromFirebase(
    //       emailController.text);
    //   if (data != null) {
    //     SharedPrefsHelper.setUserId(data['Id']);
    //     SharedPrefsHelper.setUserName(data['Name']);
    //     SharedPrefsHelper.setUserEmail(data['Email']);
    //     SharedPrefsHelper.setUserWallet(data['Wallet']);
    //     SharedPrefsHelper.setUserProfilePic(data['ProfilePic']);
    //   } else {}

    //   isLoading = false;
    //   setState(() {});
    //   Navigator.pushReplacementNamed(context, RouteNames.bottomNavBarScreen);
    //   CustomSnackbar.customSnackbar(context, 'Login Successful');
    // } on FirebaseException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     isLoading = false;
    //     setState(() {});
    //     CustomSnackbar.customSnackbar(context, 'User not found',
    //         backgroundColor: AppColors.red);
    //   } else if (e.code == 'invalid-email') {
    //     isLoading = false;
    //     setState(() {});
    //     CustomSnackbar.customSnackbar(context, 'Invalid Email',
    //         backgroundColor: AppColors.red);
    //   } else if (e.code == 'wrong-password') {
    //     isLoading = false;
    //     setState(() {});
    //     CustomSnackbar.customSnackbar(context, 'Invalid Password',
    //         backgroundColor: AppColors.red);
    //   } else if (e.code == 'invalid-credential') {
    //     isLoading = false;
    //     setState(() {});
    //     CustomSnackbar.customSnackbar(context, 'Invalid Username/Password',
    //         backgroundColor: AppColors.red);
    //   } else {
    //     isLoading = false;
    //     setState(() {});
    //     CustomSnackbar.customSnackbar(context, e.code,
    //         backgroundColor: AppColors.red);
    //   }
    // }
  }
}
