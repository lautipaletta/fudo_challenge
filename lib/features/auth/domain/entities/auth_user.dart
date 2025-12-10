import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  final int id;
  final String email;

  AuthUser({required this.id, required this.email});

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
