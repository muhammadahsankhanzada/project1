import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_accounts_management_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/check_inventory_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Shop%20Management/registered_shops_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/Approved%20Requests/managers_list_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Warehouse%20Management/registered_warehouses_screen.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_product_management_screen.dart';

class AdminHomepageViewModel with ChangeNotifier {
  // Go to different screens buttons data
  final List<Map<String, Object>> options = [
    {
      'title': 'Accounts Management',
      'icon': Icons.person,
      'screen': AdminAccountsManagementScreen(),
    },
    {
      'title': 'Product Management',
      'icon': Icons.fastfood,
      'screen': SuperAdminProductManagementScreen(),
    },
    {
      'title': 'Check Inventory',
      'icon': Icons.inventory,
      'screen': CheckInventoryScreen(),
    },
    {
      'title': 'Salesman Records',
      'icon': Icons.directions_car,
      'screen': SalesmanRecordsScreen(),
    },
    {
      'title': 'Shop Records',
      'icon': Icons.shop,
      'screen': RegisteredShopsScreen(),
    },
    {
      'title': 'Manager Records',
      'icon': Icons.supervisor_account,
      'screen': ManagersListScreen(),
    },
    {
      'title': 'Warehouse Details',
      'icon': Icons.store,
      'screen': RegisteredWarehousesScreen(),
    },
  ];

  // Reports info containers data
  List<Map<String, dynamic>> showReportsData(Map<String, dynamic> data) {
    final List<Map<String, dynamic>> reportsContainerData = [
      {
        'type': 'Sales',
        'amount': data['sales'],
        'percentage': data['salesPercentage'],
        'previousAmount': data['lastYearSales'],
      },
      {
        'type': 'Purchase',
        'amount': data['purchase'],
        'percentage': data['purchasePercentage'],
        'previousAmount': data['lastYearPurchase'],
      },
      {
        'type': 'Return',
        'amount': data['return'],
        'percentage': data['returnPercentage'],
        'previousAmount': data['lastYearReturn'],
      },
      {
        'type': 'Marketing',
        'amount': data['marketing'],
        'percentage': data['marketingPercentage'],
        'previousAmount': data['lastYearMarketing'],
      },
    ];
    return reportsContainerData;
  }

  // Method to fetch dashboard reports
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchDashboardReports() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Management')
        .collection('Admins')
        .doc('Ali')
        .collection('Reports')
        .doc('Dashboard Reports')
        .snapshots();
    return data;
  }

  // Method to fetch admin details
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAdminDetails() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Management')
        .collection('Admins')
        .doc('Ali')
        .snapshots();
    return data;
  }
}
