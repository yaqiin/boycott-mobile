import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/api_exception.dart';
import '../../../models/boycott_company.dart';
import '../../products/data/models/product_page.dart';
import '../../products/data/repositories/products_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(const SearchIdle());

  final ProductsRepository _productsRepository;
  Timer? _debounce;
  String _currentQuery = '';

  void search(String query) {
    _debounce?.cancel();
    _currentQuery = query.trim();

    if (_currentQuery.isEmpty) {
      emit(const SearchIdle());
      return;
    }

    emit(const SearchLoading());

    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final page = await _productsRepository.fetchProducts(
          page: 1,
          name: _currentQuery,
          categoryId: null,
        );
        emit(_successFromPage(page, _currentQuery));
      } catch (error) {
        _logError(error);
        emit(SearchFailure(_mapErrorToMessage(error)));
      }
    });
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! SearchSuccess) return;
    if (!current.hasNextPage || current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true, loadMoreError: null));
    try {
      final nextPage = current.currentPage + 1;
      final page = await _productsRepository.fetchProducts(
        page: nextPage,
        name: current.query,
        categoryId: null,
      );
      final updated = List<BoycottCompany>.of(current.results)
        ..addAll(page.products);
      emit(
        current.copyWith(
          results: updated,
          currentPage: page.page,
          hasNextPage: page.hasNextPage,
          isLoadingMore: false,
          loadMoreError: null,
        ),
      );
    } catch (error) {
      _logError(error);
      emit(
        current.copyWith(
          isLoadingMore: false,
          loadMoreError: _mapErrorToMessage(error),
        ),
      );
    }
  }

  SearchSuccess _successFromPage(ProductPage page, String query) {
    return SearchSuccess(
      results: page.products,
      currentPage: page.page,
      hasNextPage: page.hasNextPage,
      isLoadingMore: false,
      query: query,
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
