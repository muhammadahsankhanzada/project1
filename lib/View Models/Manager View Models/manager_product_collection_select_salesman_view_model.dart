import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';

class ManagerProductCollectionSelectSalesmanViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchSalesmenList() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getSalesmanRecords));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load salesmen list');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching salesmen list: $error');
    }
  }

  String searchedText = '';

  void onChanged(String value) {
    searchedText = value.toLowerCase();
    notifyListeners();
  }

  List<Map<String, dynamic>> filterSalesmen(
      List<Map<String, dynamic>> salesmen) {
    final filteredSalesmen = salesmen.where((salesman) {
      final salemanName = (salesman['name'] ?? '').toLowerCase();
      return salemanName.contains(searchedText);
    }).toList();
    return filteredSalesmen;
  }
}
