import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/api_exception.dart';
import '../../../models/boycott_company.dart';
import '../data/models/product_page.dart';
import '../data/repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required ProductsRepository productsRepository})
    : _productsRepository = productsRepository,
      super(const ProductsLoading());

  final ProductsRepository _productsRepository;

  Future<void> loadProducts({String? categoryId}) async {
    emit(const ProductsLoading());
    try {
      final page = await _productsRepository.fetchProducts(
        page: 1,
        categoryId: categoryId,
      );
      emit(_successFromPage(page, categoryId));
    } catch (error) {
      _logError(error);
      emit(ProductsFailure(_mapErrorToMessage(error), categoryId: categoryId));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ProductsSuccess) return;
    if (!currentState.hasNextPage || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true, loadMoreError: null));
    try {
      final nextPageNumber = currentState.currentPage + 1;
      final page = await _productsRepository.fetchProducts(
        page: nextPageNumber,
        categoryId: currentState.categoryId,
      );

      final updatedProducts = List<BoycottCompany>.of(currentState.products)
        ..addAll(page.products);
      emit(
        currentState.copyWith(
          products: updatedProducts,
          currentPage: page.page,
          hasNextPage: page.hasNextPage,
          isLoadingMore: false,
          loadMoreError: null,
        ),
      );
    } catch (error) {
      _logError(error);
      emit(
        currentState.copyWith(
          isLoadingMore: false,
          loadMoreError: _mapErrorToMessage(error),
        ),
      );
    }
  }

  ProductsSuccess _successFromPage(ProductPage page, String? categoryId) {
    return ProductsSuccess(
      products: page.products,
      currentPage: page.page,
      hasNextPage: page.hasNextPage,
      categoryId: categoryId,
      isLoadingMore: false,
    );
  }
}

String _mapErrorToMessage(
  Object error, {
  String fallback = 'An error occurred. Please try again.',
}) {
  if (error is ApiException && error.userFriendlyMessage != null) {
    return error.userFriendlyMessage!;
  }
  return fallback;
}

void _logError(Object error) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(error);
  }
}
