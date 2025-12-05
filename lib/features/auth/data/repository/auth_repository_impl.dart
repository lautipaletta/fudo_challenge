import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/exceptions/network_exceptions.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';
import 'package:fudo_challenge/core/common/models/session.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteAuthDataSource;
  final LocalAuthDataSource localAuthDataSource;

  AuthRepositoryImpl({
    required this.remoteAuthDataSource,
    required this.localAuthDataSource,
  });

  @override
  Future<Either<FudoException, void>> login(
    String email,
    String password,
  ) async {
    try {
      final dto = AuthRequestDto(email: email, password: password);
      await remoteAuthDataSource.login(dto);
      await localAuthDataSource.saveSession(session: Session(email: email));
      return const Right(null);
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
