import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class ActivityChart extends StatefulWidget {
  final bool isUser;
  final Color color;

  const ActivityChart({super.key, required this.isUser, required this.color});

  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Sample activity data
  Map<String, double> get _activityData => widget.isUser
      ? {
          'Communication': 0.8,
          'Gratitude': 0.9,
          'Quality Time': 0.7,
          'Intimacy': 0.6,
          'Fun Together': 0.85,
        }
      : {
          'Communication': 0.7,
          'Gratitude': 0.8,
          'Quality Time': 0.6,
          'Intimacy': 0.5,
          'Fun Together': 0.75,
        };

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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity Breakdown',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                  color: context.pColor.neutral.n80,
                ),
              ),
              Text(
                '${_getTotalActivities()} activities',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s12),
                  color: context.pColor.neutral.n60,
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s16),

          // Activity bars
          ..._activityData.entries.map(
            (entry) => _buildActivityBar(
              entry.key,
              entry.value,
              _getActivityIcon(entry.key),
            ),
          ),

          const SizedBox(height: PSizes.s12),

          // Summary
          Container(
            padding: const EdgeInsets.all(PSizes.s12),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(PSizes.s8),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, size: PSizes.s16, color: widget.color),
                const SizedBox(width: PSizes.s8),
                Expanded(
                  child: Text(
                    _getSummaryText(),
                    style: TextStyle(
                      fontSize: responsive(context, PSizes.s12),
                      color: context.pColor.neutral.n70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(String label, double progress, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PSizes.s12),
      child: Column(
        children: [
          // Label and percentage
          Row(
            children: [
              Icon(icon, size: PSizes.s16, color: widget.color),
              const SizedBox(width: PSizes.s8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s14),
                    fontWeight: FontWeight.w500,
                    color: context.pColor.neutral.n70,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s12),
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s8),

          // Progress bar
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: context.pColor.neutral.n30,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress * _animation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: LinearGradient(
                        colors: [widget.color, widget.color.withOpacity(0.7)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String activity) {
    switch (activity) {
      case 'Communication':
        return Icons.chat_bubble_outline;
      case 'Gratitude':
        return Icons.favorite_outline;
      case 'Quality Time':
        return Icons.access_time;
      case 'Intimacy':
        return Icons.favorite;
      case 'Fun Together':
        return Icons.celebration;
      default:
        return Icons.circle;
    }
  }

  int _getTotalActivities() {
    return _activityData.values
        .map((value) => (value * 10).round())
        .reduce((a, b) => a + b);
  }

  String _getSummaryText() {
    final strongestArea = _activityData.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    final weakestArea = _activityData.entries
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;

    return 'Strongest: $strongestArea • Focus on: $weakestArea';
  }
}
