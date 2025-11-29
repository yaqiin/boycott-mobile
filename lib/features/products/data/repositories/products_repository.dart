import '../../../../core/api/api_service.dart';
import '../models/product_page.dart';

class ProductsRepository {
  ProductsRepository({
    required this.apiService,
    this.productsPath = '/products',
  });

  final ApiService apiService;
  final String productsPath;

  Future<ProductPage> fetchProducts({
    required int page,
    String? categoryId,
  }) async {
    final query = <String, dynamic>{'page': page};

    if (categoryId != null && categoryId.isNotEmpty) {
      query['category_id'] = categoryId;
    }

    final response = await apiService.get(productsPath, queryParameters: query);
    return ProductPage.fromJson(response);
  }
}
