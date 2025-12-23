import 'package:flutter/material.dart';

class AppConstants {
  static const String apiBaseUrl =
      'http://localhost:3000/'; // 'https://boycott.api.yaqiin.org/';
  static const String fallbackLocale = 'en';
  static const List<String> supportedLocales = [
    'en',
    'ar',
    'bn',
    'es',
    'fr',
    'id',
    'tr',
    'ur',
  ];

  static const List<Locale> supportedLocaleObjects = [
    Locale('en'),
    Locale('ar'),
    Locale('bn'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('tr'),
    Locale('ur'),
  ];
}
