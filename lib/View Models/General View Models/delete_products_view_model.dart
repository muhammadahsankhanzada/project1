import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class DeleteProductsViewModel with ChangeNotifier {
  String? selectedCategoryValue;
  List<String> categoryValuesList = [];

  String? selectedProductValue;
  List<String> productValuesList = [];

  // Show Categories List
  Future<void> showCategories() async {
    List<String> categories = await fetchCategories();
    categoryValuesList = categories;
    notifyListeners();
  }

  // Show Products List
  Future<void> showProducts() async {
    List<String> products = await fetchProducts();
    productValuesList = products;
    notifyListeners();
  }

  // Update category value
  void updateSelectedCategory(newValue) {
    selectedCategoryValue = newValue;
    selectedProductValue = null;
    showProducts();
    notifyListeners();
  }

  // Update product value
  void updateSelectedProduct(newValue) {
    selectedProductValue = newValue;
    notifyListeners();
  }

  // Fetch categories list
  Future<List<String>> fetchCategories() async {
    List<String> categories = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .get()
        .then((QuerySnapshot categorySnapshot) {
      categories = categorySnapshot.docs.map((doc) => doc.id).toList();
    }).catchError((error) {
      print('Error getting data: $error');
    });
    return categories;
  }

  // Fetch products list
  Future<List<String>> fetchProducts() async {
    List<String> products = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryValue)
        .collection('Products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      products = productSnapshot.docs.map((doc) => doc.id).toList();
    }).catchError((error) {
      print('Error getting data: $error');
    });
    return products;
  }

  // Method to delete a product
  Future<void> deleteProduct(String productId, BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .doc(selectedCategoryValue)
          .collection('Products')
          .doc(productId)
          .delete();
      Navigator.pop(context);
      customSnackbar(context, 'Product Deleted Successfully');
    } catch (error) {
      print('Error deleting document: $error');
      customSnackbar(context, 'Error Deleting Product');
    }
    notifyListeners();
  }
}
