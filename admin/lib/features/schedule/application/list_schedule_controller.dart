import 'package:admin/features/schedule/domain/model/schedule_model.dart';
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
    return _fetchSchedule();
  }

  FutureOr<Stream<List<ScheduleModel>>> _fetchSchedule() async {
    final res = await ref
        .watch(scheduleRepositoryProvider)
        .streamSchedule(limit: _limit);
    return res.fold((l) => throw l, (r) => r);
  }

  void loadMore() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        _limit += pageLimit;
        return await _fetchSchedule();
      },
    );
  }

  bool canLoadMore(int newLength) {
    return newLength % pageLimit == 0;
  }
}
