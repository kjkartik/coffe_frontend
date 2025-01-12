// import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';
//
// void main() async {
//   var dbHelper = DatabaseSqflite();
//
//   // Insert data
//   await dbHelper.insertData('user_name', 'John Doe');
//   await dbHelper.insertData('user_age', '30');
//
//   // Get all data
//   // var data = await dbHelper();
//   // print('All Data: $data');
//
//   // Get data by key
//   var userName = await dbHelper.getDataByKey('user_name');
//   print('User Name: $userName');
//
//   // Update data
//   await dbHelper.updateData('user_age', '31');
//   var updatedData = await dbHelper.getDataByKey('user_age');
//   print('Updated Age: $updatedData');
//
//   // Delete data
//   await dbHelper.deleteData('user_name');
//   // var remainingData = await dbHelper.getAllData();
//   // print('Remaining Data: $remainingData');
//   // /**/
//   // Close the database
//   await dbHelper.closeDatabase();
// }
