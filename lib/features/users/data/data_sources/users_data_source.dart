import 'package:fudo_challenge/features/users/data/model/user_dto.dart';

abstract class UsersDataSource {
  Future<List<UserDto>> getUsers({String? name});
}
