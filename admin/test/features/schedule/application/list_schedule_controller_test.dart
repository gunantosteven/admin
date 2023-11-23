import 'dart:async';

import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data.dart';
import '../../../mocks.dart';
import '../domain/models/schedule_model_test.dart';

void main() {
  ProviderContainer makeProviderContainer(
      ScheduleRepository scheduleRepository) {
    final container = ProviderContainer(
      overrides: [
        scheduleRepositoryProvider.overrideWithValue(scheduleRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<Stream<List<ScheduleModel>>>());
  });

  group('listScheduleController', () {
    test('success', () async {
      // setup
      final scheduleRepository = MockScheduleRepository();
      final StreamController<List<ScheduleModel>> streamController =
          StreamController<List<ScheduleModel>>();
      streamController.add([ktestScheduleModel]);
      when(() => scheduleRepository.streamSchedule(limit: pageLimit))
          .thenAnswer(
        (_) async => Right<AppException, Stream<List<ScheduleModel>>>(
          streamController.stream,
        ),
      );
      final container = makeProviderContainer(scheduleRepository);
      final listener = Listener<AsyncValue<Stream<List<ScheduleModel>>>>();
      container.listen(
        listScheduleControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const initialValue = AsyncLoading<Stream<List<ScheduleModel>>>();
      // verify initial value from build method
      verify(() => listener(null, initialValue));

      final controller =
          container.read(listScheduleControllerProvider.notifier);

      // run
      await controller.initSchedule();

      // verify
      verifyInOrder([
        // set loading state
        () => listener(any(that: isA<AsyncLoading>()),
            const AsyncData<Stream<List<ScheduleModel>>>(Stream.empty())),
        // transition from loading state to data
        () => listener(any(that: isA<AsyncData>()),
            AsyncData<Stream<List<ScheduleModel>>>(streamController.stream)),
      ]);
      verifyNoMoreInteractions(listener);
    });

    test('failure', () async {
      // setup
      final scheduleRepository = MockScheduleRepository();
      when(() => scheduleRepository.streamSchedule(limit: pageLimit))
          .thenAnswer(
        (_) async =>
            Left<AppException, Stream<List<ScheduleModel>>>(ktestAppException),
      );
      final container = makeProviderContainer(scheduleRepository);
      final listener = Listener<AsyncValue<Stream<List<ScheduleModel>>>>();
      container.listen(
        listScheduleControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const initialValue = AsyncLoading<Stream<List<ScheduleModel>>>();
      // verify initial value from build method
      verify(() => listener(null, initialValue));

      final controller =
          container.read(listScheduleControllerProvider.notifier);

      // run
      await controller.initSchedule();

      // verify
      verifyInOrder([
        // set loading state
        () => listener(any(that: isA<AsyncLoading>()),
            const AsyncData<Stream<List<ScheduleModel>>>(Stream.empty())),
        // error when complete
        () =>
            listener(any(that: isA<AsyncData>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
}
