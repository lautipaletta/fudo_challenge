import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';

class CreatePostUseCase {
  final PostsRepository postsRepository;

  CreatePostUseCase({required this.postsRepository});

  Future<Either<FudoException, Post>> call({
    required String title,
    required String body,
    required int userId,
  }) async {
    return postsRepository.createPost(title: title, body: body, userId: userId);
  }
}
