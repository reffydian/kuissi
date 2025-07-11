import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final String? selectedAnswer;
  final bool answered;
  final Function(String) onAnswerTap;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.answered,
    required this.onAnswerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Box pertanyaan
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            question.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),

        // Jawaban
        ...question.allAnswers.map((answer) {
          bool isSelected = selectedAnswer == answer;
          bool isCorrect = answer == question.correctAnswer;

          Color bgColor = Colors.white;
          Color textColor = Colors.black;

          if (answered) {
            if (isSelected && isCorrect) {
              bgColor = Colors.green;
              textColor = Colors.white;
            } else if (isSelected && !isCorrect) {
              bgColor = Colors.red;
              textColor = Colors.white;
            } else if (isCorrect) {
              bgColor = Colors.green.shade300;
              textColor = Colors.white;
            }
          } else if (isSelected) {
            bgColor = Colors.orange.shade200;
          }

          return GestureDetector(
            onTap: () => onAnswerTap(answer),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                answer,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
          );
        }),
      ],
    );
  }
}
