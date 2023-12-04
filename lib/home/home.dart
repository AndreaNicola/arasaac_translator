import 'package:arasaac_translator/arasaac/model.dart';
import 'package:arasaac_translator/arasaac/service.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictogram_repository.dart';
import 'package:arasaac_translator/custom_pictograms/custom_pictograms_page.dart';
import 'package:arasaac_translator/home/pictogram_card.dart';
import 'package:arasaac_translator/print_service/print_service.dart';
import 'package:arasaac_translator/saved_translations/saved_translations_page.dart';
import 'package:arasaac_translator/saved_translations/saved_translations_repository.dart';
import 'package:arasaac_translator/utils/edit_text_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../confirm_custom_pictogram_save/confirm_custom_pictogram_save.dart';
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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/icon_ARASAAC.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
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
                 PackageInfo.fromPlatform().then((packageInfo) {
                   showAboutDialog(
                    context: context,
                    applicationName: packageInfo.appName,
                    applicationVersion: packageInfo.version,
                    applicationIcon: Image.asset(
                      'images/icon_ARASAAC.png',
                      width: 50,
                      height: 50,
                    ),
                    children: [
                      Text(AppLocalizations.of(context)!.aboutText),
                    ],
                  );
                });

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
              onPressed: () {
                PrintService.instance
                    .print(fileName: translationName.isEmpty ? "new-translation" : translationName, translationResponses: _translationResponses);
              },
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
        title: const Text("ARASAAC Translator"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 75),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return newValue.copyWith(text: newValue.text.toUpperCase());
                })
              ],
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
                    final Locale locale = Localizations.localeOf(context);
                    var translationResponses = await ArasaacService.instance.translateText(locale, _controller.text);
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
                            width: _cardSize,
                            child: PictogramCard(
                              arasaacId: _translationResponses[listIndex][gridIndex].pictogramId,
                              customPictogramKey: _translationResponses[listIndex][gridIndex].customPictogramKey,
                              text: _translationResponses[listIndex][gridIndex].text,
                            ),
                          ),
                          child: SizedBox(
                            child: PictogramCard(
                              arasaacId: _translationResponses[listIndex][gridIndex].pictogramId,
                              customPictogramKey: _translationResponses[listIndex][gridIndex].customPictogramKey,
                              text: _translationResponses[listIndex][gridIndex].text,
                              onLongPress: () {
                                if (_translationResponses[listIndex][gridIndex].customPictogramKey != null ||
                                    _translationResponses[listIndex][gridIndex].pictogramId != null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ConfirmCustomPictogramSave(
                                            onConfirm: () async {
                                              Navigator.pop(context);
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
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            translationResponse: _translationResponses[listIndex][gridIndex],
                                          ));
                                }
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
    return cp?.imageBytes;
  }
}
