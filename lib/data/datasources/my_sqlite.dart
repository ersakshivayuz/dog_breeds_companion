import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "items.db";
  String items = 'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)';
//   This line is an SQL command (in the form of a String) that tells SQLite to:
// Create a table named items in the database with two columns:

// Create and initialize the database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    // This gets the default directory path on the device where your app is allowed to store databases.
    final path = join(databasePath, databaseName);
    // Joins the base path with your database file name (items.db)

    return openDatabase(
        path,//   This opens the database at the given path.
        version: 1,
        onCreate: (db, version) async {
      await db.execute(items);
    }
    // If the database doesn't exist, it:
      //
      // Creates it
      //
      // Calls the onCreate callback
      //
      // Executes your CREATE TABLE SQL string (items) to build the schema.

    );

  }

  // Create
  Future<void> insertItem(String name) async {
    final db = await initDB();
    await db.insert(
      'items',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm
          .replace, // Handle conflicts by replacing existing data
    );
  }

  //   READ
  Future<List<Map<String, dynamic>>> fetchItems() async {
    final db = await initDB();
    return await db.query('items');
  }

  //   Update
  Future<void> updateItem(int id, String name) async {
    final db = await initDB();
    await db.update(
      'items',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //   Delete
  Future<void> deleteItem(int id) async {
    final db = await initDB();
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
