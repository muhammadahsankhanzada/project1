import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_check_reports_view_model.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_homepage_view_model.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_new_password_view_model.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_records_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/add_products_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/add_shop_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/add_warehouse_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/create_new_account_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_account_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/login_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/shop_records_details_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_approved_requests_details_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_approved_requests_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_homepage_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_pending_requests_details_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_pending_requests_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_product_collection_select_salesman_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_records_details_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_rejected_requests_details_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_rejected_requests_view_model.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/managers_list_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_cart_details_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_end_trip_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_homepage_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_items_list_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_records_details_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_records_view_model.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_warehouse_cart_view_model.dart';
import 'package:project1/View%20Models/auth_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/check_inventory_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_products_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_shop_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_warehouse_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/edit_products_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/inventory_new_items_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/inventory_new_and_return_items_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/inventory_return_items_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/registered_shops_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/registered_warehouses_view_model.dart';
import 'package:project1/View%20Models/Super%20Admin%20View%20Models/super_admin_home_view_model.dart';
import 'package:project1/View%20Models/Super%20Admin%20View%20Models/super_admin_reports_and_analytics_view_model.dart';
import 'package:project1/View%20Models/Super%20Admin%20View%20Models/super_admin_user_management_view_model.dart';
import 'package:project1/View%20Models/General%20View%20Models/warehouse_selection_view_model.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_bottom_nav_bar.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_bottom_nav_bar_screen.dart';
import 'package:project1/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Emulators
  if (FirebaseAuth.instance.app.options.projectId == 'project1-4ee2b') {
    // Auth emulator
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

    // Firestore emulator
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

    // Storage emulator
    FirebaseStorage.instance.useStorageEmulator('localhost', 9199);

    // Functions emulator
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // General Screens Providers
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SuperAdminHomeViewModel()),
        ChangeNotifierProvider(create: (_) => CreateNewAccountViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteAccountViewModel()),

        ChangeNotifierProvider(create: (_) => SalesmanHomepageViewModel()),
        ChangeNotifierProvider(create: (_) => SalesmanEndTripViewModel()),
        ChangeNotifierProvider(create: (_) => SalesmanItemsListViewModel()),
        ChangeNotifierProvider(create: (_) => SalesmanRecordsViewModel()),
        ChangeNotifierProvider(
            create: (_) => SalesmanRecordsDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => SalesmanWarehouseCartViewModel()),
        ChangeNotifierProvider(create: (_) => SalesmanCartDetailsViewModel()),

        ChangeNotifierProvider(create: (_) => ManagerHomepageViewModel()),
        ChangeNotifierProvider(create: (_) => ManagersListViewModel()),
        ChangeNotifierProvider(create: (_) => ManagerRecordsDetailsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerApprovedRequestsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerApprovedRequestsDetailsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerPendingRequestsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerPendingRequestsDetailsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerRejectedRequestsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerRejectedRequestsDetailsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ManagerProductCollectionSelectSalesmanViewModel()),

        ChangeNotifierProvider(create: (_) => AdminRecordsViewModel()),
        ChangeNotifierProvider(create: (_) => AdminHomepageViewModel()),
        ChangeNotifierProvider(create: (_) => AdminCheckReportsViewModel()),
        ChangeNotifierProvider(create: (_) => AdminNewPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => WarehouseSelectionViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductsViewModel()),
        ChangeNotifierProvider(create: (_) => EditProductsViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteProductsViewModel()),
        ChangeNotifierProvider(create: (_) => ShopRecordsDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => AddShopViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteShopViewModel()),
        ChangeNotifierProvider(create: (_) => RegisteredShopsViewModel()),
        ChangeNotifierProvider(create: (_) => AddWarehouseViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteWarehouseViewModel()),
        ChangeNotifierProvider(create: (_) => RegisteredWarehousesViewModel()),
        ChangeNotifierProvider(create: (_) => CheckInventoryViewModel()),
        ChangeNotifierProvider(
            create: (_) => InventoryNewAndReturnItemsViewModel()),

        ChangeNotifierProvider(create: (_) => InventoryNewItemsViewModel()),

        ChangeNotifierProvider(create: (_) => InventoryReturnItemsViewModel()),
        ChangeNotifierProvider(
            create: (_) => SuperAdminReportsAndAnalyticsViewModel()),
        ChangeNotifierProvider(
            create: (_) => SuperAdminUserManagementViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightGreen1),
          useMaterial3: true,
        ),
        // initialRoute:  RouteNames.login,
        // onGenerateRoute: Routes.generateRoute,
        home: SalesmanBottomNavBarScreen(),
      ),
    );
  }
}
