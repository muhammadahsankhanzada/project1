import 'package:flutter/material.dart';
import 'package:project1/Services/db_helper.dart';
import 'package:project1/Utils/tables_data.dart';

class SalesmanCartDetailsViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    List<Map<String, dynamic>> products = await DatabaseHelper.dbInstance
        .readRecord(tableName: '${TablesData.salesmanCartTable.tableName}');
    notifyListeners();
    return products;
  }

  Future<double> getTotalPrice() async {
    List<Map<String, dynamic>> products = await fetchCartItems();

    double totalPrice = 0.0;

    products.forEach((product) {
      double price =
          product['${TablesData.salesmanCartTable.productPrice}'] ?? 0.0;
      int quantity =
          product['${TablesData.salesmanCartTable.productQuantity}'] ?? 0;

      totalPrice += price * quantity;
    });
    notifyListeners();

    return totalPrice;
  }
}
