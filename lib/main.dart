import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(FlagQuizApp());

class FlagQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Quiz',
      theme: ThemeData(
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.brown.shade50),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
          ),
        ),
      ),
      home: StartScreen(),
    );
  }
}

