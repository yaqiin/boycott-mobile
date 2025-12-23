import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/translate_preferences.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: AppConstants.fallbackLocale,
    supportedLocales: AppConstants.supportedLocales,
    preferences: TranslatePreferences(),
  );
  themeController = await ThemeController.load();
  runApp(LocalizedApp(delegate, MyApp(themeController: themeController)));
}
