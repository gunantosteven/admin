import 'package:admin/features/schedule/application/controller/sort_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_schedule_controller.g.dart';

///
@riverpod
class ListScheduleController extends _$ListScheduleController {
  int _limit = pageLimit;

  @override
  FutureOr<Stream<List<ScheduleModel>>> build() async {
    return const Stream.empty();
  }

  Future<void> initSchedule() async {
    state = const AsyncLoading();
    state = await _fetchSchedule();
  }

  Future<void> loadMore() async {
    state = const AsyncValue.loading();
    _limit += pageLimit;
    state = await _fetchSchedule();
  }

  bool canLoadMore(int newLength) {
    return newLength % pageLimit == 0;
  }

  FutureOr<AsyncValue<Stream<List<ScheduleModel>>>> _fetchSchedule() async {
    final ascending = ref.read(sortScheduleControllerProvider).value ?? true;
    final res = await ref
        .read(scheduleRepositoryProvider)
        .streamSchedule(limit: _limit, ascending: ascending);

    return res.fold(
        (l) => AsyncValue.error(l.message ?? '', StackTrace.current),
        AsyncValue.data);
  }
}
