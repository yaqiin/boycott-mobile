import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF0F9D58);
  static const Color _lightBackground = Color(0xFFEFF7F4);
  static const Color _lightCard = Color(0xFFFCFEFD);
  static const Color _lightCardHeader = Color(0xFFD6F0EA);
  static const Color _lightAccent = Color(0xFF0A452C);
  static const Color _lightAccentMuted = Color(0xFF14643D);
  static const Color _darkSurface = Color(0xFF071410);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
      primary: _lightAccentMuted,
      onPrimary: Colors.white,
      secondary: _lightAccent,
      surface: _lightCard,
    ).copyWith(surfaceContainerHighest: _lightCardHeader);

    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: scheme,
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
        backgroundColor: _lightBackground,
        indicatorColor: const Color(0xFFDCEFE6),
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
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.04)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: Colors.black.withValues(alpha: 0.05)),
        backgroundColor: const Color(0xFFFAFDFC),
        selectedColor: const Color(0xFFD5EBD9),
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
