import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  // Accepting pointer to switchScreen
  const StartScreen(this.startQuiz, {super.key});

  // switchScreen is a function which takes no arguments and returns nothing
  // NOTE: startQuiz is a pointer to the switchScreen function in quiz.dart
  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            // Below is correct way to make image transparent
            // 1. Set color to white
            // 2. Use VS Code and change transparency using color editor
            color: const Color.fromARGB(150, 255, 255, 255),
          ),

          // AVOID USING BELOW APPROACH for transparency Not efficient
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(height: 80),
          const Text(
            'Learn Flutter the fun way!',
            style: TextStyle(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }
}
