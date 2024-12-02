import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Services/shared_prefs_helper.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Screens/Admin%20Screens/admin_bottom_nav_bar_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/manager_bottom_nav_bar.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_bottom_nav_bar_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class LoginViewModel with ChangeNotifier {
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(
      BuildContext context, String emailOrPhone, String password) async {
    String emailToUse = emailOrPhone;
    if (!isValidEmail(emailToUse)) {
      emailToUse = '$emailToUse@riq.com';
    }
    isLoading = true;
    notifyListeners();

    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: emailToUse, password: password);
      final user = userCredential.user;
      if (user != null) {
        print('Login Successful');
        if (isValidEmail(emailOrPhone)) {
          await fetchUserDataUsingEmail(context, user.email!);
        } else {
          await fetchUserDataUsingPhoneNumber(context, emailOrPhone);
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (error) {
      if (error.toString() ==
          '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.') {
        customSnackbar(context, 'User Not Found',
            backgroundColor: AppColors.red);
      }
      print('Error : $error');
      isLoading = false;
      notifyListeners();
    }
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  // Fetch admin data based on email from Firestore
  Future<void> fetchUserDataUsingEmail(
      BuildContext context, String email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot adminDocs = await firestore
          .collection('Users')
          .doc('Management')
          .collection('Admins')
          .where('email', isEqualTo: email)
          .get();

      if (adminDocs.docs.isNotEmpty) {
        final adminData = adminDocs.docs.first.data() as Map<String, dynamic>;

        // Store user data locally
        SharedPrefsHelper.setUserName(adminData['name']);
        SharedPrefsHelper.setUserImage(adminData['imageUrl']);
        SharedPrefsHelper.setUserContact(adminData['contact']);
        SharedPrefsHelper.setUserAddress(adminData['address']);
        SharedPrefsHelper.setUserAge(adminData['age']);
        SharedPrefsHelper.setUserCnic(adminData['cnic']);
        SharedPrefsHelper.setUserEmail(adminData['email']);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminBottomNavBarScreen()));
      } else {
        print('No admin found with the provided email.');
      }
    } catch (error) {
      print('Error fetching admin data: $error');
    }
  }

  // Fetch salesman or manager's data based on phone number from Firestore
  Future<void> fetchUserDataUsingPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      FirebaseFirestore firestore = await FirebaseFirestore.instance;
      // First, check in the managers collection
      QuerySnapshot managerDocs = await firestore
          .collection('Users')
          .doc('Staff')
          .collection('Managers')
          .where('contact', isEqualTo: phoneNumber)
          .get();

      if (managerDocs.docs.isNotEmpty) {
        // Found data in Managers collection
        final managerData =
            managerDocs.docs.first.data() as Map<String, dynamic>;

        // Store user data locally
        SharedPrefsHelper.setUserName(managerData['name']);
        SharedPrefsHelper.setUserImage(managerData['imageUrl']);
        SharedPrefsHelper.setUserContact(managerData['contact']);
        SharedPrefsHelper.setUserAddress(managerData['address']);
        SharedPrefsHelper.setUserAge(managerData['age']);
        SharedPrefsHelper.setUserCnic(managerData['cnic']);
        SharedPrefsHelper.setUserEmail(managerData['email']);
        SharedPrefsHelper.setManagerWarehouse(managerData['warehouse']);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ManagerBottomNavBar()));
        return;
      }

      // If not found in managers, check the salesmen collection
      QuerySnapshot salesmanDocs = await firestore
          .collection('Users')
          .doc('Staff')
          .collection('Salesmen')
          .where('contact', isEqualTo: phoneNumber)
          .get();

      if (salesmanDocs.docs.isNotEmpty) {
        // Found data in salesman collection
        final salesmanData =
            salesmanDocs.docs.first.data() as Map<String, dynamic>;

        // Store user data locally
        SharedPrefsHelper.setUserName(salesmanData['name']);
        SharedPrefsHelper.setUserImage(salesmanData['imageUrl']);
        SharedPrefsHelper.setUserContact(salesmanData['contact']);
        SharedPrefsHelper.setUserAddress(salesmanData['address']);
        SharedPrefsHelper.setUserAge(salesmanData['age']);
        SharedPrefsHelper.setSalesmanRoute(salesmanData['route']);
        SharedPrefsHelper.setSalesmanVehicle(salesmanData['vehicle']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SalesmanBottomNavBarScreen()));
      } else {
        print('No user found with the provided phone number.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
