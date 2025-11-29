class ApiException implements Exception {
  ApiException({required this.message, required this.uri, this.statusCode});

  final String message;
  final Uri uri;
  final int? statusCode;

  @override
  String toString() {
    final code = statusCode == null ? '' : ' (code $statusCode)';
    return 'ApiException$code at $uri: $message';
  }
}
