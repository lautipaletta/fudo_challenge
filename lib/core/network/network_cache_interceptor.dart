import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fudo_challenge/core/cache/network_cache/network_cache_service.dart';

class NetworkCacheInterceptor extends Interceptor {
  final NetworkCacheService networkCacheService;

  NetworkCacheInterceptor({required this.networkCacheService});

  bool _shouldCache(String method, int? statusCode) {
    return method == 'GET' &&
        statusCode != null &&
        statusCode >= 200 &&
        statusCode < 300;
  }

  bool _shouldTryCache(DioException err) {
    if (err.requestOptions.method != 'GET') return false;

    return [
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.connectionError,
    ].contains(err.type);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final method = response.requestOptions.method;
    final statusCode = response.statusCode;
    if (_shouldCache(method, statusCode)) {
      final url =
          '${response.requestOptions.baseUrl}${response.requestOptions.path}';
      final params = response.requestOptions.queryParameters;
      await networkCacheService.cacheResponse(
        url: url,
        method: method,
        queryParams: params,
        response: jsonEncode(response.data),
        expiry: Duration(minutes: 30),
      );
    }

    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldTryCache(err)) {
      final url = '${err.requestOptions.baseUrl}${err.requestOptions.path}';
      final method = err.requestOptions.method;
      final params = err.requestOptions.queryParameters;

      final cachedResponse = await networkCacheService.getCachedResponse(
        url: url,
        method: method,
        queryParams: params,
      );

      if (cachedResponse != null) {
        return handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            data: jsonDecode(cachedResponse),
            statusCode: 200,
            statusMessage: 'OK',
          ),
        );
      }
    }

    return super.onError(err, handler);
  }
}
