import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/features/schedule/presentation/provider/state/schedule_notifier.dart';
import 'package:admin/features/schedule/presentation/provider/state/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleStateNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState>(
  (ref) {
    final ScheduleRepository scheduleRepository =
        ref.watch(scheduleRepositoryProvider);
    return ScheduleNotifier(
      scheduleRepository: scheduleRepository,
    );
  },
);
