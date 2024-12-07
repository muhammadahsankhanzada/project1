import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;

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

  // // Fetch categories list
  // Future<List<String>> fetchCategories() async {
  //   List<String> categories = [];
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .get()
  //       .then((QuerySnapshot categorySnapshot) {
  //     categories = categorySnapshot.docs.map((doc) => doc.id).toList();
  //   }).catchError((error) {
  //     print('Error getting data: $error');
  //   });
  //   return categories;
  // }

  // Fetch categories list
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getCategoriesList(
          warehouseName: Constants.defaultWarehouse)));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return List<String>.from(data['categoriesList']);
      } else {
        print('Failed to load categories');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
      print('Error fetching categories: $error');
      return [];
    }
  }

  // Fetch products list
  Future<List<String>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
          AppUrls.getProdutsList(
            warehouseName: Constants.defaultWarehouse,
            categoryName: selectedCategoryValue!,
          ),
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return List<String>.from(data['productsList']);
      } else {
        print('Failed to load products');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
      print('Error fetching products: $error');
      return [];
    }
  }

  // Fetch products list
  // Future<List<String>> fetchProducts() async {
  //   List<String> products = [];
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .doc(selectedCategoryValue)
  //       .collection('Products')
  //       .get()
  //       .then((QuerySnapshot productSnapshot) {
  //     products = productSnapshot.docs.map((doc) => doc.id).toList();
  //   }).catchError((error) {
  //     print('Error getting data: $error');
  //   });
  //   return products;
  // }

  // Method to delete a product
  Future<void> deleteProduct(String productName, List<String> warehouseList,
      BuildContext context) async {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    for (int i = 0; i < warehouseList.length; i++) {
      try {
        final response = await http.post(
          Uri.parse(AppUrls.postDeleteProduct),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            {
              'warehouseName': warehouseList[i],
              'categoryName': selectedCategoryValue,
              'productName': productName,
            },
          ),
        );
        if (response.statusCode == 200) {
          customSnackbar(context, 'Product Deleted Successfully');
          print('Product deleted successfully');
        } else {
          customSnackbar(context, 'Error Deleting Product');

          print('Failed to deleting product');
        }
        // await firestore
        //     .collection('Warehouses')
        //     .doc('Alpha Warehouse')
        //     .collection('Categories')
        //     .doc(selectedCategoryValue)
        //     .collection('Products')
        //     .doc(productId)
        //     .delete();
        // Navigator.pop(context);
        // customSnackbar(context, 'Product Deleted Successfully');
      } catch (error) {
        print('Error deleting document: $error');
        customSnackbar(context, 'Error Deleting Product');
      }
    }
    Navigator.pop(context);

    notifyListeners();
  }

  // Reset screen data
  void resetState() {
    selectedCategoryValue = null;
    notifyListeners();
  }
}
