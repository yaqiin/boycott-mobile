import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';

import '../../features/categories/cubit/categories_cubit.dart';
import '../../features/products/cubit/products_cubit.dart';
import '../../features/why/cubit/why_cubit.dart';
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
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: translate('nav.products'),
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.question_answer),
            icon: Icon(Icons.question_answer_outlined),
            label: translate('nav.why'),
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: translate('nav.settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        context.read<WhyCubit>().loadReasons();
        return const WhyBoycottPage();
      case 2:
        return const SettingsPage();
      default:
        return const ProductsPage();
    }
  }
}
