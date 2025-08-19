import 'package:flutter/material.dart';
import 'package:pillowtalk/common/layout/regular_layout.dart';
import 'package:pillowtalk/common/ui/appbar.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

class PScreenContainer extends StatelessWidget {
  const PScreenContainer({
    super.key,
    this.appBar,
    required this.child,
    this.backgroundColor,
  });

  final Widget? appBar;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PRegularLayout(
      backgroundColor: context.pColor.secondary.s10,
      withSafeArea: true,
      child: Container(
        color: backgroundColor ?? context.pColor.secondary.s20,
        child: Column(
          children: [
            PAppBar(child: appBar),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
