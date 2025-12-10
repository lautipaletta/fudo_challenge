import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/common/models/session.dart';
import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<Either<FudoException, AuthUser>> login(String email, String password);
  Future<Either<FudoException, Session?>> checkSession();
  Future<void> logout();
}
