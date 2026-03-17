import 'package:flutter/material.dart';

sealed class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);

  // Background and Surface
  static const Color background = Color(0xFFF5F5F7);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);

  // Text colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Color(0xFF1D1B20);
  static const Color onSurface = Color(0xFF1D1B20);
  static const Color onError = Colors.white;

  // Premium Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFF9747FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Color grey = Color(0xFF79747E);
  static const Color lightGrey = Color(0xFFCAC4D0);
}
