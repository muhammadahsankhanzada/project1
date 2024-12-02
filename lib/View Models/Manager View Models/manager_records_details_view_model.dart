import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagerRecordsDetailsViewModel with ChangeNotifier {
  Map<String, dynamic> managerDetails = {
    'Warehouse': 'Warehouse 01',
    'CNIC': '45402-6789012-3',
    'Phone Number': '0304-1234567',
    'Address': 'Karachi',
    'Email': 'ahsan@gmail.com',
    'Password': '12345',
    'Age': 24,
    'Requests Approved': '30',
    'Requests Rejected': '10',
  };

  // Method to fetch manager records
  Stream<DocumentSnapshot> fetchManagerRecords(String managerName) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc(managerName)
        .snapshots();
    return data;
  }
}
