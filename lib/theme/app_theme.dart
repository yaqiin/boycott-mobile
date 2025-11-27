import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF0F9D58);
  static const Color _lightSurface = Color(0xFFF1FBF4);
  static const Color _darkSurface = Color(0xFF071410);

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7FCF9),
      useMaterial3: true,
    );

    return base.copyWith(
      cardTheme: CardThemeData(
        color: Color(0xFFf5faf9),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.04)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide.none,
        backgroundColor: _lightSurface,
        labelStyle: base.textTheme.labelLarge?.copyWith(
          color: base.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      textTheme: base.textTheme.apply(
        displayColor: const Color(0xFF072318),
        bodyColor: const Color(0xFF072318),
      ),
      dividerColor: Colors.black.withValues(alpha: 0.04),
      iconTheme: base.iconTheme.copyWith(color: const Color(0xFF072318)),
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
