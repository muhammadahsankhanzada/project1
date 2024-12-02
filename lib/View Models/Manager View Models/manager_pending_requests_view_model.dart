import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';

class ManagerPendingRequestsViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchPendingRequests(
      String managerName) async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.getManagerPendingRequestsList));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load pending requests list');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching pending requests: $error');
    }
  }
}
