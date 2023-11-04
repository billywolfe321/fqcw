import 'package:flutter/material.dart';
import 'dart:math';
import '../utilities/data_loader.dart';

class QuizScreen extends StatefulWidget {
  final String continent;

  QuizScreen({required this.continent});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<List<dynamic>> allCountries = [];
  List<dynamic>? correctCountry;
  List<List<dynamic>>? answerOptions;
  List<String> shownFlagPaths = [];
  int currentQuestionNumber = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    allCountries = await loadCsvData();
    allCountries = filterByContinent(allCountries, widget.continent);
    loadQuestion();
  }

  loadQuestion() {
    correctCountry = getRandomCountry();
    if (correctCountry == null || correctCountry!.isEmpty) {
      // Handle end of quiz scenario
      return;
    }
    answerOptions = getAnswerOptions(correctCountry);
    currentQuestionNumber++;
    setState(() {});
  }

  List<dynamic> getRandomCountry() {
    final random = Random();
    List<dynamic> randomCountry;
    int attempts = 0;

    do {
      int randomIndex = random.nextInt(allCountries.length);
      randomCountry = allCountries[randomIndex];
      attempts++;
      if (attempts > 10) {
        print("Exceeded maximum attempts to get a random country.");
        return [];
      }
    } while (shownFlagPaths.contains(randomCountry[1]));

    shownFlagPaths.add(randomCountry[1]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('$currentQuestionNumber/${allCountries.length}')),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            correctCountry != null
                ? Image.asset(correctCountry![1], width: 200, height: 200)
                : Container(),
            ...answerOptions?.map((option) {
              return ElevatedButton(
                onPressed: () {
                  if (option[0] == correctCountry![0]) {
                    loadQuestion();
                  } else {
                    // Handle wrong answer
                  }
                },
                child: Text(option[0]),
              );
            }) ?? [],
          ],
        ),
      ),
    );
  }
}

