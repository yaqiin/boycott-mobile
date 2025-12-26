import 'package:flutter/material.dart';

import '../widgets/product_search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          ProductSearchWidget(
            onSearch: (query) {
              // TODO: wire real search logic
            },
            autoFocus: true,
          ),
        ],
      ),
    );
  }
}
