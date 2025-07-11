import 'dart:math';

class Question {
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> options = List<String>.from(json['incorrect_answers']);
    options.add(json['correct_answer']);
    options.shuffle(Random()); // acak posisi jawaban

    return Question(
      question: _decodeHtml(json['question']),
      correctAnswer: _decodeHtml(json['correct_answer']),
      allAnswers: options.map(_decodeHtml).toList(),
    );
  }

  // Decode HTML entities (kayak &quot; jadi ")
  static String _decodeHtml(String text) {
    return text.replaceAll('&quot;', '"')
               .replaceAll('&#039;', "'")
               .replaceAll('&amp;', '&')
               .replaceAll('&lt;', '<')
               .replaceAll('&gt;', '>');
  }
}
