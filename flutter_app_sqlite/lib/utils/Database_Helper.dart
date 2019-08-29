import 'dart:io';

import 'package:flutter_app_sqlite/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableUser = 'userTable';
  final String columnId = 'id';
  final String columnUserName = 'username';
  final String columnPassword = 'password';

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
    String path = join(_documentDirectory.path, 'maindb.db');

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUserName TEXT , $columnPassword TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableUser, user.toMap());
    return res;
  }

  Future<List> getAllUser() async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT * FROM $tableUser');
    return _result.toList();
  }

  Future<int> getAllUserCount() async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT COUNT(*) FROM $tableUser');
    return Sqflite.firstIntValue(_result);
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var _result = await dbClient.rawQuery('SELECT * FROM $tableUser WHERE $columnId = $id');
    if(_result.length == 0) return null;
    return User.fromMap(_result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(), where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
