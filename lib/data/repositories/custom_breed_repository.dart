import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/custom_dog_breed.dart';

class BreedRepository {
  static const _dbName = 'custom_breeds.db';
  static const _table = 'breeds';

  Future<Database> get _db async {
    // getDatabasesPath(): Gets the system's default path to store the database.
    // join(...): Builds a correct file path using the OS-specific separator.
    final path = join(await getDatabasesPath(), _dbName);
    // creates/open the database //onCreate only runs when the database is first created
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          tags TEXT
        )
      ''');
    });
  }
  // fetches all rows from the breeds table.
  // Each map (row) is converted to a CustomDogBreed object using .fromMap().
  Future<List<CustomDogBreed>> fetchAllBreeds() async {
    final db = await _db;
    final maps = await db.query(_table);
    return maps.map((map) => CustomDogBreed.fromMap(map)).toList();
  }
  // Converts the CustomDogBreed object into a map using toMap() and inserts it into the table.
  Future<void> insertBreed(CustomDogBreed breed) async {
    final db = await _db;
    await db.insert(_table, breed.toMap());
  }
  // Updates the existing row in the table where id matches.
  // Useful for editing an already saved breed.

  Future<void> updateBreed(CustomDogBreed breed) async {
    final db = await _db;
    await db.update(
      _table,
      breed.toMap(),
      where: 'id = ?',
      whereArgs: [breed.id],
    );
  }
  // Deletes a row from the table where the id matches.
  Future<void> deleteBreed(int id) async {
    final db = await _db;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
