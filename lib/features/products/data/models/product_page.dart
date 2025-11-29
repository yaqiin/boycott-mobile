import '../../../../models/boycott_company.dart';

class ProductPage {
  const ProductPage({
    required this.products,
    required this.page,
    required this.hasNextPage,
    this.totalPages,
  });

  final List<BoycottCompany> products;
  final int page;
  final bool hasNextPage;
  final int? totalPages;

  factory ProductPage.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final products = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(BoycottCompany.fromJson)
              .toList()
        : const <BoycottCompany>[];

    final meta = json['pagination'];
    final currentPage = meta is Map<String, dynamic>
        ? (meta['page'] as num?)?.toInt()
        : null;
    final lastPage = meta is Map<String, dynamic>
        ? (meta['totalPages'] as num?)?.toInt()
        : null;
    final hasNext = meta is Map<String, dynamic>
        ? (meta['hasNextPage'] as bool?) ??
              ((currentPage != null && lastPage != null)
                  ? currentPage < lastPage
                  : false)
        : false;

    return ProductPage(
      products: products,
      page: currentPage ?? 1,
      hasNextPage: hasNext,
      totalPages: lastPage,
    );
  }
}
