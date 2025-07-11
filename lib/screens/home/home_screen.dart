import 'package:flutter/material.dart';
import '../../models/category_model.dart'; // Model data kategori kuis
import '../../services/api_service.dart'; // Service API
import '../quiz/quiz_screen.dart'; // Navigasi ke halaman kuis
import '../../widgets/bottom_navbar.dart'; // Komponen bottom navigation bar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuizCategory> _categories = []; // Daftar kategori kuis
  bool _loading = true; // Status loading data
  int _selectedIndex = 0; // Index navbar yang dipilih

  @override
  void initState() {
    super.initState();
    loadCategories(); // Ambil data kategori saat pertama kali halaman dibuka
  }

  // Ambil kategori dari API
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

  // Handler saat ikon navbar ditekan
  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi ke halaman yang sesuai
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/quiz');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF7A2F), // Background oranye
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header atas (judul + ikon notifikasi)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Kuissi',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.notifications, color: Colors.white, size: 30),
                      ],
                    ),
                  ),

                  // Banner ajakan mulai kuis
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Text(
                          'Yuk mulai kuis sekarang!\nAsah otakmu 💡',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Judul "Discover Quiz"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Discover Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // List horizontal kategori kuis
                  SizedBox(
                    height: 190,
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _categories.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 20),
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              return GestureDetector(
                                onTap: () => _startQuiz(category.id),
                                child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      // Ikon kuis
                                      const Expanded(
                                        child: Icon(Icons.quiz, size: 60, color: Colors.deepOrange),
                                      ),
                                      const SizedBox(height: 12),
                                      // Nama kategori
                                      Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 32),

                  // Judul "Top Kuisser"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Top Kuisser',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Daftar user teratas
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 5,
                      separatorBuilder: (_, __) => const SizedBox(width: 24),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, color: Colors.deepOrange, size: 36),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'User ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom navigation bar mengambang
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavbar(
              currentIndex: _selectedIndex,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }
}
