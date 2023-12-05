import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppGuidePage extends StatelessWidget {
  const AppGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appGuide)),
      body: const Center(
        child: Text('Coming soon! '),
      ),
    );
  }
}
