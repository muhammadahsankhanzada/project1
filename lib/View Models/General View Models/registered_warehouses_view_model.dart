import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisteredWarehousesViewModel with ChangeNotifier {
  String searchedText = '';

  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('Warehouses');

  // To filter warehouses on change
  void onChanged(String newValue) {
    searchedText = newValue.toLowerCase();
    notifyListeners();
  }

  // Stream to fetch warehouses
  Stream<QuerySnapshot> get warehousesStream {
    return FirebaseFirestore.instance.collection('Warehouses').snapshots();
  }

  // Method to filter warehouses based on search text
  List<QueryDocumentSnapshot> getFilteredWarehouses(
      List<QueryDocumentSnapshot> warehouses) {
    return warehouses.where((warehouse) {
      final warehouseName = (warehouse['name'] ?? '').toLowerCase();
      return warehouseName.contains(searchedText);
    }).toList();
  }

  // Method to reset the ViewModel state
  void resetState() {
    searchedText = '';
    notifyListeners();
  }
}
