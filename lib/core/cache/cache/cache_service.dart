abstract class CacheService {
  Future<void> save({
    required String key,
    required String value,
    Duration? expiry,
  });

  Future<String?> get(String key);

  Future<void> clear();

  Future<void> delete(String key);
}
