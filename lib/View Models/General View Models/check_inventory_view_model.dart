import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';

class CheckInventoryViewModel with ChangeNotifier {
  // Private variables
  List<CategoriesModel> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters to expose the data
  List<CategoriesModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch categories method
  Future<List<CategoriesModel>> fetchCategories() async {
    _isLoading = true;
    // notifyListeners();
    try {
      final response = await http.get(Uri.parse(AppUrls.getInventory(
          warehouseName: Constants.defaultWarehouse,
          isNewProducts: true.toString())));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        _categories =
            decodedResponse.map((e) => CategoriesModel.fromJson(e)).toList();
        _isLoading = false;
        notifyListeners();
        return _categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error: $error');
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching categories: $error');
    }
  }

  // Future<List<CategoriesModel>> fetchCategories() async {
  //   _isLoading = true;
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('Warehouses')
  //         .doc('Alpha Warehouse')
  //         .collection('Categories')
  //         .get();

  //     // Create a list of futures for the product counts
  //     List<Future<int>> productCountFutures =
  //         querySnapshot.docs.map((doc) async {
  //       String categoryId = doc.id;
  //       QuerySnapshot productSnapshot = await firestore
  //           .collection('Warehouses')
  //           .doc('Alpha Warehouse')
  //           .collection('Categories')
  //           .doc(categoryId)
  //           .collection('Products')
  //           .get();
  //       return productSnapshot.docs.length;
  //     }).toList();

  //     // Wait for all futures to complete
  //     List<int> productCounts = await Future.wait(productCountFutures);

  //     _categories = List.generate(querySnapshot.docs.length, (index) {
  //       final doc = querySnapshot.docs[index];
  //       String name = (doc.data() as Map<String, dynamic>)['name'] ?? doc.id;
  //       String imageUrl =
  //           (doc.data() as Map<String, dynamic>)['imageUrl'] ?? '';
  //       return CategoriesModel(
  //           name: name,
  //           imageUrl: imageUrl,
  //           productsCount: productCounts[index]);
  //     });

  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (error) {
  //     _errorMessage = 'Error fetching categories: $error';
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  //   return _categories;
  // }
}
