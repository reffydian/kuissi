import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';

void main() async {
  // Inisialisasi Flutter sebelum memanggil Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase dengan konfigurasi dari firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menjalankan aplikasi utama
  runApp(const KuissiApp());
}

class KuissiApp extends StatelessWidget {
  const KuissiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuissi', // Judul aplikasi

      debugShowCheckedModeBanner: false, // Menghilangkan label debug

      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // Warna utama tema aplikasi
        fontFamily: 'Roboto', // Font default
      ),

      routes: AppRoutes.routes, // Rute navigasi yang tersedia

      initialRoute: AppRoutes.login, // Halaman awal saat aplikasi dibuka
    );
  }
}
