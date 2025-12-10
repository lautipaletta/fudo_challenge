import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/exceptions/network_exceptions.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';
import 'package:fudo_challenge/core/common/models/session.dart';
import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteAuthDataSource;
  final LocalAuthDataSource localAuthDataSource;

  AuthRepositoryImpl({
    required this.remoteAuthDataSource,
    required this.localAuthDataSource,
  });

  @override
  Future<Either<FudoException, AuthUser>> login(
    String email,
    String password,
  ) async {
    try {
      final dto = AuthRequestDto(email: email, password: password);
      // Debería devolver un objeto más completo con JWT, etc... pero por el alcance del challenge, lo dejo así.
      final userDto = await remoteAuthDataSource.login(dto);
      final authUser = userDto.toEntity();
      await localAuthDataSource.saveSession(
        session: Session(authUser: authUser),
      );
      return Right(authUser);
    } on BadRequestException catch (e) {
      return Left(e);
    } catch (_) {
      return Left(
        FudoException(
          message:
              'We are having troubles logging you in, please try again later.',
        ),
      );
    }
  }

  @override
  Future<Either<FudoException, Session?>> checkSession() async {
    try {
      final session = await localAuthDataSource.getSession();
      return Right(session);
    } catch (_) {
      return Left(FudoException(message: 'Failed to check session'));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localAuthDataSource.clearSession();
    } catch (_) {
      return;
    }
  }
}
