import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/common/models/session.dart';

abstract class AuthRepository {
  Future<Either<FudoException, void>> login(String email, String password);
  Future<Either<FudoException, Session?>> checkSession();
  Future<void> logout();
}
