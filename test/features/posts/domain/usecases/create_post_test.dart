import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/create_post.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_post_test.mocks.dart';

@GenerateMocks([PostsRepository])
void main() {
  late CreatePostUseCase useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = CreatePostUseCase(postsRepository: mockRepository);
  });

  setUpAll(() {
    // Provide dummy values for Either types
    provideDummy<Either<FudoException, Post>>(
      Right(Post(id: 0, title: '', body: '', userId: 0)),
    );
  });

  group('CreatePostUseCase', () {
    const title = 'Test Post';
    const body = 'Test Body';
    const userId = 1;
    final post = Post(id: 1, title: title, body: body, userId: userId);

    test('should return Post when creation is successful', () async {
      // Arrange
      when(mockRepository.createPost(
        title: title,
        body: body,
        userId: userId,
      )).thenAnswer((_) async => Right(post));

      // Act
      final result = await useCase.call(
        title: title,
        body: body,
        userId: userId,
      );

      // Assert
      expect(result.isRight, true);
      expect(result.right, post);
      verify(mockRepository.createPost(
        title: title,
        body: body,
        userId: userId,
      )).called(1);
    });

    test('should return FudoException when creation fails', () async {
      // Arrange
      final exception = FudoException(message: 'Creation failed');
      when(mockRepository.createPost(
        title: title,
        body: body,
        userId: userId,
      )).thenAnswer((_) async => Left(exception));

      // Act
      final result = await useCase.call(
        title: title,
        body: body,
        userId: userId,
      );

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockRepository.createPost(
        title: title,
        body: body,
        userId: userId,
      )).called(1);
    });

    test('should call repository with correct parameters', () async {
      // Arrange
      when(mockRepository.createPost(
        title: anyNamed('title'),
        body: anyNamed('body'),
        userId: anyNamed('userId'),
      )).thenAnswer((_) async => Right(post));

      // Act
      await useCase.call(title: title, body: body, userId: userId);

      // Assert
      verify(mockRepository.createPost(
        title: title,
        body: body,
        userId: userId,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

