import 'package:arasaac_translator/arasaac_service.dart';
import 'package:arasaac_translator/edit_text_dialog.dart';
import 'package:arasaac_translator/pictogram_card.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<List<TranslationResponse>> _translationResponses = [];
  static const double _cardSize = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cardNumber = MediaQuery.of(context).size.width ~/ _cardSize;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              minLines: 3,
              maxLines: 5,
              controller: _controller,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enterText,
              ),
              onChanged: (String value) {
                EasyDebounce.debounce(
                  'translation-debounce', // <-- An ID for this particular debouncer
                  const Duration(milliseconds: 1000), // <-- The debounce duration
                  () async {
                    value = value.toUpperCase();
                    final Locale locale = Localizations.localeOf(context);
                    var translationResponses = await ArasaacService().translateText(locale, value);
                    setState(() {
                      _translationResponses.clear();
                      _translationResponses.addAll(translationResponses);
                    });
                  }, // <-- The target method
                );
              },
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
                              id: _translationResponses[listIndex][gridIndex].pictogramId ?? 0,
                              text: _translationResponses[listIndex][gridIndex].text,
                              error: _translationResponses[listIndex][gridIndex].error,
                            ),
                          ),
                          child: SizedBox(
                            child: PictogramCard(
                              id: _translationResponses[listIndex][gridIndex].pictogramId ?? 0,
                              text: _translationResponses[listIndex][gridIndex].text,
                              error: _translationResponses[listIndex][gridIndex].error,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => EditTextDialog(
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
}
