import 'dart:convert';

import 'package:fudo_challenge/core/cache/cache/cache_service.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:fudo_challenge/core/common/models/session.dart';

class HiveLocalAuthDataSource implements LocalAuthDataSource {
  HiveLocalAuthDataSource({required this.cacheService});

  final CacheService cacheService;

  @override
  Future<Session?> getSession() async {
    try {
      final session = await cacheService.get('session');
      return session != null ? Session.fromJson(jsonDecode(session)) : null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveSession({required Session session}) async {
    try {
      await cacheService.save(
        key: 'session',
        value: jsonEncode(session.toJson()),
      );
    } catch (_) {
      return;
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await cacheService.delete('session');
    } catch (_) {
      return;
    }
  }
}
