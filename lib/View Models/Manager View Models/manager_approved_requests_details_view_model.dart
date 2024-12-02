import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:http/http.dart' as http;

class ManagerApprovedRequestsDetailsViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchApprovedRequestSummary(
      String salesmanId) async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.getManagerApprovedRequestDetails));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load the details');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching details: $error');
    }
  }

  // Method to get approved request summary
  // Stream<QuerySnapshot> fetchApprovedRequestSummary(String salesmanId) {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Managers')
  //       .doc('Ahsan')
  //       .collection('Approved Requests')
  //       .doc(salesmanId)
  //       .collection('Requested Products')
  //       .snapshots();
  //   return data;
  // }
}
