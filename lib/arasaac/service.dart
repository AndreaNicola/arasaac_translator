import 'package:arasaac_api/arasaac_api.dart';
import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:flutter/cupertino.dart';

class ArasaacService {
  static final ArasaacService _instance = ArasaacService._internal();
  late ArasaacApi _api;

  factory ArasaacService() {
    return _instance;
  }

  ArasaacService._internal() {
    _api = ArasaacApi();
  }

  Future<List<List<TranslationResponse>>> translateText(Locale locale, String text) async {
    var lines = text.toUpperCase().trim().split("\n");
    List<List<TranslationResponse>> translationResponses = [];
    for (var line in lines) {
      var translationResponse = await _translateString(locale, line);
      translationResponses.add(translationResponse);
    }
    return translationResponses;
  }

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
          translationResponses.add(TranslationResponse(index: index++, text: part, customPictogramId: customPictogram.id));
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
