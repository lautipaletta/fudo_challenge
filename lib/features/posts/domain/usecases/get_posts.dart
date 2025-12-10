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

  // Obtengo los users por cada búsqueda pensando en una situación real con miles de usuarios que no se
  // pueden guardar en memoria. Se cuenta con un Debouncer para evitar hacer llamadas demasiado frecuentes.
  // El servicio de backend en tal caso podría implementar una cache de su lado según su lógica de negocio.
  // Como adicional, el CacheService también podría ser utilizado para cachear los usuarios si así se desea.
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
