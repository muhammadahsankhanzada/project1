import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/available_products_model.dart';
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Models/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';

class InventoryReturnItemsViewModel with ChangeNotifier {
  // Variables
  List<CategoriesModel> categories = [];
  List<ProductModel> products = [];
  String errorMessage = '';
  String _selectedCategoryName = '';
  int _selectedCategoryIndex = 0;

  String get selectedCategoryName => _selectedCategoryName;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  set selectedCategoryName(String newName) {
    _selectedCategoryName = newName;
  }

  set selectedCategoryIndex(int newIndex) {
    _selectedCategoryIndex = newIndex;
  }

  // Fetch categories method
  Future<List<CategoriesModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getInventory(
          warehouseName: 'Alpha Warehouse', isNewProducts: false.toString())));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        categories =
            decodedResponse.map((e) => CategoriesModel.fromJson(e)).toList();

        notifyListeners();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
      throw Exception('Error fetching categories: $error');
    }
  }

  // Fetch products method
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getInventoryReturnItems(
          warehouseName: Constants.defaultWarehouse,
          selectedCategoryName: selectedCategoryName)));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        products =
            decodedResponse.map((e) => ProductModel.fromJson(e)).toList();

        return products;
      } else {
        print('Failed to load products');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      print('Error fetching products: $error');
      return [];
    }
  }

  void updateCategory(int index, String name) {
    _selectedCategoryIndex = index;
    _selectedCategoryName = name;
    fetchProducts().then((_) {
      notifyListeners();
    });
  }

  // // Fetch categories method
  // Future<List<CategoriesModel>> fetchCategories() async {
  //   List<CategoriesModel> _categories = [];
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
  //     return _categories;
  //   } catch (error) {
  //     print(error);
  //     return [];
  //   }
  // }

  // Method to fetch products from firestore
  // Future<List<AvailableProductsModel>> fetchProducts() async {
  //   List<AvailableProductsModel> products = [];
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   try {
  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('Warehouses')
  //         .doc('Alpha Warehouse')
  //         .collection('Categories')
  //         .doc(selectedCategoryName)
  //         .collection('Products')
  //         .get();

  //     for (var doc in querySnapshot.docs) {
  //       String productId = doc.id;

  //       final data = doc.data() as Map<String, dynamic>?;
  //       String name = data?['name'] ?? productId;
  //       String imageUrl = data?['imageUrl'] ?? '';
  //       int quantity = data?['quantity'];

  //       products.add(AvailableProductsModel(
  //           name: name, imageUrl: imageUrl, quantity: quantity));
  //     }
  //     return products;
  //   } catch (error) {
  //     print('Error getting products: $error');
  //     return [];
  //   }
  // }
}
