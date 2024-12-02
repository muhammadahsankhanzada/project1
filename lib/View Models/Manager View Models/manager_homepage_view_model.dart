import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';

class ManagerHomepageViewModel with ChangeNotifier {
  Future<Map<String, dynamic>> fetchManagerDetails() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getManagerInfo));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load manager details');
      }
    } catch (error) {
      print('Api Error: $error');
      throw Exception('Error fetching manager details: $error');
    }
  }
}
