import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/di/providers.dart';
import 'package:fudo_challenge/core/network/network_cache_interceptor.dart';
import 'package:fudo_challenge/config/network/network_config.dart';

final apiDioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = String.fromEnvironment('API_BASE_URL');
  dio.interceptors.add(
    NetworkCacheInterceptor(
      networkCacheService: ref.read(networkCacheServiceProvider),
    ),
  );
  dio.options.connectTimeout = NetworkConfig.connectTimeout;
  dio.options.receiveTimeout = NetworkConfig.receiveTimeout;
  dio.options.sendTimeout = NetworkConfig.sendTimeout;
  return dio;
});
