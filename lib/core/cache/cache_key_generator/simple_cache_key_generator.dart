import 'package:fudo_challenge/core/cache/cache_key_generator/cache_key_generator.dart';

class SimpleCacheKeyGenerator implements CacheKeyGenerator {
  @override
  String generateNetworkCacheKey({
    required String url,
    required String method,
    Map<String, dynamic>? queryParams,
  }) {
    final params = queryParams?.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    final rawKey = '$method:$url?$params';
    return rawKey;
  }
}
