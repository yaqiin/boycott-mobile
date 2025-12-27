import 'package:flutter/material.dart';

class AppConstants {
  static const String apiBaseUrl = 'https://boycott.api.yaqiin.org/';
  //'http://localhost:3000/';
  static const String fallbackLocale = 'ar';
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
