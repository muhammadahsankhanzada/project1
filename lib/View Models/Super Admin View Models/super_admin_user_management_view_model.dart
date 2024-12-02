import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuperAdminUserManagementViewModel with ChangeNotifier {
  bool _isUserSalesman = true;
  bool _isUserManager = false;
  bool _isUserAdmin = false;

  // Getters
  bool get isUserSalesman => _isUserSalesman;
  bool get isUserManager => _isUserManager;
  bool get isUserAdmin => _isUserAdmin;

  // Setters
  set isUserSalesman(bool value) {
    _isUserSalesman = value;
    notifyListeners();
  }

  set isUserManager(bool value) {
    _isUserManager = value;
    notifyListeners();
  }

  set isUserAdmin(bool value) {
    _isUserAdmin = value;
    notifyListeners();
  }

  // Method to fetch user records
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserRecords() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc(isUserAdmin ? 'Management' : 'Staff')
        .collection(isUserSalesman
            ? 'Salesmen'
            : isUserManager
                ? 'Managers'
                : 'Admins')
        .snapshots();
    return data;
  }
}
