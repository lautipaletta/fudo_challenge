import 'package:fudo_challenge/core/common/models/session.dart';

abstract class LocalAuthDataSource {
  Future<Session?> getSession();
  Future<void> saveSession({required Session session});
  Future<void> clearSession();
}
