import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_service.dart';
import 'features/categories/cubit/categories_cubit.dart';
import 'features/categories/data/repositories/categories_repository.dart';
import 'features/products/cubit/products_cubit.dart';
import 'features/products/data/repositories/products_repository.dart';
import 'features/why/cubit/why_cubit.dart';
import 'features/why/data/repositories/why_repository.dart';
import 'theme/app_theme.dart';
import 'ui/screens/home_page.dart';

const String kApiBaseUrl =
    "http://localhost:3000/"; //'https://boycott.api.yaqiin.org/';

final ApiService _apiService = ApiService(
  baseUrl: kApiBaseUrl,
  client: http.Client(),
);

final ProductsRepository _productsRepository = ProductsRepository(
  apiService: _apiService,
);
final CategoriesRepository _categoriesRepository = CategoriesRepository(
  apiService: _apiService,
);
final WhyRepository _whyRepository = WhyRepository(apiService: _apiService);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CategoriesCubit(categoriesRepository: _categoriesRepository)
                ..fetchCategories(),
        ),
        BlocProvider(
          create: (_) =>
              ProductsCubit(productsRepository: _productsRepository)
                ..loadProducts(),
        ),
        BlocProvider(
          create: (_) => WhyCubit(repository: _whyRepository)..loadReasons(),
        ),
      ],
      child: LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Boycott',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          home: const MyHomePage(title: 'Yaqiin Boycott'),
        ),
      ),
    );
  }
}
