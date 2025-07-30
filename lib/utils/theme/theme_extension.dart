import 'package:flutter/material.dart';
import 'package:pillowtalk/utils/constant/colors.dart';

extension PTheme on BuildContext {
  /// Access current brightness
  Brightness get brightness => Theme.of(this).brightness;

  /// Light or dark color palette auto-resolved
  LightThemeColors get light => PColors.light;
  DarkThemeColors get dark => PColors.dark;

  /// Automatically returns the current palette based on theme
  dynamic get pColor =>
      brightness == Brightness.dark ? PColors.dark : PColors.light;

  Color get background => Theme.of(this).scaffoldBackgroundColor;
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get error => Theme.of(this).colorScheme.error;
}
