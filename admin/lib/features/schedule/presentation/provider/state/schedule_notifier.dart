import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/features/schedule/presentation/provider/state/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleNotifier({
    required this.scheduleRepository,
  }) : super(const ScheduleState.initial());

  Stream<List<ScheduleModel>> streamSchedule() {
    return scheduleRepository.streamSchedule();
  }
}
