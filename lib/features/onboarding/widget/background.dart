import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // darkened ~20 %
            Color(0xFFE0E2FF), // deeper lavender
            Color(0xFFF7EAEF), // richer peach-pink
            Color(0xFFDFF9F9), // stronger mint-cyan
          ],
        ),
      ),
    );
  }
}
