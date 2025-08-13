import 'package:flutter/material.dart';

double responsive(BuildContext context, double size) {
  final textScaler = MediaQuery.of(context).textScaler;
  return textScaler.scale(size);
}

extension ScreenSizeExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
