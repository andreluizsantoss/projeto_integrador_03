import 'package:flutter/material.dart';

/// Extensão para facilitar o acesso à lógica de responsividade em todo o app.
/// Centraliza os breakpoints e evita o uso repetitivo de MediaQuery manual.
extension ResponsiveContext on BuildContext {
  // Breakpoints privados (Fonte da Verdade)
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;

  /// Largura total da tela
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Altura total da tela
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Identifica se o dispositivo é Mobile (Phone)
  bool get isMobile => screenWidth < _mobileBreakpoint;

  /// Identifica se o dispositivo é Tablet
  bool get isTablet =>
      screenWidth >= _mobileBreakpoint && screenWidth < _tabletBreakpoint;

  /// Identifica se o dispositivo é Desktop / Laptop
  bool get isDesktop => screenWidth >= _tabletBreakpoint;

  /// Identifica se o dispositivo está em uma faixa mobile ou tablet
  bool get isMobileOrTablet => screenWidth < _tabletBreakpoint;

  /// Retorna o crossAxisCount ideal para grids baseado na tela
  int get gridCrossAxisCount {
    if (isMobile || isTablet) return 2;
    return 4;
  }

  /// Retorna um valor baseado no tamanho da tela
  T responsiveValue<T>({required T mobile, required T tablet, T? desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop ?? tablet;
  }
}
