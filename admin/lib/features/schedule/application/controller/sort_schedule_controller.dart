import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_schedule_controller.g.dart';

///
@riverpod
class SortScheduleController extends _$SortScheduleController {
  @override
  FutureOr<bool> build() async {
    return true;
  }

  Future<void> sortSchedule(bool ascending) async {
    state = AsyncValue.data(ascending);
  }
}
