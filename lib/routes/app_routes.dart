import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String profile = '/profile';
  static const String categories = '/categories';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    quiz: (context) => const QuizScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
