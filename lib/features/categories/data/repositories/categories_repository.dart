import '../../../../core/api/api_service.dart';
import '../models/category.dart';

class CategoriesRepository {
  CategoriesRepository({
    required this.apiService,
    this.categoriesPath = '/categories',
  });

  final ApiService apiService;
  final String categoriesPath;

  Future<List<Category>> fetchCategories() async {
    final response = await apiService.get(categoriesPath);
    final data = response['data'];
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(Category.fromJson)
          .toList();
    }
    if (data is Map<String, dynamic>) {
      return [Category.fromJson(data)];
    }
    return const [];
  }
}
