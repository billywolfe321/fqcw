import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/database_helper.dart';

class DailyQuestionScreen extends StatefulWidget {
  @override
  _DailyQuestionScreenState createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  Map<String, dynamic>? dailyFlag;
  double blurLevel = 10.0;
  int attempts = 0;
  String userGuess = '';
  String hint = '';

  @override
  void initState() {
    super.initState();
    checkAndUpdateFlag();
  }

  void checkAndUpdateFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedDate = prefs.getString('lastUpdated');
    DateTime? lastUpdated = storedDate != null ? DateTime.parse(storedDate) : null;

    if (lastUpdated == null || lastUpdated.day != DateTime.now().day) {
      await updateDailyFlag();
    } else {
      String? flagData = prefs.getString('dailyFlag');
      if (flagData != null) {
        setState(() {

        });
        dailyFlag = json.decode(flagData);
      }
    }
    setState(() {});
  }

  Future<void> updateDailyFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> allCountries = await DatabaseHelper.instance.fetchAllCountries();
    Random random = Random();
    dailyFlag = allCountries[random.nextInt(allCountries.length)];

    await prefs.setString('dailyFlag', json.encode(dailyFlag));
    await prefs.setString('lastUpdated', DateTime.now().toIso8601String());
  }

  void checkGuess() {
    setState(() {
      attempts++;
      if (userGuess.toLowerCase() == dailyFlag?['country_name'].toLowerCase()) {
        showCorrectGuessDialog();
      } else if (attempts < 11) {
        blurLevel = max(0, blurLevel - 1);
        if (attempts == 5) {
          hint = "Continent: ${dailyFlag?['continent']}";
        }
      } else {
        showGameOverDialog();
      }
    });
  }

  void showCorrectGuessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Well Done!'),
          content: Text('You guessed the flag correctly!'),
          actions: <Widget>[
            TextButton(
              child: Text('Back to Menu'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Game Over'),
              content: Text('You have used all your attempts.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Back to Menu'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Flag Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Guess the Flag!'),
            SizedBox(height: 20),
            dailyFlag != null
                ? ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
              child: Image.asset('assets/flags/${dailyFlag?['continent']}/${dailyFlag?['country_name'].toLowerCase()}.png'),
            )

                : CircularProgressIndicator(),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => userGuess = value,
              decoration: InputDecoration(
                labelText: 'Enter Country Name',
              ),
            ),
            ElevatedButton(
              onPressed: checkGuess,
              child: Text('Submit Guess'),
            ),
            if (attempts >= 5) Text('Hint: $hint'),
          ],
        ),
      ),
    );
  }
}