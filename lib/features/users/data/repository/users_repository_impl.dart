import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/users/data/data_sources/users_data_source.dart';
import 'package:fudo_challenge/features/users/domain/entities/user.dart';
import 'package:fudo_challenge/features/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource usersDataSource;

  UsersRepositoryImpl({required this.usersDataSource});

  @override
  Future<Either<FudoException, List<User>>> getUsers({String? name}) async {
    try {
      final dtos = await usersDataSource.getUsers(name: name);
      final users = dtos.map((dto) => User.fromDto(dto)).toList();
      return Right(users);
    } catch (e) {
      return Left(FudoException(message: 'Failed to get users'));
    }
  }
}
