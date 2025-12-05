import 'package:fudo_challenge/core/cache/cache/cache_service.dart';
import 'package:fudo_challenge/core/cache/cache_key_generator/cache_key_generator.dart';
import 'package:fudo_challenge/core/cache/network_cache/network_cache_service.dart';

class NetworkCacheServiceImpl implements NetworkCacheService {
  final CacheService cacheService;
  final CacheKeyGenerator cacheKeyGenerator;

  NetworkCacheServiceImpl({
    required this.cacheService,
    required this.cacheKeyGenerator,
  });

  @override
  Future<void> cacheResponse({
    required String url,
    required String method,
    required String response,
    Map<String, dynamic>? queryParams,
    Duration? expiry,
  }) async {
    try {
      final key = cacheKeyGenerator.generateNetworkCacheKey(
        url: url,
        method: method,
        queryParams: queryParams,
      );
      await cacheService.save(key: key, value: response, expiry: expiry);
    } catch (_) {
      return;
    }
  }

  @override
  Future<String?> getCachedResponse({
    required String url,
    required String method,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final key = cacheKeyGenerator.generateNetworkCacheKey(
        url: url,
        method: method,
        queryParams: queryParams,
      );
      return await cacheService.get(key);
    } catch (_) {
      return null;
    }
  }
}
