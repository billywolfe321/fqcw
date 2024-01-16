import 'package:flutter/material.dart';
import 'continent_selection_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'daily_question_screen.dart';

class StartScreen extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await player.play(UrlSource('assets/sounds/button_press.mp3'));
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flaggin good',
              style: TextStyle(
                fontSize: 72.0,
                fontFamily: 'MyCustomFont',
              ),
            ),
            Text(
              'A Flag game by Billy',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'MyCustomFont',
              ),
            ),
            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContinentSelectionScreen(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'MyCustomFont',
                  ),
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
                  builder: (context) => DailyQuestionScreen(), // Navigate to DailyQuestionScreen
                ));
                // Implement Daily Challenge functionality
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Daily Challenge',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'MyCustomFont',
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  MenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('How To Play'),
                      content: const Text('Here is how to play'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () async {
                            await player.play(UrlSource('assets/sounds/button_press.mp3'));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
                        child: Text(
                          'How To Play',
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('About Me'),
                      content: const Text('This is a description about me.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () async {
                            await player.play(UrlSource('assets/sounds/button_press.mp3'));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('About Me'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Contact Me'),
                      content: const Text('Here is how you can contact me.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () async {
                            await player.play(UrlSource('assets/sounds/button_press.mp3'));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ),
    );
  }
}
