import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagerRejectedRequestsViewModel with ChangeNotifier {
  // Method to get rejected requests list
  Stream<QuerySnapshot> fetchRejectedRequests(String managerName) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc(managerName)
        .collection('Rejected Requests')
        .snapshots();
    return data;
  }
}
