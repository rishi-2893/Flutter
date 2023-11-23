import 'package:flutter/material.dart';
import 'package:ex_1/answer_button.dart';
import 'package:ex_1/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  var currentQuestionIndex = 0;

  void answerQuestion(selectedAnswer){

    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity, // take up max width
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Spreading as children needs Widgets and not a list
            ...currentQuestion.getShuffledAnswers().map((answer){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: AnswerButton(
                  answerText: answer,
                  onTap: (){
                    // We enclosed inside a anonymous function as
                    // onTap accepts only functions without arguments
                    answerQuestion(answer);
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
