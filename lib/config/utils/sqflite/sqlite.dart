import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var dbHelper = DatabaseSqflite();

class DatabaseSqflite {
  // Database initialization
  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dynamic_data4.db');

    return await openDatabase(path, version: 11, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE DynamicData (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          dataKey TEXT,
          dataValue TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE Cart (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          dataKey TEXT,
          dataValue TEXT
        )
      ''');
    });
  }


  Future<void> addToCart(String dataKey, Map<dynamic, dynamic> dataValue) async {
    final db = await _initializeDatabase();

    // Ensure proper serialization before saving to the database
    String jsonData;
    try {
      jsonData = jsonEncode(dataValue); // Serialize to JSON
    } catch (e) {
      print("Error serializing data: $e");
      return; // Exit if data is not serializable
    }

    // Insert the serialized data into the table
    await db.insert('Cart', {'dataKey': dataKey, 'dataValue': jsonData},
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the same key exists
    );
  }

  Future<int> deleteDataCart(String key) async {
    final db = await _initializeDatabase();
    return await db.delete(
      'Cart',
      where: 'dataKey = ?',
      whereArgs: [key],
    );
  }


  Future<Map<String, String>> getAllDataAsMapCart() async {
    final db = await _initializeDatabase();

    // Query to get all rows from the DynamicData table
    List<Map<String, dynamic>> result = await db.query('Cart');

    // Convert the result into a Map<String, String>
    Map<String, String> dataMap = {};
    for (var item in result) {

      dataMap[item['dataKey']] = item['dataValue'];
    }

    return dataMap;
  }

  // Insert dynamic data
  Future<void> saveFav(String dataKey, Map<dynamic, dynamic> dataValue) async {
    final db = await _initializeDatabase();

    // Ensure proper serialization before saving to the database
    String jsonData;
    try {
      jsonData = jsonEncode(dataValue); // Serialize to JSON
    } catch (e) {
      print("Error serializing data: $e");
      return; // Exit if data is not serializable
    }

    // Insert the serialized data into the table
    await db.insert(
      'DynamicData',
      {'dataKey': dataKey, 'dataValue': jsonData},
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the same key exists
    );
  }

  // Retrieve data by key
  Future<Map<String, dynamic>?> getFavData(String key) async {
    final db = await _initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'DynamicData',
      where: 'dataKey = ?',
      whereArgs: [key],
    );

    if (result.isNotEmpty) {
      try {
        // Deserialize the JSON string back into a Map<String, dynamic>
        Map<String, dynamic> data = jsonDecode(result.first['dataValue']);
        return data;
      } catch (e) {
        print("Error deserializing data: $e");
        return null; // Return null if deserialization fails
      }
    }
    return null;
  }

  // Retrieve all dynamic data and store it in a Map
  Future<Map<String, String>> getAllDataAsMapFav() async {
    final db = await _initializeDatabase();

    // Query to get all rows from the DynamicData table
    List<Map<String, dynamic>> result = await db.query('DynamicData');

    // Convert the result into a Map<String, String>
    Map<String, String> dataMap = {};
    for (var item in result) {

      dataMap[item['dataKey']] = item['dataValue'];
    }

    return dataMap;
  }

  // Update data by key
  Future<int> updateData(String key, String newValue) async {
    final db = await _initializeDatabase();
    return await db.update(
      'DynamicData',
      {'dataValue': newValue},
      where: 'dataKey = ?',
      whereArgs: [key],
    );
  }

  // Delete data by key
  Future<int> deleteDataFav(String key) async {
    final db = await _initializeDatabase();
    return await db.delete(
      'DynamicData',
      where: 'dataKey = ?',
      whereArgs: [key],
    );
  }

  // Check if a key exists
  Future<bool> keyExists(String key) async {
    final db = await _initializeDatabase();

    // Query to check if the key exists
    List<Map<String, dynamic>> result = await db.query(
      'DynamicData',
      where: 'dataKey = ?',
      whereArgs: [key],
    );

    return result.isNotEmpty; // Return true if the key exists, otherwise false
  }

  // Close the database
  Future<void> closeDatabase() async {
    final db = await _initializeDatabase();
    await db.close();
  }
}
