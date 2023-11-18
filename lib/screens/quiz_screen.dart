import 'package:flutter/material.dart';
import 'dart:math';
import '../utilities/data_loader.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  final String continent;

  const QuizScreen({super.key, required this.continent});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer player = AudioPlayer();
  List<List<dynamic>> allCountries = [];
  List<List<dynamic>> unshownCountries = [];
  List<dynamic>? correctCountry;
  List<List<dynamic>>? answerOptions;
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
    allCountries = await loadCsvData();
    allCountries.removeAt(0);
    allCountries = filterByContinent(allCountries, widget.continent);
    unshownCountries = List.from(allCountries);
    loadQuestion();
  }

  loadQuestion() {
    if (lives <= 0) {
      showEndOfQuizDialog();
      return;
    }

    correctCountry = getRandomCountry();
    if (correctCountry == null || correctCountry!.isEmpty) {
      showEndOfQuizDialog();
      return;
    }
    answerOptions = getAnswerOptions(correctCountry);
    currentQuestionNumber++;
    setState(() {});
  }

  List<dynamic> getRandomCountry() {
    if (unshownCountries.isEmpty) {
      return [];
    }

    final random = Random();
    int randomIndex = random.nextInt(unshownCountries.length);
    List<dynamic> randomCountry = unshownCountries[randomIndex];
    unshownCountries.removeAt(randomIndex);
    return randomCountry;
  }

  List<List<dynamic>> getAnswerOptions(List<dynamic>? correctCountry) {
    final random = Random();
    List<List<dynamic>> options = [correctCountry!];
    List<List<dynamic>> tempCountries = List.from(allCountries);

    while (options.length < 4) {
      int randomIndex = random.nextInt(tempCountries.length);
      List<dynamic> randomCountry = tempCountries[randomIndex];
      if (!options.contains(randomCountry)) {
        options.add(randomCountry);
        tempCountries.removeAt(randomIndex);
      }
    }

    options.shuffle();
    return options;
  }

  void showEndOfQuizDialog() async {
    if (lives <=0) {
      await player.play(UrlSource('assets/sounds/lose.wav'));
    } else {
      await player.play(UrlSource('assets/sounds/win.wav'));

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(lives <= 0 ? 'Game Over!' : 'Well done!'),
          content: Text(lives <= 0 ? 'You lost all your lives.' : 'Quiz done'),
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
        title: const Text('Quiz'),
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
                ? Image.asset(correctCountry![1], width: 200, height: 200)
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
                          if (disabledOptions.contains(answerOptions![index][0])) {
                            return Colors.red;
                          }
                          if (states.contains(MaterialState.pressed)) {
                            if (answerOptions![index][0] == correctCountry![0]) {
                              return Colors.green;
                            }
                          }
                          return Colors.blue.shade50;
                        },
                      ),
                      side: MaterialStateProperty.all(const BorderSide(color: Colors.black)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: disabledOptions.contains(answerOptions![index][0])
                        ? null
                        : () async {
                      if (answerOptions![index][0] == correctCountry![0]) {
                        await player.play(UrlSource('assets/sounds/correct_answer.mp3'));
                        incorrectAnswers.clear();
                        disabledOptions.clear();
                        loadQuestion();
                      } else {
                        await player.play(UrlSource('assets/sounds/incorrect_answer.mp3'));
                        incorrectAnswers.add(answerOptions![index][0]);
                        disabledOptions.add(answerOptions![index][0]);
                        lives--;
                        if (lives <= 0) {
                          showEndOfQuizDialog();
                        } else {
                          setState(() {});
                        }
                      }
                    },
                    child: Text(answerOptions![index][0]),
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
