import 'package:flutter/material.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_required_items_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_summary_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_items_list_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_items_list_and_cart_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/onboarding_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_shops_list_screen.dart';
import 'package:project1/Views/Screens/driver_required_and_return_items_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
