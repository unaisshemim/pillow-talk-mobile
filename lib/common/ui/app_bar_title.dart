import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';

import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class PAppBarTitle extends StatelessWidget {
  const PAppBarTitle({
    super.key,
    required this.title,
    this.isBackButtonNeeded = false,
    this.leadingIcon,
    this.trailingAction,
  });

  final String title;
  final bool isBackButtonNeeded;
  final IconData? leadingIcon;
  final Widget? trailingAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isBackButtonNeeded)
          IconButton(
            icon: Icon(Icons.arrow_back, color: context.pColor.neutral.n90),
            onPressed: () => context.pop(),
          )
        else if (leadingIcon != null) ...[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.pColor.primary.base,
            ),
            child: Icon(
              leadingIcon!,
              size: 20,
              color: context.pColor.neutral.n10,
            ),
          ),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: TextStyle(
            color: context.pColor.neutral.n90,
            fontWeight: FontWeight.bold,
            fontSize: responsive(context, PSizes.s18),
          ),
        ),
        const Spacer(),
        if (trailingAction != null) trailingAction!,
      ],
    );
  }
}
