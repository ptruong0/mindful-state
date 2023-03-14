import 'package:sqflite/sqflite.dart' as sql;

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
    // final db = await Database.db();
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Take a 30-minute walk.', 'fitness', 1, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go for a jog around the block.', 'fitness', 1, 4)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Do some at-home yoga.', 'fitness', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Lift weights at the gym.', 'fitness', 0, 4)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go bike riding for 2 miles.', 'fitness', 1, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Follow a Zumba tutorial on Youtube.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Play golf or mini-golf.', 'fitness', 1, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Take a hike in nature.', 'fitness', 1, 4)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Play a sport with friends.', 'fitness', 1, 4)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go to a rock-climbing gym.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try a new fitness class like pilates.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try a new fitness class like spin.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try a new fitness class like kickboxing.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Follow a home ab workout on Youtube.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Do a HIIT (high-intensity interval training) workout.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Walk around at a local park or trail.', 'fitness', 1, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Use a cardio machine like the Stairmaster or elliptical at the gym.', 'fitness', 0, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go swimming at a local pool or beach.', 'fitness', 1, 5)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Meditate for 15 minutes.', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Read a book.', 'relaxation', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try to cook a new recipe.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Bake soe tasty treats such as cookies or muffins.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Have a picnic outside and enjoy the sunshine.', 'relaxation', 1, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Take a relaxing hot bath.', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Deep clean one room in your home.', 'productivity', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Ask a friend to hang out.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Sing karaoke.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Doodle in a sketch book and/or follow a drawing tutorial.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Color in a coloring book.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Do a puzzle.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Watch your favorite TV show.', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Watch your favorite movie.', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Paint a portrait.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try outdoor photography.', 'fun', 1, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Start a DIY project or home improvement task.', 'productivity', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go to a local farmers market.', 'productivity', 1, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Listen to some calming music', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go to a spa for a massage.', 'relaxation', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Plant a garden or tend to houseplants.', 'relaxation', 1, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Play a musical instrument.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Write a short story as a creative writing exercise.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Write about your thoughts in a journal.', 'relaxation', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Volunteer at a local food bank, senior home, or animal shelter.', 'productivity', 1, 4)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Try a Korean face mask routine.', 'relaxation', 0, 1)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Shop at the mall and buy something for yourself.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Attend a creative workshop, like pottery or painting.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Visit a local museum or art gallery.', 'fun', 0, 3)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Go to the movie theatre with a friend.', 'fun', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Play cognitive games, such as Sudoku or crossword puzzles.', 'relaxation', 0, 2)");
    db.rawInsert(
        "INSERT INTO Activities(name, category, outdoors, energy) VALUES('Learn a new language online.', 'productivity', 0, 2)");
  }

  static Future<void> updateActivityPreference(int? change, int? id) async {
    final db = await Database.db();
    await db.rawUpdate(
        'UPDATE Activities SET score = score + ? WHERE id = ?', [change, id]);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await Database.db();
    return db.query('Activities', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> filterData(String? category) async {
    final db = await Database.db();
    return await db
        .rawQuery('SELECT * FROM Activities WHERE category=?', [category]);
  }
}
