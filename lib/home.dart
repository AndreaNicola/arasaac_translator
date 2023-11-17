import 'package:arasaac_translator/arasaac_service.dart';
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
  final List<TranslationResponse> _translationResponses = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    var translationResponses = await ArasaacService().translate(locale, value);
                    setState(() {
                      _translationResponses.clear();
                      _translationResponses.addAll(translationResponses);
                    });
                  }, // <-- The target method
                );
              },
            ),
          ),
          GridView(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (var translationResponse in _translationResponses)
                PictogramCard(
                  id: translationResponse.pictogramId ?? 0,
                  text: translationResponse.text,
                  error: translationResponse.error,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
