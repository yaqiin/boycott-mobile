import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'api_exception.dart';

class ApiService {
  ApiService({
    required this.baseUrl,
    http.Client? client,
    InternetConnection? connectionChecker,
    this.defaultHeaders,
  }) : _client = client ?? http.Client(),
       _connectionChecker = connectionChecker ?? InternetConnection();

  final String baseUrl;
  final http.Client _client;
  final InternetConnection _connectionChecker;
  final Map<String, String>? defaultHeaders;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final hasConnection = await _connectionChecker.hasInternetAccess;
    if (!hasConnection) {
      throw ApiException(
        message: 'No internet connection',
        uri: uri,
        userFriendlyMessage:
            'No internet connection detected. Please check your connection and try again.',
      );
    }

    final response = await _client.get(
      uri,
      headers: {
        if (defaultHeaders != null) ...defaultHeaders!,
        if (headers != null) ...headers,
      },
    );

    try {
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          message: response.body.isEmpty ? 'Unknown error' : response.body,
          uri: uri,
          statusCode: response.statusCode,
          userFriendlyMessage:
              'Something went wrong while fetching data. Please try again later.',
        );
      }

      if (response.body.isEmpty) {
        return const {};
      }

      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {'data': decoded};
    } on FormatException catch (error) {
      throw ApiException(
        message: 'Failed to parse response: ${error.message}',
        uri: uri,
        userFriendlyMessage:
            'Unexpected response from the server. Please try again later.',
      );
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final base = Uri.parse(baseUrl);
    final resolved = base.resolve(path);
    if (queryParameters == null || queryParameters.isEmpty) {
      return resolved;
    }

    final filtered = <String, String>{};
    queryParameters.forEach((key, value) {
      final entryValue = value;
      if (entryValue == null) return;
      filtered[key] = entryValue.toString();
    });

    return resolved.replace(
      queryParameters: {...resolved.queryParameters, ...filtered},
    );
  }

  void close() => _client.close();
}
