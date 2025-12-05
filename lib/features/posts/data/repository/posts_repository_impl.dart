import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/data/data_sources/posts_data_source.dart';
import 'package:fudo_challenge/features/posts/data/model/create_post_dto.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepositoryImpl({required this.postsDataSource});

  @override
  Future<Either<FudoException, List<Post>>> getPosts({int? userId}) async {
    try {
      final dtos = await postsDataSource.getPosts(userId: userId);
      final posts = dtos.map((dto) => Post.fromDto(dto)).toList();
      return Right(posts);
    } catch (e) {
      return Left(FudoException(message: 'Failed to get posts'));
    }
  }

  @override
  Future<Either<FudoException, Post>> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final dto = CreatePostDto(title: title, body: body, userId: userId);
      final created = await postsDataSource.createPost(dto: dto);
      final post = Post.fromDto(created);
      return Right(post);
    } catch (e) {
      return Left(FudoException(message: 'Failed to create post'));
    }
  }
}
