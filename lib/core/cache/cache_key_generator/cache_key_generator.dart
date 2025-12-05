abstract class CacheKeyGenerator {
  String generateNetworkCacheKey({
    required String url,
    required String method,
    Map<String, dynamic>? queryParams,
  });
}
