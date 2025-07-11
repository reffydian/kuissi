import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/api_service.dart';
import '../quiz/quiz_screen.dart';
import '../../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuizCategory> _categories = [];
  bool _loading = true;
  int _selectedIndex = 0;

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

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
      backgroundColor: const Color(0xFFFF7A2F),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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

                  // Banner
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
                                      const Expanded(
                                        child: Icon(Icons.quiz, size: 60, color: Colors.deepOrange),
                                      ),
                                      const SizedBox(height: 12),
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

          // Floating Navbar
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
