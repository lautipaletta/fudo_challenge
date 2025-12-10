import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<Either<FudoException, AuthUser>> call({
    required String email,
    required String password,
  }) async {
    return authRepository.login(email, password);
  }
}
