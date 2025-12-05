import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<FudoException, List<Post>>> getPosts({int? userId});

  Future<Either<FudoException, Post>> createPost({
    required String title,
    required String body,
    required int userId,
  });
}
