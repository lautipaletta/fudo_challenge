import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/get_posts.dart';
import 'package:fudo_challenge/features/posts/presentation/providers/posts_state.dart';

class PostsProvider extends AsyncNotifier<PostsState> {
  GetPostsUseCase get _getPostsUseCase => ref.read(getPostsUseCaseProvider);

  @override
  Future<PostsState> build() async {
    final result = await _getPostsUseCase.call(query: null);
    return result.fold(
      (l) => throw l,
      (r) => PostsState(posts: r, query: null),
    );
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
      (r) => state = AsyncValue.data(PostsState(posts: r, query: query)),
    );
  }

  // Agrego el post al principio de la lista para que se muestre al inicio.
  void addPost(Post post) {
    state = AsyncValue.data(
      PostsState(
        posts: [post, ...state.value?.posts ?? []],
        query: state.value?.query,
      ),
    );
  }
}
