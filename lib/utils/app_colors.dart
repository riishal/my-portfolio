import 'package:flutter/material.dart';

class AppColors {
  static bool isDarkMode = false;

  // Light Theme Colors - Clean and Modern
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1D21);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightAccent = Color(0xFF007BFF); // New Accent Color
  static const Color lightAccentVariant = Color(0xFF0056b3);
  static const Color lightAccentLight = Color(0xFFE6F0FF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightShadow = Color(0x0A000000);
  static const Color lightGradientStart = Color(0xFFF8F9FA);
  static const Color lightGradientEnd = Color(0xFFE9ECEF);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFF3F4F6);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightSuccess = Color(0xFF10B981);
  static const Color lightWarning = Color(0xFFF59E0B);
  static const Color lightInfo = Color(0xFF3B82F6);

  // Dark Theme Colors - Soothing Dark Theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFA0A0A0);
  static const Color darkAccent = Color(0xFF00E5FF); // New Accent Color
  static const Color darkAccentVariant = Color(0xFF00B8D4);
  static const Color darkAccentLight = Color(0xFF2D2D2D);
  static const Color darkCardBackground = Color(0xFF1E1E1E);
  static const Color darkShadow = Color(0x40000000);
  static const Color darkGradientStart = Color(0xFF121212);
  static const Color darkGradientEnd = Color(0xFF1E1E1E);
  static const Color darkBorder = Color(0xFF424242);
  static const Color darkDivider = Color(0xFF2D2D2D);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkSuccess = Color(0xFF03DAC5);
  static const Color darkWarning = Color(0xFFFFB74D);
  static const Color darkInfo = Color(0xFF64B5F6);

  // Theme-dependent getters
  static Color get background => isDarkMode ? darkBackground : lightBackground;
  static Color get surface => isDarkMode ? darkSurface : lightSurface;
  static Color get textPrimary =>
      isDarkMode ? darkTextPrimary : lightTextPrimary;
  static Color get textSecondary =>
      isDarkMode ? darkTextSecondary : lightTextSecondary;
  static Color get accent => isDarkMode ? darkAccent : lightAccent;
  static Color get accentVariant =>
      isDarkMode ? darkAccentVariant : lightAccentVariant;
  static Color get accentLight =>
      isDarkMode ? darkAccentLight : lightAccentLight;
  static Color get cardBackground =>
      isDarkMode ? darkCardBackground : lightCardBackground;
  static Color get shadow => isDarkMode ? darkShadow : lightShadow;
  static Color get gradientStart =>
      isDarkMode ? darkGradientStart : lightGradientStart;
  static Color get gradientEnd =>
      isDarkMode ? darkGradientEnd : lightGradientEnd;
  static Color get border => isDarkMode ? darkBorder : lightBorder;
  static Color get divider => isDarkMode ? darkDivider : lightDivider;
  static Color get error => isDarkMode ? darkError : lightError;
  static Color get success => isDarkMode ? darkSuccess : lightSuccess;
  static Color get warning => isDarkMode ? darkWarning : lightWarning;
  static Color get info => isDarkMode ? darkInfo : lightInfo;

  // Additional utility colors
  static Color get onSurface => textPrimary;
  static Color get onSurfaceVariant => textSecondary;
  static Color get outline => border;

  // Material Color generation for primary swatch
  static MaterialColor get primarySwatch => createMaterialColor(accent);

  // Helper function to create MaterialColor from any Color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
