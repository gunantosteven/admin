import 'package:admin/features/schedule/application/controller/search_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_schedule_controller.g.dart';

///
@riverpod
class DeleteScheduleController extends _$DeleteScheduleController {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<void> deleteSchedule({required ScheduleModel scheduleModel}) async {
    state = const AsyncLoading();
    final res = await ref
        .read(scheduleRepositoryProvider)
        .deleteSchedule(scheduleModel: scheduleModel);
    state = res.fold(
        (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
        AsyncValue.data);

    // required to reload if search mode
    ref.read(searchScheduleControllerProvider.notifier).reload();
  }
}
