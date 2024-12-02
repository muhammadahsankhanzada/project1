import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagerRejectedRequestsDetailsViewModel with ChangeNotifier {
  // Method to get rejected request details
  Stream<QuerySnapshot> fetchRejectedRequestDetails(String salesmanId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc('Ahsan')
        .collection('Rejected Requests')
        .doc(salesmanId)
        .collection('Requested Products')
        .snapshots();
    return data;
  }
}
