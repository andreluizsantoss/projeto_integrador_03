import 'package:flutter/material.dart';

sealed class AppColors {
  // Brand Colors (Figma)
  static const Color primary = Color(0xFF1B4332); // Verde Floresta Escuro
  static const Color secondary = Color(0xFF8DC63F); // Verde Limão

  // Background Gradient
  static const Color gradientTop = Color(0xFF5D8253);
  static const Color gradientBottom = Color(0xFF90C285);

  // Surface & Neutral
  static const Color background = Color(0xFFF2F2F2);
  static const Color surface = Colors.white;
  static const Color cardBackground = Color(0xFFF2F2F2);

  // Functional
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE16464);

  // Text Colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);

  // Helpers
  static const Color grey = Color(0xFF79747E);
  static const Color lightGrey = Color(0xFFCAC4D0);

  // Global Gradient Configuration
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientTop, gradientBottom],
  );
}
