import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';

import 'package:fudo_challenge/features/auth/domain/usecases/sign_in.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';

class AuthProvider extends AsyncNotifier<AuthState> {
  SignInUseCase get _signInUseCase => ref.read(signInUseCaseProvider);

  @override
  Future<AuthState> build() async {
    return AuthState.initial();
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
}
