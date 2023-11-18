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
                  builder: (context) => const QuizScreen(continent: 'africa'),
                ));
              },
              child: const Text('Africa'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'asia'),
                ));
              },
              child: const Text('Asia'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'europe'),
                ));
              },
              child: const Text('Europe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'North America'),
                ));
              },
              child: const Text('North America'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'South America'),
                ));
              },
              child: const Text('South America'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'oceania'),
                ));
              },
              child: const Text('Oceania'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QuizScreen(continent: 'all'),
                ));
              },
              child: const Text('All Countries'),
            ),
          ],
        ),
      ),
    );
  }
}
