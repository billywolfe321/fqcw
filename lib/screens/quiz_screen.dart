import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import '../utilities/database_helper.dart';

class QuizScreen extends StatefulWidget {
  final String continent;

  const QuizScreen({super.key, required this.continent});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer player = AudioPlayer();
  List<Map<String, dynamic>> allCountries = [];
  List<Map<String, dynamic>> unshownCountries = [];
  Map<String, dynamic>? correctCountry;
  List<Map<String, dynamic>>? answerOptions;
  List<String> incorrectAnswers = [];
  List<String> disabledOptions = [];
  int currentQuestionNumber = 0;
  int lives = 10;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    allCountries = await DatabaseHelper.instance.fetchCountriesByContinent(widget.continent);
    unshownCountries = List.from(allCountries);
    loadQuestion();
  }

  loadQuestion() {
    if (lives <= 0 || unshownCountries.isEmpty) {
      checkGameOver();
      return;
    }

    correctCountry = getRandomCountry();
    if (correctCountry == null || correctCountry!.isEmpty) {
      checkGameOver();
      return;
    }
    answerOptions = getAnswerOptions(correctCountry);
    currentQuestionNumber++;
    setState(() {});
  }

  Map<String, dynamic> getRandomCountry() {
    if (unshownCountries.isEmpty) {
      return {};
    }

    final random = Random();
    int randomIndex = random.nextInt(unshownCountries.length);
    Map<String, dynamic> randomCountry = unshownCountries[randomIndex];
    unshownCountries.removeAt(randomIndex);
    return randomCountry;
  }

  List<Map<String, dynamic>> getAnswerOptions(Map<String, dynamic>? correctCountry) {
    final random = Random();
    List<Map<String, dynamic>> options = [correctCountry!];
    List<Map<String, dynamic>> tempCountries = List.from(allCountries);

    tempCountries.removeWhere((country) => country['country_name'] == correctCountry['country_name']);

    while (options.length < 4) {
      int randomIndex = random.nextInt(tempCountries.length);
      Map<String, dynamic> randomCountry = tempCountries[randomIndex];
      options.add(randomCountry);
      tempCountries.removeAt(randomIndex);
    }

    options.shuffle();
    return options;
  }

  void checkGameOver() {
    bool isWin = unshownCountries.isEmpty && lives > 0;
    showEndOfQuizDialog(isWin);
  }

  void showEndOfQuizDialog(bool isWin) async {
    String soundFile = isWin ? 'assets/sounds/win.wav' : 'assets/sounds/lose.wav';
    await player.play(UrlSource(soundFile));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isWin ? 'Well done!' : 'Game Over!'),
          content: Text(isWin ? 'Quiz done' : 'You lost all your lives.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart Quiz'),
              onPressed: () {
                player.stop();
                Navigator.of(context).pop();
                restartQuiz();
              },
            ),
            TextButton(
              child: const Text('Back to Menu'),
              onPressed: () {
                player.stop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  void restartQuiz() {
    unshownCountries = List.from(allCountries);
    currentQuestionNumber = 0;
    lives = 10;
    incorrectAnswers.clear();
    disabledOptions.clear();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: List.generate(
                    10,
                        (index) => Icon(
                      Icons.favorite,
                      color: index < (10 - lives) ? Colors.grey : Colors.red,
                      size: 20.0,
                    ),
                  ),
                ),
                Text('$currentQuestionNumber/${allCountries.length}'),
              ],
            ),
            const SizedBox(height: 20),
            correctCountry != null
                ? Image.asset('${correctCountry!['flag_image_path']}', width: 200, height: 200)
                : Container(),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0,
                ),
                itemCount: answerOptions?.length ?? 0,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (disabledOptions.contains(answerOptions![index]['country_name'])) {
                            return Colors.red;
                          }
                          if (states.contains(MaterialState.pressed)) {
                            if (answerOptions![index]['country_name'] == correctCountry!['country_name']) {
                              return Colors.green;
                            }
                          }
                          return Colors.blue.shade50;
                        },
                      ),
                      side: MaterialStateProperty.all(const BorderSide(color: Colors.black)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    // Inside the ElevatedButton's onPressed callback
                    onPressed: disabledOptions.contains(answerOptions![index]['country_name']) || lives <= 0
                        ? null
                        : () async {
                      if (answerOptions![index]['country_name'] == correctCountry!['country_name']) {
                        await player.play(UrlSource('assets/sounds/correct_answer.mp3'));
                        incorrectAnswers.clear();
                        disabledOptions.clear();
                        loadQuestion();
                      } else {
                        await player.play(UrlSource('assets/sounds/incorrect_answer.mp3'));
                        incorrectAnswers.add(answerOptions![index]['country_name']);
                        disabledOptions.add(answerOptions![index]['country_name']);
                        if (--lives <= 0) {
                          setState(() {});
                          // Don't call showEndOfQuizDialog here, loadQuestion will handle it
                        } else {
                          setState(() {});
                        }
                      }
                    },

                    child: Text(answerOptions![index]['country_name']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
