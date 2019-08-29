import 'dart:io';

import 'package:flutter_app_todo/models/nodo_item.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'notodo';
  final String columnId = 'id';
  final String columnItemName = 'itemName';
  final String columnDateCreated = 'dateCreated';

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory _documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(_documentDirectory.path, 'notodo_db.db');

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnItemName TEXT , $columnDateCreated TEXT)');
  }

  Future<int> saveItem(NoDoItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableName, item.toMap());
    print(res.toString());
    return res;
  }

  Future<List> getItems() async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT * FROM $tableName ORDER BY $columnItemName ASC');
    return _result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(_result);
  }

  Future<NoDoItem> getItem(int id) async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT * FROM $tableName WHERE $columnId = $id');
    if(_result.length == 0) return null;
    return new NoDoItem.formMap(_result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateItem(NoDoItem item) async {
    var dbClient = await db;
    return await dbClient.update(tableName, item.toMap(), where: '$columnId = ?', whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
