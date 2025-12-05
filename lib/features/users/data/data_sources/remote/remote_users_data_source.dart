import 'package:dio/dio.dart';
import 'package:fudo_challenge/features/users/data/data_sources/users_data_source.dart';
import 'package:fudo_challenge/features/users/data/model/user_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_users_data_source.g.dart';

@RestApi()
abstract class RemoteUsersDataSource implements UsersDataSource {
  factory RemoteUsersDataSource(Dio dio) => _RemoteUsersDataSource(dio);

  @GET('/users')
  @override
  Future<List<UserDto>> getUsers({@Query('name') String? name});
}
