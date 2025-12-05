import 'package:fudo_challenge/features/posts/data/model/post_dto.dart';

class Post {
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int id;
  final String title;
  final String body;
  final int userId;

  factory Post.fromDto(PostDto dto) =>
      Post(id: dto.id, title: dto.title, body: dto.body, userId: dto.userId);
}
