import 'package:arasaac_api/arasaac_api.dart';
import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:flutter/cupertino.dart';

/// A service class for interacting with the Arasaac API.
///
/// This class provides methods for translating text into pictograms using the Arasaac API.
/// It uses the singleton pattern to ensure that only one instance of the class is created.
class ArasaacService {
  /// The singleton instance of the `ArasaacService` class.
  static final ArasaacService instance = ArasaacService._internal();

  /// The `ArasaacApi` instance used to interact with the Arasaac API.
  late ArasaacApi _api;

  /// The factory constructor for the `ArasaacService` class.
  ///
  /// This constructor returns the singleton instance of the `ArasaacService` class.

  /// The private constructor for the `ArasaacService` class.
  ///
  /// This constructor initializes the `_api` property with a new `ArasaacApi` instance.
  ArasaacService._internal() {
    _api = ArasaacApi();
  }

  /// Translates a text into a list of lists of `TranslationResponse` instances.
  ///
  /// This method takes a `locale` and a `text` as parameters.
  /// It splits the `text` into lines and translates each line into a list of `TranslationResponse` instances.
  /// It returns a list of these lists.
  Future<List<List<TranslationResponse>>> translateText(Locale locale, String text) async {
    var lines = text.toUpperCase().trim().split("\n");
    List<List<TranslationResponse>> translationResponses = [];
    for (var line in lines) {
      var translationResponse = await _translateString(locale, line);
      translationResponses.add(translationResponse);
    }
    return translationResponses;
  }

  /// Translates a string into a list of `TranslationResponse` instances.
  ///
  /// This method is private and is used by the `translateText` method.
  /// It takes a `locale` and a `text` as parameters.
  /// It splits the `text` into parts and translates each part into a `TranslationResponse` instance.
  /// It returns a list of these instances.
  Future<List<TranslationResponse>> _translateString(Locale locale, String text) async {
    final asaraacLocale = Locales.valueOf(locale.languageCode);
    List<TranslationResponse> translationResponses = [];

    final separators = RegExp(r"[ ,\.;]");
    final parts = text.trim().split(separators);
    parts.removeWhere((element) => element.isEmpty);

    var index = 0;
    for (var part in parts) {
      try {
        var customPictogram = await CustomPictogramRepository.instance.getFirstByKeyOrNull(part);
        if (customPictogram != null) {
          translationResponses.add(TranslationResponse(index: index++, text: part, customPictogramKey: customPictogram.key));
          continue;
        }

        var response = await _api.getPictogramsApi().bestSearchPictograms(language: asaraacLocale, searchText: part);
        translationResponses.add(TranslationResponse(index: index++, text: part, pictogramId: response.data!.first.id));
      } catch (e) {
        translationResponses.add(TranslationResponse(index: index++, text: part, error: true));
      }
    }

    return translationResponses;
  }
}
