import 'package:admin/features/schedule/application/search_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_schedule_controller.g.dart';

///
@riverpod
class UpdateScheduleController extends _$UpdateScheduleController {
  @override
  FutureOr<ScheduleModel?> build() async {
    return null;
  }

  Future<void> updateSchedule(
      {required ScheduleModel currentSchedule,
      required String newTitle}) async {
    state = const AsyncLoading();
    final updateSchedule = currentSchedule.copyWith.call(title: newTitle);
    final res = await ref
        .read(scheduleRepositoryProvider)
        .updateSchedule(scheduleModel: updateSchedule);
    state = res.fold(
        (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
        AsyncValue.data);

    // required to reload if search mode
    ref.read(searchScheduleControllerProvider.notifier).reload();
  }
}
