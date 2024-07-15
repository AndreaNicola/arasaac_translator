import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppGuidePage extends StatelessWidget {
  const AppGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appGuide)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(AppLocalizations.of(context)!.appGuideIntroduction),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("• ${AppLocalizations.of(context)!.appGuideFunctions1}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("• ${AppLocalizations.of(context)!.appGuideFunctions2}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("• ${AppLocalizations.of(context)!.appGuideFunctions3}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("• ${AppLocalizations.of(context)!.appGuideFunctions4}"),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.appGuideFunctions1,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("1 - ${AppLocalizations.of(context)!.appGuideFunctions1Step1}"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/home.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("2 - ${AppLocalizations.of(context)!.appGuideFunctions1Step2}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("3 - ${AppLocalizations.of(context)!.appGuideFunctions1Step3}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions2Sub1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions2Sub1Introduction,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/salva_personalizzato.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions2,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "1 - ${AppLocalizations.of(context)!.appGuideFunction2Step1}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              "• ${AppLocalizations.of(context)!.appGuideFunction2Step1Sub1}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              "• ${AppLocalizations.of(context)!.appGuideFunction2Step1Sub2}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/lista_personalizzati.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "2 - ${AppLocalizations.of(context)!.appGuideFunction2Step2}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "3 - ${AppLocalizations.of(context)!.appGuideFunction2Step2}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions3,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/salva_traduzione.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "1 - ${AppLocalizations.of(context)!.appGuideFunctions3Step1}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "2 - ${AppLocalizations.of(context)!.appGuideFunctions3Step2}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions4,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions4Step1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/print.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions4Step2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/pdf.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.appGuideFunctions4Step3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Image.asset("images/guide/condividi.png"),
          ),
        ],
      ),
    );
  }
}
