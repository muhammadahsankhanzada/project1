import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/ViewModels/auth_view_model.dart';
import 'package:project1/ViewModels/dummy_provider.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_bottom_nav_bar_screen.dart';
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
        ChangeNotifierProvider(create: (_) => DummyProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
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
