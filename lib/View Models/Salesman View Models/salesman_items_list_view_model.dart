import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/Models/categories_model.dart';
import 'package:project1/Models/products_model.dart';
import 'package:project1/Services/db_helper.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/tables_data.dart';
import 'package:sqflite/sqflite.dart';

class SalesmanItemsListViewModel with ChangeNotifier {
  Map<String, Map<String, dynamic>> productDetails = {};
  int quantity = 1;
  String selectedCategoryName = '';
  int selectedCategoryIndex = 0;
  String searchedText = '';

  void onChanged(String value) {
    searchedText = value.toLowerCase();
    notifyListeners();
  }

  void updateSelectedCategory(int index, String categoryName) {
    selectedCategoryIndex = index;
    selectedCategoryName = categoryName;
    searchedText = '';
    fetchProducts();
    // readLocallySavedData();
    notifyListeners();
  }

  void initializeProductDetails(ProductModel product) {
    // Initialize the product details if not already initialized
    final productId = product.id;
    if (!productDetails.containsKey(productId)) {
      productDetails[productId] = {
        'quantity': quantity,
        // 'quantity': product.quantity,
        'price': product.price,
      };
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

  // Fetch products method
  Future<List<ProductModel>> fetchProducts() async {
    List<ProductModel> products;
    try {
      final response = await http.get(Uri.parse(AppUrls.getProdutsWithData(
          warehouseName: Constants.defaultWarehouse,
          categoryName: selectedCategoryName)));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        products =
            decodedResponse.map((e) => ProductModel.fromJson(e)).toList();
// Initialize product details for each product
        for (var product in products) {
          initializeProductDetails(product);
        }
        return products;
      } else {
        print('Failed to load products');
        return [];
      }
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }

  // Method to increment or decrement the quantity
  void updateQuantity(String productId, bool isIncrement) {
    if (productDetails.containsKey(productId)) {
      if (isIncrement) {
        productDetails[productId]?['quantity'] =
            (productDetails[productId]?['quantity'] ?? 1) + 1;
      } else {
        if (productDetails[productId]?['quantity']! > 1) {
          productDetails[productId]?['quantity'] =
              (productDetails[productId]?['quantity'] ?? 1) - 1;
        }
      }
      notifyListeners();
    }
  }

  // You can optionally use this method to get the price for a product dynamically
  double getProductPrice(String productId) {
    return productDetails[productId]?['price'] ?? 0.0;
  }

  // You can optionally use this method to get the quantity for a product dynamically
  int getProductQuantity(String productId) {
    return productDetails[productId]?['quantity'] ?? 1;
  }

  // Sqlite insert function
  Future<void> saveDataLocally({
    required String productId,
    required String productName,
    required String productImageUrl,
    required String productType,
    required int productQuantity,
    required double productPrice,
    required String dateTime,
  }) async {
    Map<String, dynamic> product = {
      '${TablesData.salesmanCartTable.productId}': productId,
      '${TablesData.salesmanCartTable.productName}': productName,
      '${TablesData.salesmanCartTable.productImage}': productImageUrl,
      '${TablesData.salesmanCartTable.productType}': productType,
      '${TablesData.salesmanCartTable.productQuantity}': productQuantity,
      '${TablesData.salesmanCartTable.productPrice}': productPrice,
      '${TablesData.salesmanCartTable.dateTime}': dateTime,
    };

    List<Map<String, dynamic>> existingProduct =
        await DatabaseHelper.dbInstance.readRecord(
      tableName: '${TablesData.salesmanCartTable.tableName}',
    );

    bool productExists = existingProduct.any((product) =>
        product['${TablesData.salesmanCartTable.productId}'] == productId);

    if (productExists) {
      await updateLocallySavedData(
          tableName: TablesData.salesmanCartTable.tableName,
          data: product,
          productId: productId);
    } else {
      await DatabaseHelper.dbInstance.insertRecord(
        tableName: '${TablesData.salesmanCartTable.tableName}',
        data: product,
      );
    }
  }

  Future<List<Map<String, dynamic>>> readLocallySavedData() async {
    List<Map<String, dynamic>> products = await DatabaseHelper.dbInstance
        .readRecord(tableName: '${TablesData.salesmanCartTable.tableName}');
    products.forEach((product) {
      print(
          'Product Id: ${product['${TablesData.salesmanCartTable.productId}']}');
      print(
          'Product Name: ${product['${TablesData.salesmanCartTable.productName}']}');
      print(
          'Product ImageUrl: ${product['${TablesData.salesmanCartTable.productImage}']}');
      print(
          'Product Price: ${product['${TablesData.salesmanCartTable.productPrice}']}');
      print(
          'Product Quantity: ${product['${TablesData.salesmanCartTable.productQuantity}']}');
      print(
          'Product DateTime: ${product['${TablesData.salesmanCartTable.dateTime}']}');
    });
    return products;
  }

  Future<void> updateLocallySavedData({
    required String tableName,
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    Database? db = await DatabaseHelper.dbInstance.database;
    try {
      await db!.update(tableName, data,
          where: '${TablesData.salesmanCartTable.productId} = ?',
          whereArgs: [productId]);
    } catch (e) {
      print('Error updating record: $e');
    }
  }

  Future<void> deleteLocallySavedData({required int recordId}) async {
    await DatabaseHelper.dbInstance
        .deleteRecord(tableName: 'SalesmanCart', id: recordId);
  }

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

  // // Method to fetch products
  // Stream<QuerySnapshot> fetchProducts(String selectedCategoryName) {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final data = firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .doc(selectedCategoryName)
  //       .collection('Products')
  //       .snapshots();
  //   return data;
  // }
}
