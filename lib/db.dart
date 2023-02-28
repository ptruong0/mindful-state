import 'package:sqflite/sqflite.dart' as sql;

class Database {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'app-data.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        "CREATE TABLE Moods(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, mood TEXT, loggedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
    await database.execute(
        "CREATE TABLE CompletedActivities(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, moodBefore TEXT, moodAfter TEXT, activity TEXT, completedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
  }

  static Future<void> insertMood(String? mood) async {
    final db = await Database.db();

    final data = {'mood': mood};
    await db.insert('Moods', data);
  }

  static Future<void> insertCompletedActivity(
      String? moodBefore, String? moodAfter, String? activity) async {
    final db = await Database.db();

    final data = {
      'moodBefore': moodBefore,
      'moodAfter': moodAfter,
      'activity': activity
    };
    await db.insert('CompletedActivities', data);
  }

  static Future<void> deleteMood(int id) async {
    final db = await Database.db();
    await db.delete("Moods", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteActivity(int id) async {
    final db = await Database.db();
    await db.delete("CompletedActivities", where: "id = ?", whereArgs: [id]);
  }
}
