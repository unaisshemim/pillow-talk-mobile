import 'package:flutter/material.dart';

class PCard extends StatelessWidget {
  final EdgeInsets padding;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BorderRadius borderRadius;
  final Widget child;
  final VoidCallback? onTap;

  const PCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: content)
        : content;
  }
}
