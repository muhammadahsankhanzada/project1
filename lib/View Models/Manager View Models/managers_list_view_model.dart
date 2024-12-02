import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagersListViewModel with ChangeNotifier {
  String searchedText = '';

  // To filter managers list on change
  void onChanged(String newValue) {
    searchedText = newValue.toLowerCase();
    notifyListeners();
  }

  // Stream to fetch managers list
  Stream<QuerySnapshot> get managersStream {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .snapshots();
  }

  // Method to filter managers list based on search text
  List<QueryDocumentSnapshot> getFilteredManagersList(
      List<QueryDocumentSnapshot> managers) {
    return managers.where((manager) {
      final managerName = (manager['name'] ?? '').toLowerCase();
      return managerName.contains(searchedText);
    }).toList();
  }

  // Method to reset the ViewModel state
  void resetState() {
    searchedText = '';
    notifyListeners();
  }
}
