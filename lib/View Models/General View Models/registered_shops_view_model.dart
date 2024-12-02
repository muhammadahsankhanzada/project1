import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisteredShopsViewModel with ChangeNotifier {
  String searchedText = '';

  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('Shops');

  // To filter shops on change
  void onChanged(String newValue) {
    searchedText = newValue.toLowerCase();
    notifyListeners();
  }

  // Stream to fetch shops
  Stream<QuerySnapshot> get shopsStream {
    return FirebaseFirestore.instance.collection('Shops').snapshots();
  }

  // Method to filter shops based on search text
  List<QueryDocumentSnapshot> getFilteredShops(
      List<QueryDocumentSnapshot> shops) {
    return shops.where((shop) {
      final shopName = (shop['name'] ?? '').toLowerCase();
      return shopName.contains(searchedText);
    }).toList();
  }

  // Method to reset the ViewModel state
  void resetState() {
    searchedText = '';
    notifyListeners();
  }
}
