import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_dto.g.dart';

@JsonSerializable()
class AuthUserDto {
  final int id;
  final String email;

  AuthUserDto({required this.id, required this.email});

  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserDtoToJson(this);

  AuthUser toEntity() => AuthUser(id: id, email: email);

  factory AuthUserDto.fromEntity(AuthUser entity) =>
      AuthUserDto(id: entity.id, email: entity.email);
}
