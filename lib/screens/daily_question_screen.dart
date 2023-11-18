import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:ui';

class DailyQuestionScreen extends StatefulWidget {
  @override
  _DailyQuestionScreenState createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  String currentFlag = '';
  double blurLevel = 5.0;
  bool alreadyAttempted = false;

  @override
  void initState() {
    super.initState();
    checkDailyQuestion();
  }

  void checkDailyQuestion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String lastAttemptDate = prefs.getString('lastAttemptDate') ?? '';
      String today = DateTime.now().toString().substring(0, 10);

      if (lastAttemptDate != today) {
        currentFlag = selectRandomFlag();
        prefs.setString('lastAttemptDate', today);
        prefs.setString('dailyFlag', currentFlag);
        blurLevel = 5.0;
        alreadyAttempted = false;
      } else {
        currentFlag = prefs.getString('dailyFlag') ?? '';
        alreadyAttempted = true;
      }

      print('Flag: $currentFlag, Blur: $blurLevel, Attempted: $alreadyAttempted');
      setState(() {});
    } catch (e) {
      print('Error in checkDailyQuestion: $e');
    }
  }

  String selectRandomFlag() {
    List<String> flags = ['flag1.png', 'flag2.png', 'flag3.png'];
    final random = Random();
    return flags[random.nextInt(flags.length)];
  }

  void onAnswerAttempt(bool correct) {
    if (correct) {
      // Handle correct answer
    } else {
      setState(() {
        blurLevel = max(0, blurLevel - 1); // Reduce blur
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Question'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (currentFlag.isNotEmpty) ...[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurLevel, sigmaY: blurLevel),
                child: Image.asset('assets/flags/$currentFlag'),
              ),
              // Add your question and answer options here
              // Use onAnswerAttempt to handle answer attempts
            ] else if (alreadyAttempted) ...[
              Text('You have already attempted today\'s question.'),
            ] else ...[
              CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
