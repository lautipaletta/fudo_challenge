import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  Session({required this.authUser});

  final AuthUser authUser;
  // Acá va JWT, etc...

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
