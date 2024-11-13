import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/available_products_model.dart';
import 'package:project1/Models/categories_model.dart';

class InventoryReturnItemsViewModel with ChangeNotifier {
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
    List<CategoriesModel> _categories = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .get();

      // Create a list of futures for the product counts
      List<Future<int>> productCountFutures =
          querySnapshot.docs.map((doc) async {
        String categoryId = doc.id;
        QuerySnapshot productSnapshot = await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(categoryId)
            .collection('Products')
            .get();
        return productSnapshot.docs.length;
      }).toList();

      // Wait for all futures to complete
      List<int> productCounts = await Future.wait(productCountFutures);

      _categories = List.generate(querySnapshot.docs.length, (index) {
        final doc = querySnapshot.docs[index];
        String name = (doc.data() as Map<String, dynamic>)['name'] ?? doc.id;
        String imageUrl =
            (doc.data() as Map<String, dynamic>)['imageUrl'] ?? '';
        return CategoriesModel(
            name: name,
            imageUrl: imageUrl,
            productsCount: productCounts[index]);
      });
      return _categories;
    } catch (error) {
      print(error);
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

  // Method to fetch products from firestore
  Future<List<AvailableProductsModel>> fetchProducts() async {
    List<AvailableProductsModel> products = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .doc(selectedCategoryName)
          .collection('Products')
          .get();

      for (var doc in querySnapshot.docs) {
        String productId = doc.id;

        final data = doc.data() as Map<String, dynamic>?;
        String name = data?['name'] ?? productId;
        String imageUrl = data?['imageUrl'] ?? '';
        int quantity = data?['quantity'];

        products.add(AvailableProductsModel(
            name: name, imageUrl: imageUrl, quantity: quantity));
      }
      return products;
    } catch (error) {
      print('Error getting products: $error');
      return [];
    }
  }
}
