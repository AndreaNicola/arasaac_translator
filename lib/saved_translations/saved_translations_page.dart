import 'dart:convert';

import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/saved_translations/saved_translations_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model.dart';

class SavedTranslationsPage extends StatefulWidget {
  const SavedTranslationsPage({super.key, required this.onLoad});
  final Function(String name, String originalText, List<List<TranslationResponse>> translationResponses) onLoad;

  @override
  State<StatefulWidget> createState() => _SavedTranslationsPageState();
}

class _SavedTranslationsPageState extends State<SavedTranslationsPage> {
  List<SavedTranslation> savedTranslations = [];

  @override
  void initState() {
    super.initState();
    SavedTranslationsRepository.instance.list().then((value) {
      setState(() {
        savedTranslations = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.savedTranslations)),
      body: savedTranslations.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noSavedTranslations))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: savedTranslations.length,
              itemBuilder: (context, index) {
                Iterable l = jsonDecode(savedTranslations[index].json);
                List<List<TranslationResponse>> translationResponses =
                    List<List<TranslationResponse>>.from(l.map((model) => List<TranslationResponse>.from(model.map((e) => TranslationResponse.fromJson(e)))));

                final subtitle = translationResponses.fold(
                    "", (previousValue, element) => "$previousValue\n${element.fold("", (previousValue, element) => "$previousValue ${element.text}")}");

                return Card(
                  child: ListTile(
                    title: Text(savedTranslations[index].name),
                    visualDensity: VisualDensity.compact,
                    isThreeLine: true,
                    dense: true,
                    subtitle: Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      widget.onLoad(savedTranslations[index].name, savedTranslations[index].originalText, translationResponses);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
    );
  }
}
