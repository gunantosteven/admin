import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_schedule_controller.g.dart';

///
@riverpod
class NewScheduleController extends _$NewScheduleController {
  @override
  FutureOr<ScheduleModel?> build() async {
    return null;
  }

  Future<void> addSchedule({required String job}) async {
    state = const AsyncLoading();
    final res = await ref
        .read(scheduleRepositoryProvider)
        .addSchedule(scheduleModel: ScheduleModel(job: job));
    state = res.fold(
        (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
        AsyncValue.data);
  }
}
