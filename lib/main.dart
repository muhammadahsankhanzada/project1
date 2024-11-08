import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/View%20Models/add_products_view_model.dart';
import 'package:project1/View%20Models/add_shop_view_model.dart';
import 'package:project1/View%20Models/add_warehouse_view_model.dart';
import 'package:project1/View%20Models/admin_create_new_account_view_model.dart';
import 'package:project1/View%20Models/admin_delete_account_view_model.dart';
import 'package:project1/View%20Models/auth_view_model.dart';
import 'package:project1/View%20Models/delete_products_view_model.dart';
import 'package:project1/View%20Models/delete_shop_view_model.dart';
import 'package:project1/View%20Models/edit_products_view_model.dart';
import 'package:project1/View%20Models/super_admin_home_view_model.dart';
import 'package:project1/View%20Models/super_admin_user_management_view_model.dart';
import 'package:project1/View%20Models/warehouse_selection_view_model.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/super_admin_bottom_nav_bar.dart';
import 'package:project1/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider(create: (_) => SuperAdminHomeViewModel()),
        ChangeNotifierProvider(create: (_) => AdminCreateNewAccountViewModel()),
        ChangeNotifierProvider(create: (_) => AdminDeleteAccountViewModel()),
        ChangeNotifierProvider(create: (_) => WarehouseSelectionViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductsViewModel()),
        ChangeNotifierProvider(create: (_) => EditProductsViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteProductsViewModel()),
        ChangeNotifierProvider(create: (_) => AddShopViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteShopViewModel()),
        ChangeNotifierProvider(create: (_) => AddWarehouseViewModel()),
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
        home: SuperAdminBottomNavBar(),
      ),
    );
  }
}
