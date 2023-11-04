import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For SystemNavigator
import 'package:universal_platform/universal_platform.dart';  // For platform checks
import 'dart:html' as html;  // For web-specific behavior
import 'continent_selection_screen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flag Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContinentSelectionScreen(),
                ));
              },
              child: Text('Play Global Game'),
            ),
            SizedBox(height: 20), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Show the "About Us" dialog or navigate to an "About Us" screen
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('About Us'),
                      content: Text('This is a flag quiz app developed by [Your Name]. More details will be added.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('About Us'),
            ),
            SizedBox(height: 20), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Show exit confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Exit App'),
                      content: Text('Are you sure you want to exit?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Stay'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Exit'),
                          onPressed: () {
                            if (UniversalPlatform.isWeb) {
                              // Close the browser tab for web
                              html.window.close();
                            } else {
                              // Use SystemNavigator.pop() for mobile platforms
                              SystemNavigator.pop();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
