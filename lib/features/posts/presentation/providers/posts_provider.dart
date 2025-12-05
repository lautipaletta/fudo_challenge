import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/create_post.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/get_posts.dart';

class PostsProvider extends AsyncNotifier<List<Post>> {
  GetPostsUseCase get _getPostsUseCase => ref.read(getPostsUseCaseProvider);
  CreatePostUseCase get _createPostUseCase =>
      ref.read(createPostUseCaseProvider);

  @override
  Future<List<Post>> build() async {
    getPosts();
    return [];
  }

  Future<void> getPosts({String? query}) async {
    state = const AsyncValue.loading();
    final result = await _getPostsUseCase.call(query: query);
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }

  Future<void> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    state = const AsyncValue.loading();
    final result = await _createPostUseCase.call(
      title: title,
      body: body,
      userId: userId,
    );
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data([...state.value ?? [], r]),
    );
  }
}
