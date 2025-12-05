import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/users/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<FudoException, List<User>>> getUsers({String? name});
}
