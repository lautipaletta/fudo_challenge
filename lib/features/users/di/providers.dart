import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/network/api_dio_provider.dart';
import 'package:fudo_challenge/features/users/data/data_sources/remote/remote_users_data_source.dart';
import 'package:fudo_challenge/features/users/data/data_sources/users_data_source.dart';
import 'package:fudo_challenge/features/users/data/repository/users_repository_impl.dart';
import 'package:fudo_challenge/features/users/domain/repository/users_repository.dart';

final usersDataSourceProvider = Provider<UsersDataSource>((ref) {
  return RemoteUsersDataSource(ref.read(apiDioProvider));
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepositoryImpl(
    usersDataSource: ref.read(usersDataSourceProvider),
  );
});
