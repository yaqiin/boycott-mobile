import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/categories/cubit/categories_cubit.dart';
import '../../features/products/cubit/products_cubit.dart';
import 'products_page.dart';
import 'settings_page.dart';
import 'why_boycott_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: false),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          if (index == 0) {
            context.read<CategoriesCubit>().fetchCategories(
              clearSelection: true,
            );
            context.read<ProductsCubit>().loadProducts(
              categoryId:
                  context.read<CategoriesCubit>().state is CategoriesLoaded
                  ? (context.read<CategoriesCubit>().state as CategoriesLoaded)
                        .selectedCategoryId
                  : null,
            );
          }
        },
        destinations: const [
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

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return const WhyBoycottPage();
      case 2:
        return const SettingsPage();
      default:
        return const ProductsPage();
    }
  }
}
