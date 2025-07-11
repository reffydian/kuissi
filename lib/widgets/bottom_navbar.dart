import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // HOME
              IconButton(
                onPressed: () => onTap(0),
                icon: Icon(
                  Icons.home,
                  size: 28,
                  color: currentIndex == 0 ? Colors.deepOrange : Colors.grey,
                ),
              ),

              // QUIZ - standout style
              GestureDetector(
                onTap: () => onTap(1),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),

              // PROFILE
              IconButton(
                onPressed: () => onTap(2),
                icon: Icon(
                  Icons.person,
                  size: 28,
                  color: currentIndex == 2 ? Colors.deepOrange : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
