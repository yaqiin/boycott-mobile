import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'ui/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boycott',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Yaqiin Boycott'),
    );
  }
}
