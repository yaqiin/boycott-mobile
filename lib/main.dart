import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'app.dart';
import 'core/localization/translate_preferences.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'ar', 'bn', 'es', 'fr', 'id', 'tr', 'ur'],
    preferences: TranslatePreferences(),
  );
  runApp(LocalizedApp(delegate, const MyApp()));
}
