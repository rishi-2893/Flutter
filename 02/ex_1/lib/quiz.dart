import 'package:flutter/material.dart';
import 'package:ex_1/start_screen.dart';
import 'package:ex_1/questions_screen.dart';
import 'package:ex_1/data/questions.dart';
import 'package:ex_1/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // -----------------------METHOD 1-------------------------
  // // Using below gives error:
  // // Value of type 'QuestionsScreen' can't be assigned to var of type 'StartScreen'
  // // var activeScreen = StartScreen();

  // // Use more generic type instead -- like "Widget"
  // // We pass pointer of the switchScreen function to the body of StartScreen widget
  // // This is done to connect switchScreen to Onpressed event in StartScreen
  // // Widget activeScreen = StartScreen(switchScreen); // This will not work
  // // Instead move activeScreen inside initState, ensures proper initialization
  // Widget? activeScreen;

  // // Used to perform initializations, runs only once when object is created
  // @override
  // void initState() {

  //   // This should come first, before any additional work
  //   // This makes sure that parent class is also fully initialized
  //   super.initState();

  //   activeScreen = StartScreen(switchScreen);
  // }

  // void switchScreen(){
  //   setState(() {
  //     activeScreen = const QuestionsScreen();
  //   });
  // -----------------------END METHOD 1-------------------------

  // ----------------------METHOD 2----------------------
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }
  // ----------------------END METHOD 2----------------------

  List<String> selectedAnswers = [];

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void refresh(){
    selectedAnswers = [];
    setState(() {
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chooseAnswer: selectedAnswers,
        onRefresh: refresh,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
