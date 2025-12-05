import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/di/providers.dart';
import 'package:fudo_challenge/core/network/network_cache_interceptor.dart';
import 'package:fudo_challenge/config/network/network_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiDioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final baseUrl = const String.fromEnvironment('BASE_URL');
  dio.options.baseUrl = baseUrl;
  dio.interceptors.add(
    NetworkCacheInterceptor(
      networkCacheService: ref.read(networkCacheServiceProvider),
    ),
  );
  dio.interceptors.add(
    PrettyDioLogger(
      request: true,
      requestBody: true,
      responseBody: false,
      enabled: kDebugMode,
    ),
  );
  dio.options.connectTimeout = NetworkConfig.connectTimeout;
  dio.options.receiveTimeout = NetworkConfig.receiveTimeout;
  dio.options.sendTimeout = NetworkConfig.sendTimeout;
  return dio;
});
