import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "flag_db.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    String script = await rootBundle.loadString('assets/data/flag_db.sql');
    List<String> commands = script.split(';');
    for (var command in commands) {
      if (command.trim().isNotEmpty) {
        await db.execute(command);
      }
    }
  }

  Future<List<Map<String, dynamic>>> fetchCountriesByContinent(String continent) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps;

    if (continent.toLowerCase() == 'all') {
      maps = await db.query('mytable');
    } else {
      maps = await db.query(
        'mytable',
        where: 'continent = ?',
        whereArgs: [continent],
      );
    }

    return maps;
  }



// Add other methods and logic as needed.
}
