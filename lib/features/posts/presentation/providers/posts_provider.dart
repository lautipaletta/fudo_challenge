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
    final result = await _getPostsUseCase.call(query: null);
    return result.fold((l) => throw l, (r) => r);
  }

  void _setLoading() {
    if (!state.hasValue) {
      state = const AsyncValue.loading();
    }
  }

  Future<void> getPosts({String? query}) async {
    _setLoading();
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
    _setLoading();
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
