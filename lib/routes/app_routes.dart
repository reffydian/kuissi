import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/quiz/result_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/category/category_screen.dart';

class AppRoutes {
  // Nama-nama route yang digunakan dalam aplikasi
  static const String home = '/home';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String categories = '/categories';

  // Daftar route dan widget yang dituju
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),        // Route ke HomeScreen
    quiz: (context) => const QuizScreen(),        // Route ke QuizScreen
    result: (context) => const ResultScreen(score: 0, total: 0), // Dummy awal, diubah saat navigasi
    login: (context) => const LoginScreen(),      // Route ke LoginScreen
    register: (context) => const RegisterScreen(),// Route ke RegisterScreen
    profile: (context) => const ProfileScreen(),  // Route ke ProfileScreen
    categories: (context) => const CategoryScreen(), // Route ke CategoryScreen
  };
}