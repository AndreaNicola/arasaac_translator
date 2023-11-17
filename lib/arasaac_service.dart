import 'package:arasaac_api/arasaac_api.dart';
import 'package:flutter/cupertino.dart';

class TranslationResponse {
   String text;
   num? pictogramId;
   bool error;
   int index;

   TranslationResponse({required this.index, required this.text, this.pictogramId, this.error = false});
}

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


    var lines = text.trim().split("\n");
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
        var response = await _api.getPictogramsApi().bestSearchPictograms(language: asaraacLocale, searchText: part);
        translationResponses.add(TranslationResponse(index: index++, text: part, pictogramId: response.data!.first.id));
      } catch (e) {
        translationResponses.add(TranslationResponse(index: index++, text: part, error: true));
      }
    }

    return translationResponses;
  }
}
