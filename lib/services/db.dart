import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class Database {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'app-data.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await initializeData(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute('DROP TABLE IF EXISTS Activities');
    await database.execute("""CREATE TABLE Activities(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT,
          category TEXT,
          outdoors int,
          energy int,
          score int NOT NULL DEFAULT 0
        )""");
  }

  static Future<void> initializeData(sql.Database db) async {
    // load in data from file
    String excelFilePath = await rootBundle.loadString('assets/activities.csv');
    List<List<dynamic>> excelData =
        const CsvToListConverter().convert(excelFilePath);
    for (var row in excelData) {
      String name = row[0].toString();
      String category = row[1].toString();
      int outdoors = row[2];
      int energy = row[3];
      // insert each row into database
      await db.insert(
          'Activities',
          {
            'name': name,
            'category': category,
            'outdoors': outdoors,
            'energy': energy
          },
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static Future<void> updateActivityPreference(
      int? change, String? name) async {
    final db = await Database.db();

    await db.rawUpdate('UPDATE Activities SET score = score + ? WHERE name = ?',
        [change, name]);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await Database.db();
    return db.query('Activities', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> filterDataByCategory(
      String? category) async {
    final db = await Database.db();
    return await db
        .query('Activities', where: 'category = ?', whereArgs: [category]);
  }

  static Future<List<Map<String, dynamic>>> filterDataByAllParameters(
      String? category, int? outdoors, int? energy) async {
    final db = await Database.db();
    return await db.query('Activities',
        where: 'category = ? AND outdoors = ? AND energy <= ?',
        whereArgs: [category, outdoors, energy]);
  }
}
