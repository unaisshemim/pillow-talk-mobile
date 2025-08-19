import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class MoodTrendChart extends StatefulWidget {
  final bool isUser;
  final Color color;

  const MoodTrendChart({super.key, required this.isUser, required this.color});

  @override
  State<MoodTrendChart> createState() => _MoodTrendChartState();
}

class _MoodTrendChartState extends State<MoodTrendChart>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Sample mood data (1-10 scale)
  List<double> get _moodData => widget.isUser
      ? [7.5, 8.2, 6.8, 9.1, 8.5, 7.9, 8.7] // User data
      : [6.8, 7.5, 7.2, 8.0, 7.8, 8.2, 7.6]; // Partner data

  List<String> get _weekDays => [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: context.pColor.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chart Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mood Journey',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                  color: context.pColor.neutral.n80,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PSizes.s8,
                  vertical: PSizes.s4,
                ),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(PSizes.s8),
                ),
                child: Text(
                  _getAverageMood(),
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s12),
                    fontWeight: FontWeight.w600,
                    color: widget.color,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s20),

          // Chart
          SizedBox(
            height: 150,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 150),
                  painter: MoodChartPainter(
                    moodData: _moodData,
                    color: widget.color,
                    animation: _animation.value,
                    neutralColor: context.pColor.neutral.n30,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: PSizes.s12),

          // Day labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekDays
                .map(
                  (day) => Text(
                    day,
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s12),
                      color: context.pColor.neutral.n60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: PSizes.s12),

          // Mood indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMoodIndicator('😢', 'Low', context.pColor.error.base),
              _buildMoodIndicator('😐', 'Medium', context.pColor.neutral.n60),
              _buildMoodIndicator('😊', 'High', context.pColor.success.base),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodIndicator(String emoji, String label, Color color) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: PSizes.s4),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive(context, PSizes.s12),
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getAverageMood() {
    final average = _moodData.reduce((a, b) => a + b) / _moodData.length;
    return 'Avg: ${average.toStringAsFixed(1)}';
  }
}

class MoodChartPainter extends CustomPainter {
  final List<double> moodData;
  final Color color;
  final double animation;
  final Color neutralColor;

  MoodChartPainter({
    required this.moodData,
    required this.color,
    required this.animation,
    required this.neutralColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final backgroundPaint = Paint()
      ..color = neutralColor.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = <Offset>[];

    // Draw background grid
    for (int i = 0; i <= 10; i++) {
      final y = size.height - (i / 10 * size.height);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), backgroundPaint);
    }

    // Calculate points
    for (int i = 0; i < moodData.length; i++) {
      final x = (i / (moodData.length - 1)) * size.width;
      final normalizedValue = (moodData[i] - 1) / 9; // Normalize to 0-1
      final y = size.height - (normalizedValue * size.height);
      points.add(Offset(x, y));
    }

    // Animate the line drawing
    final animatedLength = (points.length * animation).round();
    if (animatedLength > 0) {
      path.moveTo(points[0].dx, points[0].dy);

      for (int i = 1; i < animatedLength; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      canvas.drawPath(path, paint);

      // Draw dots
      for (int i = 0; i < animatedLength; i++) {
        canvas.drawCircle(points[i], 4, dotPaint);
        canvas.drawCircle(
          points[i],
          4,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(points[i], 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
