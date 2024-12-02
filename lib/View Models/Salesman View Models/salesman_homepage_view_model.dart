import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalesmanHomepageViewModel with ChangeNotifier {
  // Method to get salesman details
  Stream<DocumentSnapshot> fetchSalesmanInfo() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Salesmen')
        .doc('Muhammad Ahsan')
        .snapshots();
    return data;
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
}
