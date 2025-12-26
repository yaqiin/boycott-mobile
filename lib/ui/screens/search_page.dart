import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';

import '../../features/products/data/repositories/products_repository.dart';
import '../../features/search/cubit/search_cubit.dart';
import '../widgets/boycott_product_card.dart';
import '../widgets/loading_products_widget.dart';
import '../widgets/product_search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
        productsRepository: context.read<ProductsRepository>(),
      ),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(translate('search.title'))),
      body: Column(
        children: [
          const SizedBox(height: 12),
          ProductSearchWidget(
            onSearch: searchCubit.search,
            autoFocus: true,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchIdle) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        translate('search.startTyping'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                if (state is SearchLoading) {
                  return const LoadingProductWidget();
                }
                if (state is SearchFailure) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => searchCubit.search(''),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is SearchSuccess) {
                  if (state.results.isEmpty) {
                    return Center(child: Text(translate('products.noProducts')));
                  }
                  final theme = Theme.of(context);
                  final showLoadMore = state.hasNextPage ||
                      state.isLoadingMore ||
                      state.loadMoreError != null;
                  final itemCount = state.results.length +
                      (showLoadMore ? 1 : 0);
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index < state.results.length) {
                        final company = state.results[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: BoycottProductCard(company: company),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: [
                            if (state.loadMoreError != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  state.loadMoreError!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                            if (state.isLoadingMore)
                              const CircularProgressIndicator()
                            else if (state.hasNextPage)
                              OutlinedButton(
                                onPressed: searchCubit.loadMore,
                                child: Text(translate('products.loadMore')),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
