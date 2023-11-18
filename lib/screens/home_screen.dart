import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';
import 'continent_selection_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class StartScreen extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: const Text('Flags Of The World!!!'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/bg/bg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton(
                    context: context,
                    onPressed: () async {
                      await player.play(UrlSource('assets/sounds/button_press.mp3'));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContinentSelectionScreen(),
                      ));
                    },
                    icon: Icons.play_arrow,
                    label: 'Start',
                  ),
                  const SizedBox(height: 15),
                  buildButton(
                    context: context,
                    onPressed: () async {
                      await player.play(UrlSource('assets/sounds/button_press.mp3'));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuScreen(),
                      ));
                    },
                    icon: Icons.menu,
                    label: 'Menu',
                  ),
                  const SizedBox(height: 15),
                  buildButton(
                    context: context,
                    onPressed: () async {
                      await player.play(UrlSource('assets/sounds/button_press.mp3'));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Exit App'),
                            content: const Text('Are you sure you want to exit?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Stay'),
                                onPressed: () async {
                                  await player.play(UrlSource('assets/sounds/button_press.mp3'));
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Exit'),
                                onPressed: () async {
                                  await player.play(UrlSource('assets/sounds/button_press.mp3'));
                                  if (UniversalPlatform.isWeb) {
                                    SystemNavigator.pop();
                                  } else {
                                    SystemNavigator.pop();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icons.exit_to_app,
                    label: 'Exit',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 5),
          Text(label),
        ],
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
        title: const Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await player.play(UrlSource('assets/sounds/button_press.mp3'));

              },
              child: const Text('no'),
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
                      content: const Text('hellotest'),
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
                      content: const Text('Hellotest'),
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
