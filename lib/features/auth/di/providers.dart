import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/cache/cache/cache_service.dart';
import 'package:fudo_challenge/core/cache/cache/cache_service_impl.dart';
import 'package:fudo_challenge/core/di/providers.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/local/hive_local_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/data_sources/remote/remote_auth_data_source.dart';
import 'package:fudo_challenge/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/check_session.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/logout.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/sign_in.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_provider.dart';

final authDataSourceProvider = Provider<AuthDataSource>((_) {
  return RemoteAuthDataSource();
});

final authCacheServiceProvider = Provider<CacheService>((ref) {
  return CacheServiceImpl(boxName: 'auth_box');
});

final localAuthDataSourceProvider = Provider<LocalAuthDataSource>((ref) {
  return HiveLocalAuthDataSource(
    cacheService: ref.read(authCacheServiceProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteAuthDataSource: ref.read(authDataSourceProvider),
    localAuthDataSource: ref.read(localAuthDataSourceProvider),
  );
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(authRepository: ref.read(authRepositoryProvider));
});

final checkSessionUseCaseProvider = Provider<CheckSessionUseCase>((ref) {
  return CheckSessionUseCase(authRepository: ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(authRepository: ref.read(authRepositoryProvider));
});

final authProvider = AsyncNotifierProvider<AuthProvider, AuthState>(() {
  return AuthProvider();
});
