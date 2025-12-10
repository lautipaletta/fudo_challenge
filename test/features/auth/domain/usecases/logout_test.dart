import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/features/auth/domain/repository/auth_repository.dart';
import 'package:fudo_challenge/features/auth/domain/usecases/logout.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LogoutUseCase(authRepository: mockRepository);
  });

  group('LogoutUseCase', () {
    test('should call repository logout method', () async {
      // Arrange
      when(mockRepository.logout()).thenAnswer((_) async => {});

      // Act
      await useCase.call();

      // Assert
      verify(mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should complete successfully when logout succeeds', () async {
      // Arrange
      when(mockRepository.logout()).thenAnswer((_) async => {});

      // Act
      await useCase.call();

      // Assert
      verify(mockRepository.logout()).called(1);
    });
  });
}
