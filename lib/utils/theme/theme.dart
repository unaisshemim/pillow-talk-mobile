import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: PColors.light.neutral.n10,
  primaryColor: PColors.light.primary.base,
  colorScheme: ColorScheme.light(
    primary: PColors.light.primary.base,
    secondary: PColors.light.secondary.base,
    error: PColors.light.error.base,
  ),
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: PColors.light.neutral.n90,
    displayColor: PColors.light.neutral.n90,
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: PColors.dark.neutral.n10,
  primaryColor: PColors.dark.primary.base,
  colorScheme: ColorScheme.dark(
    primary: PColors.dark.primary.base,
    secondary: PColors.dark.secondary.base,
    error: PColors.dark.error.base,
  ),
  textTheme: GoogleFonts.interTextTheme().apply(
    bodyColor: PColors.dark.neutral.n100,
    displayColor: PColors.dark.neutral.n100,
  ),
);
