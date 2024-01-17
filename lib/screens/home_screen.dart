import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'continent_selection_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'daily_question_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final AudioPlayer player = AudioPlayer();
  Color currentColor = Colors.white; // Default color

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor, // Use the selected color
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
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
                      content: const Text('Click Play! Choose Your Continent! Learn. Them. Flags!'),

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
      fontSize: 30.0, // Text size
      fontFamily: 'MyCustomFont',
    ),
  ),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0), // Increased padding
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
                      ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('About Me'),
                      content: const Text('I am me'),
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
                'About Me',
                style: TextStyle(
                  fontSize: 30.0, // Text size
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0), // Increased padding
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Contact Me'),
                      content: const Text('Here is how you can contact me: Call or text 999'),
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
                'Contact Me',
                style: TextStyle(
                  fontSize: 30.0, // Text size
                  fontFamily: 'MyCustomFont',
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0), // Increased padding
                backgroundColor: Colors.blue,
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
