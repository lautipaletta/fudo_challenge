import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';

class CheckSessionUseCase {
  final AuthRepository authRepository;

  CheckSessionUseCase({required this.authRepository});

  Future<AuthState> call() async {
    final session = await authRepository.checkSession();
    return session.fold(
      (l) => AuthState.initial(),
      (r) => AuthState(isAuthenticated: r != null, email: r?.email),
    );
  }
}
