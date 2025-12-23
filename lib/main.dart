import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'app.dart';
import 'core/localization/translate_preferences.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'ar', 'bn', 'es', 'fr', 'id', 'tr', 'ur'],
    preferences: TranslatePreferences(),
  );
  themeController = await ThemeController.load();
  runApp(LocalizedApp(delegate, MyApp(themeController: themeController)));
}
