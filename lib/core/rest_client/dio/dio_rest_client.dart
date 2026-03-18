import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../config/env_config.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;
  final _options = BaseOptions(
    baseUrl: EnvConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  DioRestClient({
    BaseOptions? options,
  }) {
    _dio = Dio(options ?? _options);
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
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
  RestClient auth() {
    _options.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _options.extra['auth_required'] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: 'DELETE',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: 'PATCH',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) {
    return _request<T>(
      path,
      method: method,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<RestClientResponse<T>> _request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
        ),
      );

      return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      throw RestClientException(
        message: e.response?.statusMessage ?? e.message,
        statusCode: e.response?.statusCode,
        error: e.error,
        response: e.response,
      );
    }
  }
}
