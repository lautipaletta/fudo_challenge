import 'dart:convert';

import 'package:fudo_challenge/core/cache/cache/cache_service.dart';
import 'package:hive/hive.dart';

class CacheServiceImpl implements CacheService {
  Future<Box<String>> _openBox() async => await Hive.openBox('cache_box');

  @override
  Future<void> save({
    required String key,
    required String value,
    Duration? expiry,
  }) async {
    final box = await _openBox();
    final data = jsonEncode({
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiryMs': expiry?.inMilliseconds,
    });
    await box.put(key, data);
  }

  @override
  Future<String?> get(String key) async {
    final box = await _openBox();
    final cached = box.get(key);
    if (cached == null) return null;

    final data = jsonDecode(cached);
    final expiryMs = data['expiryMs'] as int?;
    if (expiryMs != null) {
      final timestamp = data['timestamp'] as int;
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        timestamp + expiryMs,
      );
      if (DateTime.now().isAfter(expiresAt)) {
        await delete(key);
        return null;
      }
    }

    return data['value'] as String;
  }

  @override
  Future<void> delete(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  @override
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
