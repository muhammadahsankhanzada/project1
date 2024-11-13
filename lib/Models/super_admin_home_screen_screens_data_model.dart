import 'package:flutter/material.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/check_inventory_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Shop%20Management/super_admin_shop_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/User%20Management/super_admin_user_management_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Warehouse%20Management/super_admin_warehouse_management_screen.dart';

class SuperAdminHomeScreenScreensDataModel {
  final String title;
  final IconData icon;
  final Widget screen;

  SuperAdminHomeScreenScreensDataModel({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

final List<SuperAdminHomeScreenScreensDataModel>
    superAdminScreensDataModelContents = [
  SuperAdminHomeScreenScreensDataModel(
    title: 'User Management',
    icon: Icons.people,
    screen: SuperAdminUserManagementScreen(),
  ),
  SuperAdminHomeScreenScreensDataModel(
    title: 'Product Management',
    icon: Icons.inventory,
    screen: SuperAdminProductManagementScreen(),
  ),
  SuperAdminHomeScreenScreensDataModel(
    title: 'Shop Management',
    icon: Icons.shop,
    screen: SuperAdminShopManagementScreen(),
  ),
  SuperAdminHomeScreenScreensDataModel(
    title: 'Warehouse Management',
    icon: Icons.store,
    screen: SuperAdminWarehouseManagementScreen(),
  ),
  SuperAdminHomeScreenScreensDataModel(
    title: 'Inventory',
    icon: Icons.store,
    screen: CheckInventoryScreen(),
  ),
];
