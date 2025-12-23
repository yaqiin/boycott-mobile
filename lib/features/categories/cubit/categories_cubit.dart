import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/api_exception.dart';
import '../data/models/category.dart';
import '../data/repositories/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required CategoriesRepository categoriesRepository})
    : _categoriesRepository = categoriesRepository,
      super(const CategoriesLoading());

  final CategoriesRepository _categoriesRepository;

  Future<void> fetchCategories({bool clearSelection = false}) async {
    final previousState = state;
    emit(const CategoriesLoading());
    try {
      final categories = await _categoriesRepository.fetchCategories();
      final previousSelected = clearSelection
          ? null
          : previousState is CategoriesLoaded
          ? previousState.selectedCategoryId
          : null;
      final selectedId = categories.any((c) => c.id == previousSelected)
          ? previousSelected
          : null;
      emit(
        CategoriesLoaded(
          categories: categories,
          selectedCategoryId: selectedId,
        ),
      );
    } catch (error) {
      _logError(error);
      emit(CategoriesFailure(_mapErrorToMessage(error)));
    }
  }

  void selectCategory(String? categoryId) {
    final current = state;
    if (current is! CategoriesLoaded) return;
    if (current.selectedCategoryId == categoryId) return;
    emit(
      CategoriesLoaded(
        categories: current.categories,
        selectedCategoryId: categoryId,
      ),
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
