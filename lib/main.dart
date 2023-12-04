import 'package:arasaac_translator/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late ColorScheme lightTheme;
late ColorScheme darkTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  lightTheme = await ColorScheme.fromImageProvider(provider: Image.asset('images/logo_ARASAAC.png').image, brightness: Brightness.light);
  darkTheme = await ColorScheme.fromImageProvider(provider: Image.asset('images/logo_ARASAAC.png').image, brightness: Brightness.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arasaac Translator',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('it'), // Italian
      ],
      darkTheme: ThemeData(
        colorScheme: darkTheme,
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: lightTheme,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
