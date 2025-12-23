import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/categories/cubit/categories_cubit.dart';
import '../../features/products/cubit/products_cubit.dart';
import '../widgets/boycott_product_card.dart';
import '../widgets/loading_categories_widget.dart';
import '../widgets/loading_products_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesFailure) {
          return _ErrorView(
            message: categoriesState.message,
            onRetry: () {
              context.read<CategoriesCubit>().fetchCategories();
              context.read<ProductsCubit>().loadProducts();
            },
          );
        }

        return const Column(
          children: [
            SizedBox(height: 12),
            _CategoryFilter(),
            SizedBox(height: 12),
            Expanded(child: _ProductsSection()),
          ],
        );
      },
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const LoadingCategoriesWidget();
        }

        if (state is CategoriesFailure) {
          return const SizedBox.shrink();
        }

        if (state is! CategoriesLoaded || state.categories.isEmpty) {
          return const SizedBox();
        }

        final selectedId = state.selectedCategoryId;

        return SizedBox(
          height: 56,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final selected = category.id == selectedId;
              return FilterChip(
                label: Text(category.name),
                selected: selected,
                onSelected: (value) {
                  if (!value) {
                    context.read<CategoriesCubit>().selectCategory(null);
                    context.read<ProductsCubit>().loadProducts();
                  } else {
                    context.read<CategoriesCubit>().selectCategory(category.id);
                    context.read<ProductsCubit>().loadProducts(
                      categoryId: category.id,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const LoadingProductWidget();
        }

        if (state is ProductsFailure) {
          final categoryId = state.categoryId;
          return _ErrorView(
            message: 'Could not load products.\n${state.message}',
            onRetry: () {
              final filterId = (categoryId?.isEmpty ?? true)
                  ? null
                  : categoryId;
              context.read<CategoriesCubit>().fetchCategories();
              context.read<ProductsCubit>().loadProducts(categoryId: filterId);
            },
          );
        }

        if (state is ProductsSuccess) {
          if (state.products.isEmpty) {
            final message = state.categoryId == null
                ? 'No products found.'
                : 'No products found in this category.';
            return Center(child: Text(message));
          }

          final theme = Theme.of(context);
          final showLoadMoreRow =
              state.hasNextPage ||
              state.isLoadingMore ||
              state.loadMoreError != null;
          final itemCount = state.products.length + (showLoadMoreRow ? 1 : 0);

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index < state.products.length) {
                final company = state.products[index];
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
                        onPressed: () =>
                            context.read<ProductsCubit>().loadMore(),
                        child: const Text('Load more'),
                      ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(message, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
