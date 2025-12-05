import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  Future<void> call() async {
    await authRepository.logout();
  }
}
