part of 'products_cubit.dart';

sealed class ProductsState {
  const ProductsState();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsSuccess extends ProductsState {
  const ProductsSuccess({
    required this.products,
    required this.currentPage,
    required this.hasNextPage,
    required this.categoryId,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<BoycottCompany> products;
  final int currentPage;
  final bool hasNextPage;
  final String? categoryId;
  final bool isLoadingMore;
  final String? loadMoreError;

  ProductsSuccess copyWith({
    List<BoycottCompany>? products,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
    Object? loadMoreError = _sentinel,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      categoryId: categoryId,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: identical(loadMoreError, _sentinel)
          ? this.loadMoreError
          : loadMoreError as String?,
    );
  }

  static const _sentinel = Object();
}

class ProductsFailure extends ProductsState {
  const ProductsFailure(this.message, {this.categoryId});

  final String message;
  final String? categoryId;
}
