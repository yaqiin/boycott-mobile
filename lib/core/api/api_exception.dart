class ApiException implements Exception {
  ApiException({
    required this.message,
    required this.uri,
    this.statusCode,
    this.userFriendlyMessage,
  });

  final String message;
  final Uri uri;
  final int? statusCode;
  final String? userFriendlyMessage;

  @override
  String toString() {
    final code = statusCode == null ? '' : ' (code $statusCode)';
    return 'ApiException$code at $uri: $message';
  }
}
