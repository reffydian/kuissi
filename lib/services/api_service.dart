import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';
import '../models/category_model.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions({int amount = 5, int? categoryId}) async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=$amount${categoryId != null ? '&category=$categoryId' : ''}&type=multiple',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((q) => Question.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  static Future<List<QuizCategory>> fetchCategories() async {
    final url = Uri.parse('https://opentdb.com/api_category.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List categories = data['trivia_categories'];
      return categories.map((c) => QuizCategory.fromJson(c)).toList();
    } else {
      throw Exception('Gagal mengambil kategori');
    }
  }
}
