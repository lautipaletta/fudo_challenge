import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/check_session.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/logout.dart';

import 'package:fudo_challenge/features/auth/domain/usecases/sign_in.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';

class AuthProvider extends AsyncNotifier<AuthState> {
  SignInUseCase get _signInUseCase => ref.read(signInUseCaseProvider);
  CheckSessionUseCase get _checkSessionUseCase =>
      ref.read(checkSessionUseCaseProvider);
  LogoutUseCase get _logoutUseCase => ref.read(logoutUseCaseProvider);

  @override
  Future<AuthState> build() async {
    final authState = await _checkSessionUseCase.call();
    return authState;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _signInUseCase.call(email: email, password: password);
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(
        AuthState(isAuthenticated: true, email: email),
      ),
    );
  }

  Future<void> logout() async {
    await _logoutUseCase.call();
    state = AsyncValue.data(AuthState.initial());
  }
}
