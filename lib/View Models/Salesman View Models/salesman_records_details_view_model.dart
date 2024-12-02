import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';

class SalesmanRecordsDetailsViewModel with ChangeNotifier {
  Future<Map<String, dynamic>> fetchSalesmanRecords(String salesmanName) async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.getSalesmanRecordsDetails));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load salesman details');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching salesman details: $error');
    }
  }

  // Map<String, dynamic> driverDetails = {
  //   'Age': 24,
  //   'CNIC': '45402-6789012-3',
  //   'Phone Number': '03041234567',
  //   'Address': 'Shah Faisal Colony, Karachi',
  //   'Email': 'ahsan@gmail.com',
  //   'Total trips': '30',
  // };

  // // Method to fetch salesman records
  // Stream<DocumentSnapshot> fetchSalesmanRecords(String salesmanName) {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Salesmen')
  //       .doc(salesmanName)
  //       .snapshots();
  //   return data;
  // }
}
