import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Delivered/salesman_end_trip_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/salesman_shops_list_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/salesman_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Category/salesman_homepage_screen.dart';

class SalesmanBottomNavBarScreen extends StatefulWidget {
  const SalesmanBottomNavBarScreen({super.key});

  @override
  State<SalesmanBottomNavBarScreen> createState() =>
      _SalesmanBottomNavBarScreenState();
}

class _SalesmanBottomNavBarScreenState
    extends State<SalesmanBottomNavBarScreen> {
  //     @override
  // void initState() {
  //   super.initState();
  //   checkStartTrip();
  // }
  ///
  final CupertinoTabController _tabController = CupertinoTabController();
  void goToShopsTab() {
    _tabController.index = 2;
    // Navigator.push(context,
    //     CupertinoPageRoute(builder: (context) => DriverStoreCartScreen()));
  }

  // Future<bool?> checkStartTrip()async{
  //     var sp = await SharedPreferences.getInstance();
  //                        return   sp.getBool('tripStarted');
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: _tabController,
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
              icon: Icon(Icons.store_outlined),
              label: 'Shops',
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
                  return CupertinoPageScaffold(child: SalesmanHomepageScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: SalesmanWarehouseCartScreen(
                    startTripButtonTapped: goToShopsTab,
                  ));
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: SalesmanShopsListScreen(
                    isTripStarted: true,
                  ));
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: SalesmanEndTripScreen());
                },
              );
            default:
              return Container();
          }
          // return Container();
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
