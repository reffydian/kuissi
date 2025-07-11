import 'package:flutter/material.dart';
import '../../models/question_model.dart';
import '../../services/api_service.dart';
import '../quiz/result_screen.dart';
import '../../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  final int? categoryId; // ID kategori kuis (opsional)

  const QuizScreen({super.key, this.categoryId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = []; // Daftar soal kuis
  int _currentIndex = 0; // Indeks soal saat ini
  int _score = 0; // Skor pengguna
  bool _isLoading = true; // Status loading
  bool _answered = false; // Status apakah sudah dijawab
  String? _selectedAnswer; // Jawaban yang dipilih user

  @override
  void initState() {
    super.initState();
    loadQuestions(); // Ambil soal saat screen dibuka
  }

  Future<void> loadQuestions() async {
    try {
      // Ambil soal dari API, bisa berdasarkan kategori
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
    if (_answered) return; // Cegah menjawab ulang

    setState(() {
      _selectedAnswer = answer;
      _answered = true;

      // Tambah skor jika benar
      if (answer == _questions[_currentIndex].correctAnswer) {
        _score++;
      }
    });

    // Delay sebentar sebelum lanjut ke soal berikutnya
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _answered = false;
        });
      } else {
        // Jika sudah selesai semua soal, tampilkan hasil
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
      // Tampilkan loading spinner saat soal masih dimuat
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQ = _questions[_currentIndex]; // Ambil soal saat ini

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text('Kuissi'), // Judul app bar
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Padding seluruh body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress kuis (bar + angka)
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

            // Kotak soal + jawaban
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
