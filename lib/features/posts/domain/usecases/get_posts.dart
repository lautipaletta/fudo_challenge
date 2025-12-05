import 'package:either_dart/either.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';
import 'package:fudo_challenge/features/users/domain/repository/users_repository.dart';

class GetPostsUseCase {
  final PostsRepository postsRepository;
  final UsersRepository usersRepository;

  GetPostsUseCase({
    required this.postsRepository,
    required this.usersRepository,
  });

  Future<Either<FudoException, List<Post>>> call({String? query}) async {
    int? userId;

    if (query != null && query.isNotEmpty) {
      final users = await usersRepository.getUsers(name: query);
      if (users.isLeft) {
        return Left(users.left);
      }
      userId = users.right.firstOrNull?.id;
      if (userId == null) {
        return const Right([]);
      }
    }

    return postsRepository.getPosts(userId: userId);
  }
}
