import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_dto.g.dart';

@JsonSerializable()
class CreatePostDto {
  CreatePostDto({
    required this.title,
    required this.body,
    required this.userId,
  });

  final String title;
  final String body;
  final int userId;

  factory CreatePostDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostDtoToJson(this);
}
