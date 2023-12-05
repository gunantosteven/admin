import 'package:admin/features/schedule/application/search_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_schedule_controller.g.dart';

///
@riverpod
class NewScheduleController extends _$NewScheduleController {
  @override
  FutureOr<ScheduleModel?> build() async {
    return null;
  }

  Future<void> createSchedule(
      {required String title,
      required DateTime date,
      required TimeOfDay time}) async {
    state = const AsyncLoading();
    final scheduleDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final res = await ref.read(scheduleRepositoryProvider).createSchedule(
          scheduleModel: ScheduleModel(title: title, date: scheduleDate),
        );
    state = res.fold(
        (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
        AsyncValue.data);

    // required to reload if search mode
    ref.read(searchScheduleControllerProvider.notifier).reload();
  }
}
