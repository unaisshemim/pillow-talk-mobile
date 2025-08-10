import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final double progressValue;
  final String percentageText;
  final String description;

  const ProgressCard({
    super.key,
    required this.title,
    required this.progressValue,
    required this.percentageText,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.pColor;

    return Container(
      padding: const EdgeInsets.all(PSizes.s16),
      decoration: BoxDecoration(
        color: colors.neutral.n10,
        borderRadius: BorderRadius.circular(PSizes.s12),
        border: Border.all(color: colors.neutral.n30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.w600,
                  color: colors.neutral.n80,
                ),
              ),
              Text(
                percentageText,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s16),
                  fontWeight: FontWeight.bold,
                  color: colors.primary.base,
                ),
              ),
            ],
          ),
          const SizedBox(height: PSizes.s8),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: colors.neutral.n30,
            valueColor: AlwaysStoppedAnimation<Color>(colors.primary.base),
          ),
          const SizedBox(height: PSizes.s8),
          Text(
            description,
            style: TextStyle(
              fontSize: responsive(context, PSizes.s14),
              color: colors.neutral.n60,
            ),
          ),
        ],
      ),
    );
  }
}
