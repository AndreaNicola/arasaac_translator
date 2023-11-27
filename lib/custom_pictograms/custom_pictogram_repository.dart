import 'package:arasaac_translator/custom_pictograms/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A repository class for managing custom pictograms.
///
/// This class provides methods for interacting with the custom pictograms database.
/// It uses the singleton pattern to ensure that only one instance of the class is created.
class CustomPictogramRepository {
  /// The singleton instance of the `CustomPictogramRepository` class.
  static final CustomPictogramRepository instance = CustomPictogramRepository._internal();

  /// The `Database` instance used to interact with the custom pictograms database.
  static Database? _db;

  /// The private constructor for the `CustomPictogramRepository` class.
  ///
  /// This constructor is used to create the singleton instance of the class.
  CustomPictogramRepository._internal();

  /// Returns the `Database` instance used to interact with the custom pictograms database.
  ///
  /// If the `Database` instance has not been created yet, it is created and returned.
  /// If the `Database` instance has already been created, it is returned.
  static Future<Database> _database() async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), 'custom_pictograms_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE custom_pictograms(id INTEGER PRIMARY KEY, key TEXT, image BLOB, arasaacId INTEGER)',
        );
      },
      version: 2,
    );
  }

  /// Returns a list of all custom pictograms in the database.
  ///
  /// Each custom pictogram is represented as a `CustomPictogram` instance.
  Future<List<CustomPictogram>> list() async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms');

    return List.generate(maps.length, (i) {
      return CustomPictogram(
        id: maps[i]['id'],
        key: maps[i]['key'],
        imageBytes: maps[i]['image'],
        arasaacId: maps[i]['arasaacId'],
      );
    });
  }

  /// Inserts a custom pictogram into the database.
  ///
  /// The custom pictogram is represented as a `CustomPictogram` instance.
  Future<void> insert(CustomPictogram cp) async {
    final db = await _database();
    await db.insert(
      'custom_pictograms',
      cp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Returns a custom pictogram from the database by id.
  ///
  /// The id is used to query the database for the custom pictogram.
  /// The custom pictogram is represented as a `CustomPictogram` instance.
  Future<CustomPictogram> get(int id) async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms', where: "id = ?", whereArgs: [id]);

    return CustomPictogram(
      id: maps.first['id'],
      key: maps.first['key'],
      imageBytes: maps.first['image'],
      arasaacId: maps.first['arasaacId'],
    );
  }

  /// Returns a custom pictogram from the database by key.
  ///
  /// The key is used to query the database for the custom pictogram.
  /// If a custom pictogram with the given key is found, it is represented as a `CustomPictogram` instance and returned.
  /// If a custom pictogram with the given key is not found, null is returned.
  Future<CustomPictogram?> getFirstByKeyOrNull(String key) async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db.query('custom_pictograms', where: "key = ?", whereArgs: [key]);

    if (maps.isEmpty) {
      return null;
    }

    return CustomPictogram(
      id: maps.first['id'],
      key: maps.first['key'],
      imageBytes: maps.first['image'],
      arasaacId: maps.first['arasaacId'],
    );
  }
}
