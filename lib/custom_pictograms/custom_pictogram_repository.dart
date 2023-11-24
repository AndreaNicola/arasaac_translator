import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomPictogramRepository {
  static final CustomPictogramRepository instance = CustomPictogramRepository._internal();
  static Database? _db;

  CustomPictogramRepository._internal();

  static Future<Database> _database() async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), 'custom_pictograms_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE custom_pictograms(id INTEGER PRIMARY KEY, key TEXT, image BLOB)',
        );
      },
      version: 1,
    );
  }

  Future<List<CustomPictogram>> list() async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CustomPictogram(
        id: maps[i]['id'],
        key: maps[i]['key'],
        imageBytes: maps[i]['image'],
      );
    });
  }

  Future<void> insert(CustomPictogram cp) async {
    final db = await _database();
    await db.insert(
      'custom_pictograms',
      cp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<CustomPictogram> get(int id) async {
    // Get a reference to the database.
    final db = await _database();

    // Query the table for all The CustomPictograms.
    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms', where: "id = ?", whereArgs: [id]);

    // Convert the List<Map<String, dynamic> into a List<CustomPictogram>.
    return CustomPictogram(
      id: maps.first['id'],
      key: maps.first['key'],
      imageBytes: maps.first['image'],
    );
  }

  Future<CustomPictogram?> getFirstByKeyOrNull(String key) async {
    // Get a reference to the database.
    final db = await _database();

    // Query the table for all The CustomPictograms.
    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms', where: "key = ?", whereArgs: [key]);

    if (maps.isEmpty) {
      return null;
    }

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return CustomPictogram(
      id: maps.first['id'],
      key: maps.first['key'],
      imageBytes: maps.first['image'],
    );
  }
}
