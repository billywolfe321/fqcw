import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/database_helper.dart'; // Import your DatabaseHelper class

class DailyQuestionScreen extends StatefulWidget {
  @override
  _DailyQuestionScreenState createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  Map<String, dynamic>? currentFlag;
  bool alreadyAttempted = false;
  int attempts = 0;
  static const int maxAttempts = 3;

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

      if (lastAttemptDate != today || !(prefs.getBool('challengeCompleted') ?? false)) {
        print("Fetching new flag for today's challenge");
        currentFlag = await DatabaseHelper.instance.fetchRandomFlag();
        if (currentFlag != null) {
          prefs.setString('lastAttemptDate', today);
          prefs.setString('dailyFlag', currentFlag!['flagImagePath']);
          prefs.setBool('challengeCompleted', false);
          alreadyAttempted = false;
          attempts = 0;
        } else {
          print("No flag returned from the database");
        }
      } else {
        String flagPath = prefs.getString('dailyFlag') ?? '';
        if (flagPath.isNotEmpty) {
          currentFlag = {'flagImagePath': flagPath};
        }
        alreadyAttempted = prefs.getBool('challengeCompleted') ?? false;
      }
    } catch (e) {
      print('Error in checkDailyQuestion: $e');
    }

    setState(() {});
  }


  void onAnswerAttempt(bool correct) {
    attempts++;
    if (correct || attempts >= maxAttempts) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('challengeCompleted', true);
        if (correct) {
          // Show success message
        } else {
          // Show failure message
        }
      });
      alreadyAttempted = true;
    }
    setState(() {});
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
            if (currentFlag != null && !alreadyAttempted) ...[
              Image.asset('assets/flags/${currentFlag!['flagImagePath']}')
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
