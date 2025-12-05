import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/exceptions/network_exceptions.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/model/auth_request_dto.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<FudoException, void>> login(
    String email,
    String password,
  ) async {
    try {
      final dto = AuthRequestDto(email: email, password: password);
      await authDataSource.login(dto);
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
}
