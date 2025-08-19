import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class ConnectionScoreWidget extends StatefulWidget {
  final int score;
  final Color color;
  final bool isUser;

  const ConnectionScoreWidget({
    super.key,
    required this.score,
    required this.color,
    required this.isUser,
  });

  @override
  State<ConnectionScoreWidget> createState() => _ConnectionScoreWidgetState();
}

class _ConnectionScoreWidgetState extends State<ConnectionScoreWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.score / 100.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PSizes.s20),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s16),
        border: Border.all(color: context.pColor.neutral.n30),
        boxShadow: [
          BoxShadow(
            color: context.pColor.neutral.n40.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Progress Indicator
          SizedBox(
            width: 120,
            height: 120,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8,
                        backgroundColor: context.pColor.neutral.n30,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.pColor.neutral.n30,
                        ),
                      ),
                    ),
                    // Progress circle
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 8,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                      ),
                    ),
                    // Score text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(widget.score * _animation.value).round()}',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s24),
                            fontWeight: FontWeight.bold,
                            color: context.pColor.neutral.n80,
                          ),
                        ),
                        Text(
                          'Connection',
                          style: TextStyle(
                            fontSize: responsive(context, PSizes.s12),
                            color: context.pColor.neutral.n60,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: PSizes.s16),

          // Score interpretation
          Text(
            _getScoreInterpretation(widget.score),
            style: TextStyle(
              fontSize: responsive(context, PSizes.s16),
              fontWeight: FontWeight.w600,
              color: widget.color,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: PSizes.s8),

          Text(
            _getScoreDescription(widget.score),
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: context.pColor.neutral.n60,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getScoreInterpretation(int score) {
    if (score >= 90) return 'Excellent Connection! 🎉';
    if (score >= 80) return 'Great Connection! 💕';
    if (score >= 70) return 'Good Connection 👍';
    if (score >= 60) return 'Growing Connection 🌱';
    return 'Building Connection 💪';
  }

  String _getScoreDescription(int score) {
    if (score >= 90) {
      return 'You\'re doing amazing! Keep up the great communication and connection.';
    }
    if (score >= 80) {
      return 'Your relationship is thriving! Small improvements can make it even better.';
    }
    if (score >= 70) {
      return 'You\'re on the right track. Focus on more quality time together.';
    }
    if (score >= 60) {
      return 'There\'s room for growth. Try more activities and open communication.';
    }
    return 'Every relationship takes work. Start with small daily check-ins.';
  }
}
