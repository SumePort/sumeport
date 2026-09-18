import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkClient {
  const NetworkClient({
    required this.baseUrl,
  });

  final String baseUrl;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    String? accessToken,
  }) async {
    final response = await http.get(
      _buildUri(endpoint),
      headers: _headers(accessToken),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    final response = await http.post(
      _buildUri(endpoint),
      headers: _headers(accessToken),
      body: body == null ? null : jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    final response = await http.patch(
      _buildUri(endpoint),
      headers: _headers(accessToken),
      body: body == null ? null : jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    final response = await http.put(
      _buildUri(endpoint),
      headers: _headers(accessToken),
      body: body == null ? null : jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? accessToken,
  }) async {
    final response = await http.delete(
      _buildUri(endpoint),
      headers: _headers(accessToken),
    );

    return _handleResponse(response);
  }

  Uri _buildUri(String endpoint) {
    final normalizedBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    final normalizedEndpoint = endpoint.startsWith('/')
        ? endpoint
        : '/$endpoint';

    return Uri.parse('$normalizedBaseUrl$normalizedEndpoint');
  }

  Map<String, String> _headers(String? accessToken) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (accessToken != null && accessToken.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };
  }

  Map<String, dynamic> _handleResponse(
    http.Response response,
  ) {
    final statusCode = response.statusCode;

    dynamic decoded;

    if (response.body.isNotEmpty) {
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = null;
      }
    }

    if (statusCode >= 200 && statusCode < 300) {
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {
        'data': decoded,
      };
    }

    String message = 'Something went wrong.';

    if (decoded is Map<String, dynamic>) {
      final detail = decoded['detail'];

      if (detail is String && detail.isNotEmpty) {
        message = detail;
      }
    }

    throw NetworkException(
      message: message,
      statusCode: statusCode,
    );
  }
}


class NetworkException implements Exception {
  const NetworkException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  String toString() {
    return 'NetworkException($statusCode): $message';
  }
}