import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const KuissiApp());
}

class KuissiApp extends StatelessWidget {
  const KuissiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuissi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFF7A2F), // warna oranye khas desain
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Arial',
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}