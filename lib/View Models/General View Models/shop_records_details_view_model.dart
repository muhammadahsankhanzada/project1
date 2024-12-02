import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopRecordsDetailsViewModel with ChangeNotifier {
  List<bool> isContainerClicked = List.generate(500, (index) => false);

  // Function to toggle the clicked state
  void toggleContainerClick(int index) {
    isContainerClicked[index] = !isContainerClicked[index];
    notifyListeners();
  }

  // Show shop details
  Map<String, dynamic> showShopDetails(shop) {
    Map<String, dynamic> storeDetails = {
      'Location': shop['address'],
      'Deliveries': '33',
      'Revenue': '50,000',
      'Type': shop['type'],
      'Timings': shop['timings'],
      'Contact': shop['contact'],
      'Email': shop['email'],
      'Rating': 4.5,
    };
    return storeDetails;
  }

  // Method to fetch shop records
  Future<DocumentSnapshot> fetchShopRecords(String shopName) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore.collection('Shops').doc(shopName).get();
    return data;
  }

// Method to fetch completed orders
  Future<QuerySnapshot> fetchCompletedOrders(String shopName) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Shops')
        .doc(shopName)
        .collection('Completed Orders')
        .get();
    return data;
  }

  // Reset widget state
  resetState() {
    isContainerClicked = List.generate(500, (index) => false);
    notifyListeners();
  }
}
