import 'package:fudo_challenge/features/users/data/model/user_dto.dart';

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromDto(UserDto dto) => User(id: dto.id, name: dto.name);
}
