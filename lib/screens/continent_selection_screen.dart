import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'package:audioplayers/audioplayers.dart';


class ContinentSelectionScreen extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  ContinentSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Continent'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'Africa'),
                ));
              },
              child: Text(
                'Africa',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'Asia'),
                ));
              },
              child: Text(
                'Asia',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'Europe'),
                ));
              },
              child: Text(
                'Europe',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'North America'),
                ));
              },
              child: Text(
                'North America',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'South America'),
                ));
              },
              child: Text(
                'South America',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'Oceania'),
                ));
              },
              child: Text(
                'Oceania',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'all'),
                ));
              },
              child: Text(
                'All Countries',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
      const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
