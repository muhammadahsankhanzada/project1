import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuperAdminHomeViewModel with ChangeNotifier {
  String? selectedReportsValue = 'Monthly';
  final List<String> reportValuesList = ['Weekly', 'Monthly', 'Yearly'];
  String searchedText = '';

  // Search box's onChanged method
  void onChanged(String value) {
    searchedText = value;
    notifyListeners();
  }

  // Method to fetch dashboard reports
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchDashboardReports() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Management')
        .collection('Super Admins')
        .doc('Zeeshan')
        .collection('Dashboard Reports')
        .doc(selectedReportsValue)
        .snapshots();
    return data;
  }

  // Method to update the selected report value
  void updateReportSelection(String newSelectedValue) {
    selectedReportsValue = newSelectedValue;
    notifyListeners();
  }
}
