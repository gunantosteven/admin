import 'package:admin/features/schedule/application/controller/search_schedule_controller.dart';
import 'package:admin/features/schedule/application/state/update_schedule_state.dart';
import 'package:admin/features/schedule/domain/forms/title_formz.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_schedule_controller.g.dart';

///
@riverpod
class UpdateScheduleController extends _$UpdateScheduleController {
  @override
  FutureOr<UpdateScheduleState> build(ScheduleModel scheduleModel) async {
    return UpdateScheduleState(title: TitleFormz.dirty(scheduleModel.title));
  }

  bool isValidForm() {
    if (state.value == null) {
      return false;
    }
    return state.requireValue.title.isValid;
  }

  void updateTitle(String value) {
    final title = TitleFormz.dirty(value);
    state = AsyncValue.data(
      state.requireValue.copyWith.call(
        title: title,
      ),
    );
  }

  Future<void> updateSchedule(
      {required ScheduleModel currentSchedule,
      required String newDescription,
      required DateTime newDate,
      required TimeOfDay newTime}) async {
    state = const AsyncLoading();
    final newScheduleDate = DateTime(
        newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
    final updateSchedule = currentSchedule.copyWith.call(
        title: state.requireValue.title.value,
        description: newDescription,
        date: newScheduleDate);
    final res = await ref
        .read(scheduleRepositoryProvider)
        .updateSchedule(scheduleModel: updateSchedule);
    state = res.fold(
      (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
      (r) => AsyncValue.data(
        state.value!.copyWith.call(status: FormzSubmissionStatus.success),
      ),
    );

    // required to reload if search mode
    ref.read(searchScheduleControllerProvider.notifier).reload();
  }
}
