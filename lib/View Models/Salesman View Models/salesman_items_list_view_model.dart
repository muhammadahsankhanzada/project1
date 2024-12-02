import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalesmanItemsListViewModel with ChangeNotifier {
  int quantity = 1;
  String selectedCategoryName = '';
  int selectedCategoryIndex = 0;
  String searchedText = '';

  void onChanged(String value) {
    searchedText = value.toLowerCase();
    notifyListeners();
  }

  // Method to fetch categories
  Stream<QuerySnapshot> fetchCategories() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .snapshots();
    return data;
  }

  // Method to fetch products
  Stream<QuerySnapshot> fetchProducts(String selectedCategoryName) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryName)
        .collection('Products')
        .snapshots();
    return data;
  }
}
