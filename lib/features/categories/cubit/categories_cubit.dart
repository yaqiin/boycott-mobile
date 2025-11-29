import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/category.dart';
import '../data/repositories/categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required CategoriesRepository categoriesRepository})
    : _categoriesRepository = categoriesRepository,
      super(const CategoriesLoading());

  final CategoriesRepository _categoriesRepository;

  Future<void> fetchCategories() async {
    final previousState = state;
    emit(const CategoriesLoading());
    try {
      final categories = await _categoriesRepository.fetchCategories();
      final previousSelected = previousState is CategoriesLoaded
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
      emit(CategoriesFailure(error.toString()));
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
