import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';

class SalesmanHomepageViewModel with ChangeNotifier {
  // Method to get salesman details
  Future<Map<String, dynamic>> fetchSalesmanInfo() async {
    final salesmanName = 'Muhammad Ahsan';
    try {
      final response = await http.get(Uri.parse(AppUrls.getSalesmanInfo(
        salesmanName: salesmanName,
      )));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load salesman info');
      }
    } catch (error) {
      print('Api Error: $error');
      throw Exception('Error fetching salesman info: $error');
    }
  }

  // Fetch categories method
  Future<List<CategoriesModel>> fetchCategories() async {
    List<CategoriesModel> categories;
    try {
      final response = await http.get(Uri.parse(AppUrls.getInventory(
          warehouseName: Constants.defaultWarehouse,
          isNewProducts: true.toString())));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        categories =
            decodedResponse.map((e) => CategoriesModel.fromJson(e)).toList();
        notifyListeners();
        return categories;
      } else {
        print('Failed to load categories');
        return [];
      }
    } catch (error) {
      print('Error fetching categories: $error');
      notifyListeners();
      return [];
    }
  }

  // // Method to get salesman details
  // Stream<DocumentSnapshot> fetchSalesmanInfo() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Salesmen')
  //       .doc('Muhammad Ahsan')
  //       .snapshots();
  //   return data;
  // }

  // // Method to fetch categories
  // Stream<QuerySnapshot> fetchCategories() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .snapshots();
  //   return data;
  // }
}
