import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';

abstract class AuthRepository {
  Future<Either<FudoException, void>> login(String email, String password);
}
