import 'package:flutter/material.dart';
import '../../models/category_model.dart'; // Model data kategori kuis
import '../../services/api_service.dart'; // Service untuk ambil data dari API
import '../quiz/quiz_screen.dart'; // Navigasi ke halaman quiz

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // List kategori kuis
  List<QuizCategory> _categories = [];

  // Status loading data
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories(); // Panggil saat screen dibuka
  }

  // Ambil data kategori dari API
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

  // Navigasi ke halaman kuis berdasarkan kategori yang dipilih
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
      // AppBar dengan judul
      appBar: AppBar(
        title: const Text('Pilih Kategori'),
        backgroundColor: Colors.deepOrange,
      ),

      // Tampilkan loading saat data masih diambil
      body: _loading
          ? const Center(child: CircularProgressIndicator())

          // Tampilkan daftar kategori dalam bentuk grid
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final cat = _categories[index];

                // Tiap kategori jadi card bisa diklik
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
