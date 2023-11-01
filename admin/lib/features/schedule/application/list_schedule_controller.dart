import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_schedule_controller.g.dart';

///
@riverpod
class ListScheduleController extends _$ListScheduleController {
  @override
  FutureOr<Stream<List<ScheduleModel>>> build() async {
    final res = await ref.watch(scheduleRepositoryProvider).streamSchedule();
    return res.fold((l) => throw l, (r) => r);
  }
}
