import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Delivered/driver_end_trip_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/driver_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Category/driver_category_screen.dart';

class DriverHomepageScreen extends StatefulWidget {
  const DriverHomepageScreen({super.key});

  @override
  State<DriverHomepageScreen> createState() => _DriverHomepageScreenState();
}

class _DriverHomepageScreenState extends State<DriverHomepageScreen> {
  // int _selectedIndex = 0;
  // final List<Widget> _pages = [
  //   DriverCategoryScreen(),
  //   DriverWarehouseCartScreen(),
  //   DriverEndTripScreen(),
  // ];
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

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
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'My Cart',
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
                  return CupertinoPageScaffold(child: DriverCategoryScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: DriverWarehouseCartScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: DriverEndTripScreen());
                },
              );
          }
          return Container();
        });

    /////////////////////////////
    // return PopScope(
    //   canPop: false,
    //   child: Scaffold(
    //     body: Column(
    //       children: [
    //         Expanded(
    //           child: _pages[_selectedIndex],
    //         ),
    //       ],
    //     ),
    //     bottomNavigationBar: BottomNavigationBar(
    //       items: <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home_outlined),
    //           label: 'Home',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.shopping_cart_outlined),
    //           label: 'My Cart',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.check_circle),
    //           label: 'Delivered',
    //         ),
    //       ],
    //       currentIndex: _selectedIndex,
    //       selectedItemColor: AppColors.green,
    //       onTap: _onItemTapped,
    //     ),
    //   ),
    // );
  }
}
