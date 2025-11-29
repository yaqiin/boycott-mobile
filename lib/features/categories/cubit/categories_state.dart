part of 'categories_cubit.dart';

sealed class CategoriesState {
  const CategoriesState();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded({
    required this.categories,
    required this.selectedCategoryId,
  });

  final List<Category> categories;
  final String? selectedCategoryId;
}

class CategoriesFailure extends CategoriesState {
  const CategoriesFailure(this.message);

  final String message;
}
