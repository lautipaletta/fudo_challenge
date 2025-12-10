import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/posts/domain/entities/post.dart';
import 'package:fudo_challenge/features/posts/domain/repository/posts_repository.dart';
import 'package:fudo_challenge/features/posts/domain/usecases/get_posts.dart';
import 'package:fudo_challenge/features/users/domain/entities/user.dart';
import 'package:fudo_challenge/features/users/domain/repository/users_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_posts_test.mocks.dart';

@GenerateMocks([PostsRepository, UsersRepository])
void main() {
  late GetPostsUseCase useCase;
  late MockPostsRepository mockPostsRepository;
  late MockUsersRepository mockUsersRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    mockUsersRepository = MockUsersRepository();
    useCase = GetPostsUseCase(
      postsRepository: mockPostsRepository,
      usersRepository: mockUsersRepository,
    );
  });

  setUpAll(() {
    // Provide dummy values for Either types
    provideDummy<Either<FudoException, List<Post>>>(const Right([]));
    provideDummy<Either<FudoException, List<User>>>(const Right([]));
  });

  group('GetPostsUseCase', () {
    final posts = [
      Post(id: 1, title: 'Post 1', body: 'Body 1', userId: 1),
      Post(id: 2, title: 'Post 2', body: 'Body 2', userId: 1),
    ];

    test('should return all posts when query is null', () async {
      // Arrange
      when(mockPostsRepository.getPosts(userId: null))
          .thenAnswer((_) async => Right(posts));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isRight, true);
      expect(result.right, posts);
      verify(mockPostsRepository.getPosts(userId: null)).called(1);
      verifyNever(mockUsersRepository.getUsers(name: anyNamed('name')));
    });

    test('should return all posts when query is empty', () async {
      // Arrange
      when(mockPostsRepository.getPosts(userId: null))
          .thenAnswer((_) async => Right(posts));

      // Act
      final result = await useCase.call(query: '');

      // Assert
      expect(result.isRight, true);
      expect(result.right, posts);
      verify(mockPostsRepository.getPosts(userId: null)).called(1);
      verifyNever(mockUsersRepository.getUsers(name: anyNamed('name')));
    });

    test('should return filtered posts when user is found', () async {
      // Arrange
      const query = 'John';
      final users = [User(id: 1, name: 'John Doe')];
      final filteredPosts = [posts[0]];

      when(mockUsersRepository.getUsers(name: query))
          .thenAnswer((_) async => Right(users));
      when(mockPostsRepository.getPosts(userId: 1))
          .thenAnswer((_) async => Right(filteredPosts));

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(result.isRight, true);
      expect(result.right, filteredPosts);
      verify(mockUsersRepository.getUsers(name: query)).called(1);
      verify(mockPostsRepository.getPosts(userId: 1)).called(1);
    });

    test('should return empty list when user is not found', () async {
      // Arrange
      const query = 'NonExistent';
      when(mockUsersRepository.getUsers(name: query))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(result.isRight, true);
      expect(result.right, isEmpty);
      verify(mockUsersRepository.getUsers(name: query)).called(1);
      verifyNever(mockPostsRepository.getPosts(userId: anyNamed('userId')));
    });

    test('should return error when users repository fails', () async {
      // Arrange
      const query = 'John';
      final exception = FudoException(message: 'Network error');
      when(mockUsersRepository.getUsers(name: query))
          .thenAnswer((_) async => Left(exception));

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockUsersRepository.getUsers(name: query)).called(1);
      verifyNever(mockPostsRepository.getPosts(userId: anyNamed('userId')));
    });

    test('should return error when posts repository fails', () async {
      // Arrange
      final exception = FudoException(message: 'Network error');
      when(mockPostsRepository.getPosts(userId: null))
          .thenAnswer((_) async => Left(exception));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockPostsRepository.getPosts(userId: null)).called(1);
    });
  });
}

