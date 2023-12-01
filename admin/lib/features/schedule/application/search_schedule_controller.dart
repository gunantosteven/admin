import 'dart:async';

import 'package:admin/features/schedule/application/sort_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_schedule_controller.g.dart';

///
@riverpod
class SearchScheduleController extends _$SearchScheduleController {
  int _limit = pageLimit;

  Timer? _debounce;

  var _searchText = '';

  @override
  FutureOr<List<ScheduleModel>> build() async {
    return await _searchSchedule('');
  }

  FutureOr<List<ScheduleModel>> _searchSchedule(String title) async {
    _searchText = title;
    final ascending = ref.read(sortScheduleControllerProvider).value ?? false;
    final res = await ref
        .watch(scheduleRepositoryProvider)
        .searchSchedule(limit: _limit, title: title, ascending: ascending);
    return res.fold((l) => throw l, (r) => r);
  }

  void search(String title) async {
    // If empty change back to realtime stream (list_schedule_controller)
    if (title.isEmpty) {
      _searchText = title;
      state = const AsyncData([]);
      return;
    }
    state = const AsyncValue.loading();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      state = await AsyncValue.guard(
        () async {
          return await _searchSchedule(title);
        },
      );
    });
  }

  void reload() {
    if (_searchText.isNotEmpty) {
      search(_searchText);
    }
  }

  void loadMore() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        _limit += pageLimit;
        return await _searchSchedule(_searchText);
      },
    );
  }

  bool canLoadMore(int newLength) {
    return newLength % pageLimit == 0;
  }

  bool isSearchMode() => _searchText.isNotEmpty;
}
