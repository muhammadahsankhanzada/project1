import 'package:flutter/material.dart';
import 'package:project1/Utils/Routes/route_names.dart';
import 'package:project1/Views/Screens/General%20Screens/forget_password_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case RouteNames.forgetPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => ForgetPasswordScreen());

      default:
        MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      );
    });
  }
}
