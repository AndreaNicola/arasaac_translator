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

  Future<List<SavedTranslation>> list() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query('translations');
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
}
