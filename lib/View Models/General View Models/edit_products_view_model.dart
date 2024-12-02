import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class EditProductsViewModel with ChangeNotifier {
  String? selectedCategoryValue;
  List<String> categoryValuesList = [];

  String? selectedProductValue;
  List<String> productValuesList = [];

  // Method to show fetched categories list
  Future<void> showCategories() async {
    List<String> categories = await fetchCategories();
    categoryValuesList = categories;
    notifyListeners();
    // fetchCategories().then((categories) {
    //   categoryValuesList = categories;
    // });
  }

  // Method to show fetched products list
  Future<void> showProducts() async {
    List<String> products = await fetchProducts();
    productValuesList = products;
    notifyListeners();
    // fetchProducts().then((products) {
    //   productValuesList = products;
    // });
    // notifyListeners();
  }

  // Update selected category
  Future<void> updateCategoryValue(newValue) async {
    selectedCategoryValue = newValue;
    selectedProductValue = null;
    await showProducts();
    // print(productValuesList);
    notifyListeners();
  }

  // Update selected product
  Future<void> updateProductValue(newValue) async {
    selectedProductValue = newValue;
    // await showProducts();
    // print(productValuesList);
    notifyListeners();
  }

  // Method to fetch categories list
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

  // Method to fetch products list
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

  // Update product method
  Future<void> updateProduct({
    required String productId,
    required String productNameController,
    required String productPriceController,
    required String productQuantityController,
    required BuildContext context,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the current product details
    DocumentSnapshot productSnapshot = await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryValue)
        .collection('Products')
        .doc(productId)
        .get();

    if (productSnapshot.exists) {
      var currentData = productSnapshot.data() as Map<String, dynamic>;

      // Prepare the new product name
      String newProductName = productNameController.isNotEmpty
          ? productNameController
          : currentData['name']; // Keep the current name if the field is empty

      // Create a new document with the new name as ID
      Map<String, dynamic> updateData = {
        'name': newProductName,
        'imageUrl': currentData['imageUrl'],
        'price':
            double.tryParse(productPriceController) ?? currentData['price'],
        'quantity':
            int.tryParse(productQuantityController) ?? currentData['quantity'],
      };

      // Check if the new name is different from the current ID
      if (newProductName != productId) {
        // Set the new document with the updated name
        await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(selectedCategoryValue)
            .collection('Products')
            .doc(newProductName)
            .set(updateData)
            .then((_) {
          customSnackbar(context, 'Product Updated Successfully');
          Navigator.pop(context);
          // print('Product updated successfully');

          // Delete the old document
          firestore
              .collection('Warehouses')
              .doc('Alpha Warehouse')
              .collection('Categories')
              .doc(selectedCategoryValue)
              .collection('Products')
              .doc(productId)
              .delete()
              .then((_) {
            // print('Old product deleted successfully');
          }).catchError((error) {
            print('Failed to delete old product: $error');
          });
        }).catchError((error) {
          customSnackbar(context, 'Error Updating Product');
          print('Failed to update product: $error');
        });
      } else {
        // If the name didn't change, just update the existing document
        await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(selectedCategoryValue)
            .collection('Products')
            .doc(productId)
            .update(updateData)
            .then((_) {
          // print('Product updated successfully without changing the ID');
          Navigator.pop(context);
          customSnackbar(context, 'Product Updated Successfully');
        }).catchError((error) {
          print('Failed to update product: $error');
        });
      }
    }
    notifyListeners();
  }
}
