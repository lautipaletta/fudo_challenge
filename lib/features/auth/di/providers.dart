import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/remote/remote_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/sign_in.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_provider.dart';

final authDataSourceProvider = Provider<AuthDataSource>((_) {
  return RemoteAuthDataSource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(authDataSource: ref.read(authDataSourceProvider));
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(authRepository: ref.read(authRepositoryProvider));
});

final authProvider = AsyncNotifierProvider<AuthProvider, AuthState>(() {
  return AuthProvider();
});
