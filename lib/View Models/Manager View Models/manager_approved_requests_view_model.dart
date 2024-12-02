import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';

class ManagerApprovedRequestsViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchApprovedRequests(
      String managerName) async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.getManagerApprovedRequestsList));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load approved requests list');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching approved requests: $error');
    }
  }
  // // Method to get approved requests list
  // Stream<QuerySnapshot> fetchApprovedRequests(String managerName) {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Managers')
  //       .doc(managerName)
  //       .collection('Approved Requests')
  //       .snapshots();
  //   return data;
  // }
}
