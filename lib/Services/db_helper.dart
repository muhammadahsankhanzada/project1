import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Variables
  static const dbName = 'firstProject.db';
  static const dbVersion = 1;
  static const dbTable = 'task';
  static const Id = 'Id';
  static const title = 'Title';
  static const description = 'Description';
  static const priority = 'Priority';
  static const dueDate = 'DueDate';
  static const completionStatus = 'CompletionStatus';

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
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $dbTable(
          $Id INTEGER PRIMARY KEY,
          $title TEXT,
          $description TEXT,
          $priority TEXT,
          $dueDate TEXT,
          $completionStatus TEXT
        )
        ''');
      },
    );
  }

  // Insert method
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await dbInstance.database;
    return await db!.insert(dbTable, row);
  }

  // Read method
  Future<List<Map<String, dynamic>>> readRecord() async {
    Database? db = await dbInstance.database;
    return await db!.query(dbTable);
  }

  // Update method
  Future<int> updateRecord(Map<String, dynamic> row, int id) async {
    Database? db = await dbInstance.database;
    // int id = row[Id];
    return await db!.update(dbTable, row, where: '$Id = ?', whereArgs: [id]);
  }

  // Delete method
  Future<int> deleteRecord(int id) async {
    Database? db = await dbInstance.database;
    return await db!.delete(dbTable, where: '$Id = ?', whereArgs: [id]);
  }
}
