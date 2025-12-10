import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/core/common/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('should execute callback after duration', () async {
      // Arrange
      var executed = false;
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));

      // Act
      debouncer.run(() {
        executed = true;
      });

      // Assert
      expect(executed, false);
      await Future.delayed(const Duration(milliseconds: 150));
      expect(executed, true);
    });

    test('should cancel previous callback when run is called again', () async {
      // Arrange
      var firstExecuted = false;
      var secondExecuted = false;
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));

      // Act
      debouncer.run(() {
        firstExecuted = true;
      });

      await Future.delayed(const Duration(milliseconds: 50));

      debouncer.run(() {
        secondExecuted = true;
      });

      await Future.delayed(const Duration(milliseconds: 150));

      // Assert
      expect(firstExecuted, false);
      expect(secondExecuted, true);
    });

    test('should cancel callback when dispose is called', () async {
      // Arrange
      var executed = false;
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));

      // Act
      debouncer.run(() {
        executed = true;
      });

      debouncer.dispose();

      await Future.delayed(const Duration(milliseconds: 150));

      // Assert
      expect(executed, false);
    });

    test(
      'should handle multiple rapid calls and only execute last one',
      () async {
        // Arrange
        var executionCount = 0;
        final debouncer = Debouncer(
          duration: const Duration(milliseconds: 100),
        );

        // Act
        for (var i = 0; i < 5; i++) {
          debouncer.run(() {
            executionCount++;
          });
          await Future.delayed(const Duration(milliseconds: 20));
        }

        await Future.delayed(const Duration(milliseconds: 150));

        // Assert
        expect(executionCount, 1);
      },
    );
  });
}

