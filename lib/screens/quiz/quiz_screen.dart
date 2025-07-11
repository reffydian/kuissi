import 'package:flutter/material.dart';
import '../../models/question_model.dart';
import '../../services/api_service.dart';
import '../quiz/result_screen.dart';
import '../../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  final int? categoryId;

  const QuizScreen({super.key, this.categoryId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  bool _answered = false;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final questions = await ApiService.fetchQuestions(amount: 5, categoryId: widget.categoryId,);
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handleAnswer(String answer) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;

      if (answer == _questions[_currentIndex].correctAnswer) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _answered = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: _score,
              total: _questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQ = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text('Kuissi'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    color: Colors.deepOrange,
                    backgroundColor: Colors.orange.shade100,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_currentIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Soal & jawaban
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QuestionCard(
                  question: currentQ,
                  selectedAnswer: _selectedAnswer,
                  answered: _answered,
                  onAnswerTap: _handleAnswer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
