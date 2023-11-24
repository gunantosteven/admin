import 'package:admin/features/auth/application/auth_controller.dart';
import 'package:admin/features/auth/domain/providers/auth_provider.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data.dart';
import '../../../mocks.dart';

void main() {
  const testEmail = 'test@email.com';

  ProviderContainer makeProviderContainer(AuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<bool>());
  });

  group('signInWithOtp', () {
    test('success', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.signInWithOtp(email: testEmail)).thenAnswer(
        (_) async => const Right<AppException, bool>(
          true,
        ),
      );
      final container = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<bool>>();
      container.listen(
        authControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const initialValue = AsyncData<bool>(false);
      // verify initial value from build method
      verify(() => listener(null, initialValue));
      final controller = container.read(authControllerProvider.notifier);

      // run
      await controller.signInWithOtp(email: testEmail);

      // verify
      verifyInOrder([
        // transition from data to loading state
        () => listener(initialValue, any(that: isA<AsyncLoading>())),
        // transition from loading state to data
        () => listener(
            any(that: isA<AsyncLoading>()), const AsyncData<bool>(true)),
      ]);
      verifyNoMoreInteractions(listener);
    });

    test('failure', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.signInWithOtp(email: testEmail))
          .thenAnswer((_) async => Left<AppException, bool>(ktestAppException));
      final container = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<bool>>();
      container.listen(
        authControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<bool>(false);
      // verify initial value from build method
      verify(() => listener(null, data));
      final controller = container.read(authControllerProvider.notifier);

      // run
      await controller.signInWithOtp(email: testEmail);

      // verify
      verifyInOrder([
        // set loading state
        () => listener(data, any(that: isA<AsyncLoading>())),
        // error when complete
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
}
