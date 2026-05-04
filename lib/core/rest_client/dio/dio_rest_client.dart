import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../config/env_config.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  DioRestClient({BaseOptions? options}) {
    _dio = Dio(
      options ??
          BaseOptions(
            baseUrl: EnvConfig.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {'Content-Type': 'application/json'},
          ),
    );

    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);
  }

  @override
  RestClient auth() => this;

  @override
  RestClient unauth() => this;

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: 'GET',
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: 'POST',
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: 'PUT',
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: 'PATCH',
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: 'DELETE',
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _request<T>(
    path,
    method: method,
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  Future<RestClientResponse<T>> _request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers),
      );
      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      // Extrai a mensagem de erro do body: {"error": "..."}
      String? apiMessage;
      try {
        final body = e.response?.data;
        if (body is Map) {
          apiMessage = (body['error'] ?? body['message']) as String?;
        }
      } catch (_) {}

      throw RestClientException(
        message: e.response?.statusMessage ?? e.message,
        apiMessage: apiMessage,
        statusCode: e.response?.statusCode,
        error: e.error,
        response: e.response,
      );
    }
  }
}
