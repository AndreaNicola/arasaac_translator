import 'package:arasaac_api/arasaac_api.dart';
import 'package:flutter/cupertino.dart';

class TranslationResponse {
  final String text;
  final num? pictogramId;
  final bool error;

  const TranslationResponse({required this.text, this.pictogramId, this.error = false});
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

  Future<List<TranslationResponse>> translate(Locale locale, String text) async {
    final asaraacLocale = Locales.valueOf(locale.languageCode);
    final separators = RegExp(r"[ ,.;]");
    final parts = text.split(separators);

    List<TranslationResponse> translationResponses = [];
    for (var part in parts) {
      try {
        var response = await _api.getPictogramsApi().bestSearchPictograms(language: asaraacLocale, searchText: part);
        translationResponses.add(TranslationResponse(text: part, pictogramId: response.data!.first.id));
      } catch (e) {
        translationResponses.add(TranslationResponse(text: part, error: true));
      }
    }

    return translationResponses;
  }
}
