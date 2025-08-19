import 'package:flutter/material.dart';
import 'card.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';

class MoodCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String mood;
  final Color color;

  const MoodCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.mood,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PCard(
      backgroundColor: color.withOpacity(0.1),
      border: Border.all(color: color.withOpacity(0.3)),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: responsive(context, 24))),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, 12),
              color: Colors.grey,
            ),
          ),
          Text(
            mood,
            style: TextStyle(
              fontSize: responsive(context, 14),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
