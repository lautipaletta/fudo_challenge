import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  Session({required this.email});

  final String email;

  factory Session.fromJson(Map<String, dynamic> json) =>
      Session(email: json['email']);

  Map<String, dynamic> toJson() => {'email': email};
}
