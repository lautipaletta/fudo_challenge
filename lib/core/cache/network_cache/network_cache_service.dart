abstract class NetworkCacheService {
  Future<void> cacheResponse({
    required String url,
    required String method,
    required String response,
    Map<String, dynamic>? queryParams,
    Duration? expiry,
  });

  Future<String?> getCachedResponse({
    required String url,
    required String method,
    Map<String, dynamic>? queryParams,
  });
}
