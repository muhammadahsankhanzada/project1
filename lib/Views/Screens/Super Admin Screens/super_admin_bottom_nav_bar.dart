import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_delivered_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Reports%20and%20Analytics/super_admin_reports_and_analytics_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/super_admin_homepage.dart';

class SuperAdminBottomNavBar extends StatelessWidget {
  const SuperAdminBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: AppColors.white,
          activeColor: AppColors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_outlined),
              label: 'Delivered',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: SuperAdminHomepage());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: SuperAdminReportsAndAnalyticsScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: ManagerDeliveredScreen());
                },
              );
          }
          return Container();
        });
  }
}
