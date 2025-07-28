import 'package:flutter/material.dart';

class PRegularLayout extends StatelessWidget {
  const PRegularLayout(
      {super.key,
      this.backgroundColor,
      required this.child,
      this.withSafeArea = false});

  final Color? backgroundColor;
  final Widget child;
  final bool withSafeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: withSafeArea
          ? SafeArea(maintainBottomViewPadding: true, child: child)
          : child,
    );
  }
}
