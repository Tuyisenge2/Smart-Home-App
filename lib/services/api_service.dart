import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final String token;
  ApiService({required this.baseUrl, required this.token});
  // Common headers
  Map<String, String> get _headers => {
    HttpHeaders.authorizationHeader: "Bearer $token",
    HttpHeaders.contentTypeHeader: "application/json",
  };
  // Helper method to handle response
  T _handleResponse<T>({
    required http.Response response,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    // print('API Request: ${response.request?.method} ${response.request?.url}');
    // print('Status Code: ${response.statusCode}');
    // print('Statusyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (T == dynamic || response.body.isEmpty) {
        return null as T; // For empty responses or when T is dynamic
      }
      return fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(
        'Request failed with status: ${response.statusCode}',
        uri: response.request?.url,
      );
    }
  }

  // GET Request
  Future<T> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? queryParameters,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/$endpoint',
      ).replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {..._headers, ...?additionalHeaders},
      );

      return _handleResponse(response: response, fromJson: fromJson);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  // POST Request
  Future<T> post<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {..._headers, ...?additionalHeaders},
        body: jsonEncode(body),
      );

      return _handleResponse(response: response, fromJson: fromJson);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  // PUT Request
  Future<T> put<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {..._headers, ...?additionalHeaders},
        body: jsonEncode(body),
      );

      return _handleResponse(response: response, fromJson: fromJson);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  // DELETE Request
  Future<T> delete<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {..._headers, ...?additionalHeaders},
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response: response, fromJson: fromJson);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // PATCH Request
  Future<T> patch<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {..._headers, ...?additionalHeaders},
        body: jsonEncode(body),
      );

      return _handleResponse(response: response, fromJson: fromJson);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('PATCH request failed: $e');
    }
  }
}
