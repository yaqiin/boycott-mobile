import 'package:flutter/material.dart';
import 'models/boycott_company.dart';
import 'theme/app_theme.dart';
import 'widgets/boycott_company_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boycott',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Boycott'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  List<BoycottCompany> get _companies => const [
    BoycottCompany(
      name: 'Google Maps',
      category: 'Technology',
      country: 'United States',
      countryCode: 'US',
      alternatives: [
        BoycottAlternative(
          name: '2GIS',
          link: 'https://2gis.ae/',
          countryCode: 'RU',
          country: 'Russia',
        ),
        BoycottAlternative(
          name: 'Open Street Map',
          link: 'https://www.openstreetmap.org/',
          countryCode: 'GB',
          country: 'United Kingdom',
        ),
      ],
    ),
    BoycottCompany(
      name: 'Adobe Photoshop',
      category: 'Technology',
      country: 'United States',
      countryCode: 'US',
      alternatives: [
        BoycottAlternative(
          name: 'GIMP',
          link: 'https://www.gimp.org/',
          countryCode: 'US',
          country: 'Open Source',
        ),
        BoycottAlternative(
          name: 'Krita',
          link: 'https://krita.org/',
          countryCode: 'NL',
          country: 'Open Source',
        ),
        BoycottAlternative(
          name: 'Affinity Photo',
          link: 'https://affinity.serif.com/en-us/photo/',
          countryCode: 'GB',
          country: 'United Kingdom',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: false),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _companies.length,
        itemBuilder: (context, index) {
          final company = _companies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BoycottCompanyCard(company: company),
          );
        },
      ),
    );
  }
}
