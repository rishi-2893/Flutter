import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  bool isCorrect(data) {
    return data['user_answer'] == data['correct_answer'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
            children: summaryData.map((data) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color:
                      isCorrect(data) ? Colors.greenAccent : Colors.pinkAccent,
                ),
                child: Text(((data['question_index'] as int) + 1).toString()),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                // This is used to avoid Column getting of the screen
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['question'] as String,
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(236, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data['user_answer'] as String,
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(110, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      data['correct_answer'] as String,
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 74, 195, 126),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList()),
      ),
    );
  }
}
