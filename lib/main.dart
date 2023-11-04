import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(FlagQuizApp());

class FlagQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}
