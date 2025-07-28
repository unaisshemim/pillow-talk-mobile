import 'package:flutter/material.dart';

double responsive(BuildContext context, double size) {
  final textScaler = MediaQuery.of(context).textScaler;
  return textScaler.scale(size);
}
