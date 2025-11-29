import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF0F9D58);
  static const Color _lightBackground = Color(0xFFEFF7F2);
  static const Color _lightSurface = Color(0xFFE4F0E8);
  static const Color _lightCard = Color(0xFFECF6F0);
  static const Color _lightAccent = Color(0xFF0B4023);
  static const Color _darkSurface = Color(0xFF071410);

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
        primary: const Color(0xFF0F5C38),
        onPrimary: Colors.white,
        secondary: const Color(0xFF1D5A3C),
        surface: _lightCard,
      ),
      scaffoldBackgroundColor: _lightBackground,
      useMaterial3: true,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: _lightBackground,
        elevation: 0,
        foregroundColor: _lightAccent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _lightSurface,
        indicatorColor: const Color(0xFFD2E8DD),
        iconTheme: WidgetStateProperty.all(IconThemeData(color: _lightAccent)),
        labelTextStyle: WidgetStateProperty.all(
          base.textTheme.labelMedium?.copyWith(
            color: _lightAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: _lightCard,
        elevation: 0.3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.03)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
        backgroundColor: Colors.white,
        labelStyle: base.textTheme.labelLarge?.copyWith(
          color: _lightAccent,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: base.textTheme.apply(
        displayColor: _lightAccent,
        bodyColor: _lightAccent,
      ),
      dividerColor: Colors.black.withValues(alpha: 0.04),
      iconTheme: base.iconTheme.copyWith(color: _lightAccent),
      scaffoldBackgroundColor: _lightBackground,
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF010705),
      useMaterial3: true,
    );

    return base.copyWith(
      cardTheme: CardThemeData(
        color: const Color(0xFF050F0B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide.none,
        backgroundColor: _darkSurface,
        labelStyle: base.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      textTheme: base.textTheme.apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      ),
      dividerColor: Colors.white.withValues(alpha: 0.08),
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
    );
  }
}
