import 'dart:typed_data';

import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/arasaac/service.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictograms_page.dart';
import 'package:arasaac_translator/home/pictogram_card.dart';
import 'package:arasaac_translator/saved_translations/saved_translations_page.dart';
import 'package:arasaac_translator/saved_translations/saved_translations_repository.dart';
import 'package:arasaac_translator/utils/edit_text_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../custom_pictograms/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final List<List<TranslationResponse>> _translationResponses = [];

  static const double _cardSize = 100;
  String translationName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cardNumber = MediaQuery.of(context).size.width ~/ _cardSize;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Arasaac Translator'),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: Text(AppLocalizations.of(context)!.customPictograms),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomPictogramsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate_outlined),
              title: Text(AppLocalizations.of(context)!.savedTranslations),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SavedTranslationsPage(onLoad: (String name, String originalText, List<List<TranslationResponse>> translationResponses) {
                        _scaffoldKey.currentState?.closeDrawer();
                        setState(() {
                          _controller.text = originalText;
                          translationName = name;
                          _translationResponses.clear();
                          _translationResponses.addAll(translationResponses);
                        });
                      }),
                    ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(AppLocalizations.of(context)!.about),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Arasaac Translator',
                  applicationVersion: '0.0.1',
                  applicationIcon: const Icon(Icons.translate),
                  children: [
                    Text(AppLocalizations.of(context)!.aboutText),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_translationResponses.isNotEmpty)
            FloatingActionButton(
              onPressed: () {},
              heroTag: 'print',
              child: const Icon(Icons.print),
            ),
          const SizedBox(
            width: 15,
          ),
          if (_translationResponses.isNotEmpty)
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EditTextDialog(
                    title: AppLocalizations.of(context)!.saveTranslationName,
                    initialText: translationName,
                    onSaved: (translationName) async {
                      setState(() {
                        this.translationName = translationName;
                      });
                      await SavedTranslationsRepository.instance.save(translationName, _controller.text, _translationResponses);
                    },
                  ),
                );
              },
              heroTag: 'save',
              child: const Icon(Icons.save),
            ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 75),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              minLines: 3,
              maxLines: 10,
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.enterText,
              ),
              onChanged: (String value) {
                EasyDebounce.debounce(
                  'translation-debounce', // <-- An ID for this particular debouncer
                  const Duration(milliseconds: 1000), // <-- The debounce duration
                  () async {
                    _controller.text = value.toUpperCase();
                    final Locale locale = Localizations.localeOf(context);
                    var translationResponses = await ArasaacService().translateText(locale, _controller.text);
                    setState(() {
                      _translationResponses.clear();
                      _translationResponses.addAll(translationResponses);
                    });
                  }, // <-- The target method
                );
              },
            ),
          ),
          if (_translationResponses.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text("${AppLocalizations.of(context)!.loadedFrom} $translationName",
                    style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
              ),
            ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, listIndex) {
                return GridView.builder(
                  itemCount: _translationResponses[listIndex].length,
                  itemBuilder: (context, gridIndex) {
                    return DragTarget<TranslationResponse>(
                      onWillAccept: (TranslationResponse? data) {
                        return data!.index != _translationResponses[listIndex][gridIndex].index;
                      },
                      onAccept: (TranslationResponse? data) {
                        setState(() {
                          if (data!.index < _translationResponses[listIndex][gridIndex].index) {
                            _translationResponses[listIndex][gridIndex].text = "${data.text} ${_translationResponses[listIndex][gridIndex].text}";
                          } else {
                            _translationResponses[listIndex][gridIndex].text = "${_translationResponses[listIndex][gridIndex].text} ${data.text}";
                          }
                          _translationResponses[listIndex].removeWhere((element) => element.index == data.index);
                        });
                      },
                      builder: (BuildContext context, List<TranslationResponse?> candidateData, List<dynamic> rejectedData) {
                        return Draggable<TranslationResponse>(
                          data: _translationResponses[listIndex][gridIndex],
                          feedback: SizedBox(
                            height: _cardSize,
                            width: 100,
                            child: PictogramCard(
                              arasaacId: _translationResponses[listIndex][gridIndex].pictogramId,
                              customPictogramKey: _translationResponses[listIndex][gridIndex].customPictogramKey,
                              text: _translationResponses[listIndex][gridIndex].text,
                              error: _translationResponses[listIndex][gridIndex].error,
                              selected: false,
                            ),
                          ),
                          child: SizedBox(
                            child: PictogramCard(
                              arasaacId: _translationResponses[listIndex][gridIndex].pictogramId,
                              customPictogramKey: _translationResponses[listIndex][gridIndex].customPictogramKey,
                              text: _translationResponses[listIndex][gridIndex].text,
                              error: _translationResponses[listIndex][gridIndex].error,
                              selected: false,
                              onLongPress: () async {
                                Uint8List? imageBytes;
                                if (_translationResponses[listIndex][gridIndex].customPictogramKey != null) {
                                  imageBytes = await resolveImageBytes(_translationResponses[listIndex][gridIndex].customPictogramKey!);
                                }

                                final cp = CustomPictogram(
                                  key: _translationResponses[listIndex][gridIndex].text,
                                  imageBytes: imageBytes,
                                  arasaacId: _translationResponses[listIndex][gridIndex].pictogramId,
                                );

                                CustomPictogramRepository.instance.insert(cp);
                              },
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => EditTextDialog(
                                        title: AppLocalizations.of(context)!.editText,
                                        initialText: _translationResponses[listIndex][gridIndex].text,
                                        onSaved: (newText) => setState(() => _translationResponses[listIndex][gridIndex].text = newText)));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cardNumber, mainAxisSpacing: 8, crossAxisSpacing: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              },
              separatorBuilder: (context, _) => const Divider(),
              itemCount: _translationResponses.length)
        ],
      ),
    );
  }

  Future<Uint8List?> resolveImageBytes(String customPictogramKey) async {
    final cp = await CustomPictogramRepository.instance.get(customPictogramKey);
    return cp.imageBytes;
  }
}
