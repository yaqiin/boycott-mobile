import '../../../../core/api/api_service.dart';
import '../models/why_reason.dart';

class WhyRepository {
  WhyRepository({required this.apiService, this.path = '/why-boycott'});

  final ApiService apiService;
  final String path;

  Future<List<WhyReason>> fetchReasons() async {
    final response = await apiService.get(path);
    final data = response['data'];
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(WhyReason.fromJson)
          .toList();
    }
    return const [];
  }
}
