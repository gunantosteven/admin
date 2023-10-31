import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_list_controller.g.dart';

///
@riverpod
class ScheduleListController extends _$ScheduleListController {
  @override
  FutureOr<Stream<List<ScheduleModel>>> build() async {
    final res = await ref.watch(scheduleRepositoryProvider).streamSchedule();
    return res.fold((l) => throw l, (r) => r);
  }
}
