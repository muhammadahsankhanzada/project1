import 'package:flutter/material.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_homepage.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_homepage.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/super_admin_homepage.dart';

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
      home: SuperAdminHomepage(),
    );
  }
}
