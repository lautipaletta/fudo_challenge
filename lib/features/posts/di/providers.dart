import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/network/api_dio_provider.dart';
import 'package:fudo_challenge/features/posts/data/data_sources/posts_data_source.dart';
import 'package:fudo_challenge/features/posts/data/data_sources/remote/remote_posts_data_source.dart';
import 'package:fudo_challenge/features/posts/data/repository/posts_repository_impl.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/get_posts.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/create_post.dart';
import 'package:fudo_challenge/features/posts/presentation/providers/posts_provider.dart';
import 'package:fudo_challenge/features/users/di/providers.dart';

final postsDataSourceProvider = Provider<PostsDataSource>((ref) {
  return RemotePostsDataSource(ref.read(apiDioProvider));
});

final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  return PostsRepositoryImpl(
    postsDataSource: ref.read(postsDataSourceProvider),
  );
});

final getPostsUseCaseProvider = Provider<GetPostsUseCase>((ref) {
  return GetPostsUseCase(
    postsRepository: ref.read(postsRepositoryProvider),
    usersRepository: ref.read(usersRepositoryProvider),
  );
});

final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  return CreatePostUseCase(postsRepository: ref.read(postsRepositoryProvider));
});

final postsProvider = AsyncNotifierProvider<PostsProvider, List<Post>>(() {
  return PostsProvider();
});
