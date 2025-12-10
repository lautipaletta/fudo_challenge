import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/auth/di/providers.dart';
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
  }) async {
    _setLoading();
    final result = await _createPostUseCase.call(
      title: title,
      body: body,
      userId: ref.read(authProvider).value?.authUser?.id ?? 0,
    );
    _setLoading();
    if (result.isRight) {
      final controller = ref.read(postsProvider.notifier);
      await controller.getPosts();
      controller.addPost(result.right);
    }
    return result;
  }
}
