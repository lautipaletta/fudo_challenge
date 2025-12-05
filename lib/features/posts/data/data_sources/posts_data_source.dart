import 'package:fudo_challenge/features/posts/data/model/create_post_dto.dart';
import 'package:fudo_challenge/features/posts/data/model/post_dto.dart';

abstract class PostsDataSource {
  Future<List<PostDto>> getPosts({int? userId});

  Future<PostDto> createPost({required CreatePostDto dto});
}
