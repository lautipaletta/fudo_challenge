import 'package:json_annotation/json_annotation.dart';

part 'auth_request_dto.g.dart';

@JsonSerializable()
class AuthRequestDto {
  final String email;
  final String password;

  AuthRequestDto({required this.email, required this.password});

  factory AuthRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestDtoToJson(this);
}
