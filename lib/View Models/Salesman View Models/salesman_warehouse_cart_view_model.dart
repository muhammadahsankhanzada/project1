import 'package:flutter/material.dart';
import 'package:project1/Services/db_helper.dart';
import 'package:project1/Utils/tables_data.dart';
import 'package:sqflite/sqflite.dart';

class SalesmanWarehouseCartViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchLocalCartItems() async {
    List<Map<String, dynamic>> products = await DatabaseHelper.dbInstance
        .readRecord(tableName: '${TablesData.salesmanCartTable.tableName}');
    products.forEach((product) {
      // print(
      //     'Product Id: ${product['${TablesData.salesmanCartTable.productId}']}');
      // print(
      //     'Product Name: ${product['${TablesData.salesmanCartTable.productName}']}');
      // print(
      //     'Product ImageUrl: ${product['${TablesData.salesmanCartTable.productImage}']}');
      // print(
      //     'Product Price: ${product['${TablesData.salesmanCartTable.productPrice}']}');
      // print(
      //     'Product Quantity: ${product['${TablesData.salesmanCartTable.productQuantity}']}');
      // print(
      //     'Product DateTime: ${product['${TablesData.salesmanCartTable.dateTime}']}');
    });
    notifyListeners();
    return products;
  }

  Future<int> getCurrentQuantity({
    required String productId,
  }) async {
    List<Map<String, dynamic>> products = await fetchLocalCartItems();

    Map<String, dynamic> product = products.firstWhere(
      (prod) => prod[TablesData.salesmanCartTable.productId] == productId,
      orElse: () => {},
    );

    int currentQuantity = product[TablesData.salesmanCartTable.productQuantity];
    return currentQuantity;
  }

  Future<void> incrementQuantity({
    required String productId,
  }) async {
    final int currentQuantity = await getCurrentQuantity(productId: productId);
    int updatedQuantity = currentQuantity + 1;

    await updateLocalCartItem(
      tableName: TablesData.salesmanCartTable.tableName,
      data: {TablesData.salesmanCartTable.productQuantity: updatedQuantity},
      productId: productId,
    );
    notifyListeners();
  }

  Future<void> decrementQuantity({
    required String productId,
  }) async {
    final int currentQuantity = await getCurrentQuantity(productId: productId);
    if (currentQuantity > 1) {
      int updatedQuantity = currentQuantity - 1;

      await updateLocalCartItem(
        tableName: TablesData.salesmanCartTable.tableName,
        data: {TablesData.salesmanCartTable.productQuantity: updatedQuantity},
        productId: productId,
      );
      notifyListeners();
    }
  }

  Future<void> updateLocalCartItem({
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
    notifyListeners();
  }
}
