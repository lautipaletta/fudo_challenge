import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/cache/cache/cache_service.dart';
import 'package:fudo_challenge/core/cache/cache/cache_service_impl.dart';
import 'package:fudo_challenge/core/cache/cache_key_generator/cache_key_generator.dart';
import 'package:fudo_challenge/core/cache/cache_key_generator/simple_cache_key_generator.dart';
import 'package:fudo_challenge/core/cache/network_cache/network_cache_service.dart';
import 'package:fudo_challenge/core/cache/network_cache/network_cache_service_impl.dart';

// Cache providers
final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheServiceImpl(boxName: 'cache_box');
});

final cacheKeyGeneratorProvider = Provider<CacheKeyGenerator>((ref) {
  return SimpleCacheKeyGenerator();
});

final networkCacheServiceProvider = Provider<NetworkCacheService>((ref) {
  return NetworkCacheServiceImpl(
    cacheService: ref.read(cacheServiceProvider),
    cacheKeyGenerator: ref.read(cacheKeyGeneratorProvider),
  );
});
