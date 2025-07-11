import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class ResultScreen extends StatelessWidget {
  final int score; // Skor yang diperoleh user
  final int total; // Total soal yang dijawab

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  // Fungsi untuk menghasilkan pesan berdasarkan hasil
  String getResultMessage() {
    double ratio = score / total;
    if (ratio == 1.0) return 'Perfect! Kamu luar biasa 🎯';
    if (ratio >= 0.8) return 'Hebat! 😎';
    if (ratio >= 0.5) return 'Lumayan, bisa lebih baik!';
    return 'Yuk coba lagi, jangan nyerah! 💪';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF7A2F),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Tengah layar secara vertikal
              children: [
                // Judul halaman hasil
                const Text(
                  'Hasil Kuis',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Menampilkan skor
                Text(
                  '$score / $total',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // Pesan motivasi sesuai skor
                Text(
                  getResultMessage(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol untuk ulangi kuis
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/quiz');
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Ulangi Kuis'),
                ),
                const SizedBox(height: 16),

                // Tombol kembali ke home
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Kembali ke Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
