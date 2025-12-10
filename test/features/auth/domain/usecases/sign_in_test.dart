import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/core/exceptions/network_exceptions.dart';
import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInUseCase(authRepository: mockRepository);
  });

  setUpAll(() {
    // Provide dummy values for Either types
    provideDummy<Either<FudoException, AuthUser>>(
      Right(AuthUser(id: 0, email: '')),
    );
  });

  group('SignInUseCase', () {
    const emailCorrect = 'challenge@fudo';
    const emailIncorrect = 'test@example.com';
    const password = 'password';
    final authUser = AuthUser(id: 1, email: emailCorrect);

    test('should return AuthUser when login is successful', () async {
      // Arrange
      when(
        mockRepository.login(emailCorrect, password),
      ).thenAnswer((_) async => Right(authUser));

      // Act
      final result = await useCase.call(
        email: emailCorrect,
        password: password,
      );

      // Assert
      expect(result.isRight, true);
      expect(result.right, authUser);
      verify(mockRepository.login(emailCorrect, password)).called(1);
    });

    test('should return FudoException when login fails', () async {
      // Arrange
      final exception = UnauthorizedException(message: 'Invalid credentials');
      when(
        mockRepository.login(emailIncorrect, password),
      ).thenAnswer((_) async => Left(exception));

      // Act
      final result = await useCase.call(
        email: emailIncorrect,
        password: password,
      );

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockRepository.login(emailIncorrect, password)).called(1);
    });

    test('should call repository with correct parameters', () async {
      // Arrange
      when(
        mockRepository.login(any, any),
      ).thenAnswer((_) async => Right(authUser));

      // Act
      await useCase.call(email: emailCorrect, password: password);

      // Assert
      verify(mockRepository.login(emailCorrect, password)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

