import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class InsightsSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String trend;

  const InsightsSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final isPositiveTrend = trend.startsWith('+');

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
          // Header with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(PSizes.s8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(PSizes.s8),
                ),
                child: Icon(icon, size: PSizes.s16, color: color),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PSizes.s8,
                  vertical: PSizes.s4,
                ),
                decoration: BoxDecoration(
                  color: isPositiveTrend
                      ? context.pColor.success.base.withOpacity(0.1)
                      : context.pColor.error.base.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(PSizes.s12),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontSize: responsive(context, PSizes.s12),
                    fontWeight: FontWeight.w600,
                    color: isPositiveTrend
                        ? context.pColor.success.base
                        : context.pColor.error.base,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: PSizes.s12),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: context.pColor.neutral.n60,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: PSizes.s4),

          // Value
          Text(
            value,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s24),
              fontWeight: FontWeight.bold,
              color: context.pColor.neutral.n80,
            ),
          ),

          const SizedBox(height: PSizes.s4),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s12),
              color: context.pColor.neutral.n50,
            ),
          ),
        ],
      ),
    );
  }
}
