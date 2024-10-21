import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_bottom_nav_bar_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_bottom_nav_bar.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_homepage.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/super_admin_bottom_nav_bar.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightGreen1),
        useMaterial3: true,
      ),
      home: AdminBottomNavBarScreen(),
    );
  }
}
