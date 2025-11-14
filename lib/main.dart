import 'package:flutter/material.dart';
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
