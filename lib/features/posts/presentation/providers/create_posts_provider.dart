import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/di/providers.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/create_post.dart';

class CreatePostsProvider extends AsyncNotifier<void> {
  CreatePostUseCase get _createPostUseCase =>
      ref.read(createPostUseCaseProvider);

  @override
  Future<void> build() async {
    return;
  }

  void _setLoading() {
    if (state.isLoading) {
      state = AsyncValue.data(null);
      return;
    }
    state = const AsyncValue.loading();
  }

  Future<Either<FudoException, Post>> createPost({
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
    _setLoading();
    if (result.isRight) {
      ref.read(postsProvider.notifier).addPost(result.right);
    }
    return result;
  }
}
