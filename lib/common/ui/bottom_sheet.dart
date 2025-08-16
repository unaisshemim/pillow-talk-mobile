// File: p_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';

class PBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final double initialSize;
  final double minSize;
  final double maxSize;

  const PBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.initialSize = 0.6,
    this.minSize = 0.3,
    this.maxSize = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(PSizes.s16),
          decoration: BoxDecoration(
            color: context.pColor.neutral.n10,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(PSizes.s16),
            ),
            boxShadow: [
              BoxShadow(
                color: context.pColor.neutral.n30.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: PSizes.s16),
                  decoration: BoxDecoration(
                    color: context.pColor.neutral.n40,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive(context, PSizes.s20),
                  fontWeight: FontWeight.bold,
                  color: context.pColor.neutral.n80,
                ),
              ),
              const SizedBox(height: PSizes.s16),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
