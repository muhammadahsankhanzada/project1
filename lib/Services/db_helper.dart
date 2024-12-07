import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:project1/Utils/tables_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Variables
  static const dbName = TablesData.dbName;
  static const dbVersion = 2;
  static const recordId = 'recordId';

  // Constructor
  static final DatabaseHelper dbInstance = DatabaseHelper();

  // Initialize database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        // Salesman Cart Table
        await db.execute('''
        CREATE TABLE ${TablesData.salesmanCartTable.tableName}(
          $recordId INTEGER PRIMARY KEY,
          ${TablesData.salesmanCartTable.productId} TEXT,
          ${TablesData.salesmanCartTable.productName} TEXT,
          ${TablesData.salesmanCartTable.productImage} TEXT,
          ${TablesData.salesmanCartTable.productType} TEXT,
          ${TablesData.salesmanCartTable.productQuantity} INTEGER,
          ${TablesData.salesmanCartTable.productPrice} REAL,
          ${TablesData.salesmanCartTable.dateTime} TEXT
        )
        ''');

        // Shop Cart Table
        // await db.execute('''
        // CREATE TABLE ShopCart(
        //   $recordId INTEGER PRIMARY KEY,
        //   productName TEXT,
        //   productImageUrl TEXT,
        //   productType TEXT,
        //   productQuantity INTEGER,
        //   productPrice REAL
        // )
        // ''');
      },
    );
  }

  // Insert method
  insertRecord({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    Database? db = await dbInstance.database;
    try {
      return await db!.insert(tableName, data);
    } catch (e) {
      print('Error inserting record: $e');
    }
  }

  // Read method
  Future<List<Map<String, dynamic>>> readRecord(
      {required String tableName}) async {
    Database? db = await dbInstance.database;
    try {
      return await db!.query(tableName);
    } catch (e) {
      print('Error reading records: $e');
      return [];
    }
  }

  // Update method
  Future<int> updateRecord({
    required String tableName,
    required Map<String, dynamic> data,
    required int id,
  }) async {
    Database? db = await dbInstance.database;
    // int id = row[Id];
    try {
      return await db!
          .update(tableName, data, where: '$recordId = ?', whereArgs: [id]);
    } catch (e) {
      print('Error updating record: $e');
      return 0;
    }
  }

  // Delete record method
  Future<int> deleteRecord({
    required String tableName,
    required int id,
  }) async {
    Database? db = await dbInstance.database;
    try {
      return await db!
          .delete(tableName, where: '$recordId = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting record: $e');
      return 0;
    }
  }

  // Delete table method
  Future<void> deleteTable({required String tableName}) async {
    Database? db = await dbInstance.database;
    try {
      await db!.execute('DROP TABLE IF EXISTS $tableName');
      print("Table '$tableName' deleted successfully.");
    } catch (e) {
      print('Error deleting table: $e');
      rethrow;
    }
  }

  // Delete database method
  Future<void> deleteTheDatabase({required String databaseName}) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, databaseName);

      await deleteDatabase(path);
      print("Database deleted successfully.");
    } catch (e) {
      print('Error deleting database: $e');
    }
  }
}
