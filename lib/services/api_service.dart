import 'dart:convert'; // Untuk decode JSON
import 'package:http/http.dart' as http; // HTTP package untuk GET request
import '../models/question_model.dart'; // Model untuk soal kuis
import '../models/category_model.dart'; // Model untuk kategori kuis

class ApiService {
  // Mengambil daftar soal dari API OpenTDB
  static Future<List<Question>> fetchQuestions({int amount = 5, int? categoryId}) async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=$amount${categoryId != null ? '&category=$categoryId' : ''}&type=multiple',
    );

    final response = await http.get(url); // Request ke API
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decode JSON response
      final List results = data['results'];
      return results.map((q) => Question.fromJson(q)).toList(); // Konversi ke List<Question>
    } else {
      throw Exception('Failed to load questions'); // Jika gagal
    }
  }

  // Mengambil daftar kategori kuis dari API
  static Future<List<QuizCategory>> fetchCategories() async {
    final url = Uri.parse('https://opentdb.com/api_category.php');
    final response = await http.get(url); // Request ke API kategori

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decode JSON
      final List categories = data['trivia_categories'];
      return categories.map((c) => QuizCategory.fromJson(c)).toList(); // Konversi ke List<QuizCategory>
    } else {
      throw Exception('Gagal mengambil kategori'); // Jika gagal
    }
  }
}
