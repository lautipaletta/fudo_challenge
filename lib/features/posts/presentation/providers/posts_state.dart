import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';

part 'posts_state.freezed.dart';

@freezed
abstract class PostsState with _$PostsState {
  const factory PostsState({
    @Default([]) List<Post> posts,
    @Default(null) String? query,
  }) = _PostsState;
}
