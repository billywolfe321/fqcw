import 'package:flutter/material.dart';
import 'quiz_screen.dart';  // Update this path to the location of your quiz_screen.dart

class ContinentSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Continent'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'africa'),
                ));
              },
              child: Text('Africa'),
            ),
            SizedBox(height: 20),  // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'asia'),
                ));
              },
              child: Text('Asia'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'europe'),
                ));
              },
              child: Text('Europe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'North America'),
                ));
              },
              child: Text('North America'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'South America'),
                ));
              },
              child: Text('South America'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'oceania'),
                ));
              },
              child: Text('Oceania'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(continent: 'all'),
                ));
              },
              child: Text('All Countries'),
            ),
          ],
        ),
      ),
    );
  }
}
