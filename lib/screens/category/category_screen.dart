import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/api_service.dart';
import '../quiz/quiz_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<QuizCategory> _categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final categories = await ApiService.fetchCategories();
      setState(() {
        _categories = categories;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error loading categories: $e');
    }
  }

  void _startQuiz(int categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(categoryId: categoryId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kategori'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return GestureDetector(
                  onTap: () => _startQuiz(cat.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          cat.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}