import 'dart:convert';

import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/saved_translations/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SavedTranslationsRepository {
  static final SavedTranslationsRepository instance = SavedTranslationsRepository._internal();
  static Database? _db;

  SavedTranslationsRepository._internal();

  static Future<Database> _database() async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), 'translations_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE translations(name TEXT PRIMARY KEY, originalText TEXT, json TEXT)');
      },
      version: 1,
    );
  }

/// Retrieves a list of all saved translations from the database.
///
/// This method asynchronously retrieves all saved translations from the database
/// and returns them as a list of [SavedTranslation] objects.
///
/// It first gets a reference to the database by calling the [_database] method.
/// Then it queries the 'translations' table in the database and gets a list of maps,
/// where each map represents a row in the table.
///
/// Finally, it generates a list of [SavedTranslation] objects from the list of maps
/// by calling the [SavedTranslation.fromJson] factory method for each map.
///
/// Returns a [Future] that completes with a list of [SavedTranslation] objects.
Future<List<SavedTranslation>> list() async {
  final db = await _database();
  final List<Map<String, dynamic>> maps = await db.query('translations', orderBy: 'name');
  return List.generate(maps.length, (i) {
    return SavedTranslation.fromJson(maps[i]);
  });
}

  Future<void> save(String name, String originalText, List<List<TranslationResponse>> translationResponses) async {
    final encodedTranslation = jsonEncode(translationResponses);
    final translation = SavedTranslation(name: name, originalText: originalText, json: encodedTranslation);
    await _save(translation);
  }

  Future<void> _save(SavedTranslation translation) async {
    final db = await _database();
    await db.insert(
      'translations',
      translation.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String name) async {
    final db = await _database();
    await db.delete(
      'translations',
      where: "name = ?",
      whereArgs: [name],
    );
  }

}
