import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/core/common/models/session.dart';
import 'package:fudo_challenge/core/exceptions/fudo_exception.dart';
import 'package:fudo_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/check_session.dart';
import 'package:fudo_challenge/features/auth/presentation/providers/auth_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_session_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late CheckSessionUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CheckSessionUseCase(authRepository: mockRepository);
  });

  setUpAll(() {
    // Provide dummy values for Either types
    provideDummy<Either<FudoException, Session?>>(const Right(null));
  });

  group('CheckSessionUseCase', () {
    final authUser = AuthUser(id: 1, email: 'test@example.com');
    final session = Session(authUser: authUser);

    test('should return authenticated state when session exists', () async {
      // Arrange
      when(mockRepository.checkSession())
          .thenAnswer((_) async => Right(session));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isAuthenticated, true);
      expect(result.authUser, authUser);
      verify(mockRepository.checkSession()).called(1);
    });

    test('should return unauthenticated state when session is null', () async {
      // Arrange
      when(mockRepository.checkSession())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result.isAuthenticated, false);
      expect(result.authUser, null);
      verify(mockRepository.checkSession()).called(1);
    });

    test('should return initial state when checkSession fails', () async {
      // Arrange
      final exception = FudoException(message: 'Error');
      when(mockRepository.checkSession())
          .thenAnswer((_) async => Left(exception));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, AuthState.initial());
      expect(result.isAuthenticated, false);
      expect(result.authUser, null);
      verify(mockRepository.checkSession()).called(1);
    });
  });
}

