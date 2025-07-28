import 'package:flutter/material.dart';

/// Master color palette structure for Pillow Talk App
/// Supports Light and Dark mode via KColors.light / KColors.dark

abstract class PColors {
  static const light = LightThemeColors();
  static const dark = DarkThemeColors();
}

/// Light Theme Color Set (Based on landing page)
class LightThemeColors {
  const LightThemeColors();

  final primary = const _PrimaryColor();
  final secondary = const _SecondaryColor();
  final neutral = const _NeutralColor();
  final error = const _ErrorColor();
  final success = const _SuccessColor();
}

/// Dark Theme Color Set (Customized for contrast and accessibility)
class DarkThemeColors {
  const DarkThemeColors();

  final primary = const _DarkPrimaryColor();
  final secondary = const _DarkSecondaryColor();
  final neutral = const _DarkNeutralColor();
  final error = const _ErrorColor();
  final success = const _SuccessColor();
}

/// PRIMARY COLOR – Amber/Orange for highlights & buttons
class _PrimaryColor {
  const _PrimaryColor();

  final Color p10 = const Color(0xFFFFF7EC);
  final Color p20 = const Color(0xFFFFEED3);
  final Color p30 = const Color(0xFFFFE4B7);
  final Color p40 = const Color(0xFFFFD89A);
  final Color p50 = const Color(0xFFFFCC7A);
  final Color base = const Color(0xFFFBA63A);
  final Color p60 = const Color(0xFFD18A30);
  final Color p70 = const Color(0xFFA76F27);
  final Color p80 = const Color(0xFF7E531D);
  final Color p90 = const Color(0xFF543713);
  final Color p100 = const Color(0xFF32210C);
}

/// SECONDARY COLOR – Teal-Blue for accents & illustrations
class _SecondaryColor {
  const _SecondaryColor();

  final Color s10 = const Color(0xFFF7FAFB);
  final Color s20 = const Color(0xFFEFF4F7);
  final Color s30 = const Color(0xFFD7E4ED);
  final Color s40 = const Color(0xFFC2D8E8);
  final Color s50 = const Color(0xFFA6C4DE);
  final Color base = const Color(0xFF6EA7D3);
  final Color s60 = const Color(0xFF4B90C6);
  final Color s70 = const Color(0xFF327DB4);
  final Color s80 = const Color(0xFF23679A);
  final Color s90 = const Color(0xFF175278);
  final Color s100 = const Color(0xFF0E3E59);
}

/// NEUTRAL / BACKGROUND COLORS
class _NeutralColor {
  const _NeutralColor();

  final Color n10 = const Color(0xFFFFFFFF); // White
  final Color n20 = const Color(0xFFF9F9F9);
  final Color n30 = const Color(0xFFF0F0F0);
  final Color n40 = const Color(0xFFE5E5E5);
  final Color n50 = const Color(0xFFD0D0D0);
  final Color base = const Color(0xFFB0B0B0);
  final Color n60 = const Color(0xFF8A8A8A);
  final Color n70 = const Color(0xFF646464);
  final Color n80 = const Color(0xFF3E3E3E);
  final Color n90 = const Color(0xFF2A2A2A);
  final Color n100 = const Color(0xFF121212);
}

/// ERROR COLORS (Shared across themes)
class _ErrorColor {
  const _ErrorColor();

  final Color e10 = const Color(0xFFFDD8CD);
  final Color e20 = const Color(0xFFFCBEAC);
  final Color e30 = const Color(0xFFFB9D83);
  final Color e40 = const Color(0xFFFA7C5A);
  final Color e50 = const Color(0xFFF85C30);
  final Color base = const Color(0xFFF73B07);
  final Color e60 = const Color(0xFFCE3106);
  final Color e70 = const Color(0xFFA52705);
  final Color e80 = const Color(0xFF7C1E04);
  final Color e90 = const Color(0xFF521402);
  final Color e100 = const Color(0xFF310C01);
}

/// SUCCESS COLORS (Shared across themes)
class _SuccessColor {
  const _SuccessColor();

  final Color s10 = const Color(0xFFCCEAD6);
  final Color s20 = const Color(0xFFAADCBA);
  final Color s30 = const Color(0xFF80CA98);
  final Color s40 = const Color(0xFF55B875);
  final Color s50 = const Color(0xFF2AA753);
  final Color base = const Color(0xFF009530);
  final Color s60 = const Color(0xFF007C28);
  final Color s70 = const Color(0xFF006320);
  final Color s80 = const Color(0xFF004B18);
  final Color s90 = const Color(0xFF003210);
  final Color s100 = const Color(0xFF001E0A);
}

/// DARK THEME – PRIMARY COLOR
class _DarkPrimaryColor {
  const _DarkPrimaryColor();

  final Color p10 = const Color(0xFF2C1A00);
  final Color p20 = const Color(0xFF3E2403);
  final Color p30 = const Color(0xFF5A3508);
  final Color p40 = const Color(0xFF71440A);
  final Color p50 = const Color(0xFF8A540D);
  final Color base = const Color(0xFFFCB55B);
  final Color p60 = const Color(0xFFFCC47C);
  final Color p70 = const Color(0xFFFDD39D);
  final Color p80 = const Color(0xFFFEE1BD);
  final Color p90 = const Color(0xFFFEEDD8);
  final Color p100 = const Color(0xFFFFFFFF);
}

/// DARK THEME – SECONDARY COLOR
class _DarkSecondaryColor {
  const _DarkSecondaryColor();

  final Color s10 = const Color(0xFF0E1D24);
  final Color s20 = const Color(0xFF18313F);
  final Color s30 = const Color(0xFF244658);
  final Color s40 = const Color(0xFF2F5A71);
  final Color s50 = const Color(0xFF397088);
  final Color base = const Color(0xFF6EA7D3);
  final Color s60 = const Color(0xFF9DC7E5);
  final Color s70 = const Color(0xFFC3DEF0);
  final Color s80 = const Color(0xFFDCEBF7);
  final Color s90 = const Color(0xFFF0F7FB);
  final Color s100 = const Color(0xFFFFFFFF);
}

/// DARK THEME – NEUTRAL COLOR
class _DarkNeutralColor {
  const _DarkNeutralColor();

  final Color n10 = const Color(0xFF1A1A1A);
  final Color n20 = const Color(0xFF212121);
  final Color n30 = const Color(0xFF2E2E2E);
  final Color n40 = const Color(0xFF3B3B3B);
  final Color n50 = const Color(0xFF525252);
  final Color base = const Color(0xFF6A6A6A);
  final Color n60 = const Color(0xFF8A8A8A);
  final Color n70 = const Color(0xFFA0A0A0);
  final Color n80 = const Color(0xFFB6B6B6);
  final Color n90 = const Color(0xFFD0D0D0);
  final Color n100 = const Color(0xFFFFFFFF);
}
