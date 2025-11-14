import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const AsciiSmugglerApp());
}

class AsciiSmugglerApp extends StatelessWidget {
  const AsciiSmugglerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASCII Smuggler',
      // Localization delegates
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Supported locales
      supportedLocales: const [
        Locale('en'), // English
        Locale('ja'), // Japanese
        Locale('ko'), // Korean
        Locale('es'), // Spanish
        Locale('zh'), // Chinese
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AsciiSmugglerHomePage(),
    );
  }
}
