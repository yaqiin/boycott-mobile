import 'package:flutter/material.dart';

import '../../models/boycott_company.dart';
import '../widgets/boycott_product_card.dart';

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
          countryCode: 'OSS',
          country: 'Open Source',
        ),
        BoycottAlternative(
          name: 'Krita',
          link: 'https://krita.org/',
          countryCode: 'OSS',
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
        itemCount: _companies.length + 1,
        itemBuilder: (context, index) {
          if (index == _companies.length) {
            return SizedBox(
              width: 24,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final company = _companies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BoycottProductCard(company: company),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.question_answer),
            icon: Icon(Icons.question_answer_outlined),
            label: 'Why Boycott?',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
