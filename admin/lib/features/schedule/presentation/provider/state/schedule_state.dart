import 'package:admin/shared/exception/http_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_state.freezed.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const factory ScheduleState.initial() = Initial;
  const factory ScheduleState.loading() = Loading;
  const factory ScheduleState.failure(AppException exception) = Failure;
  const factory ScheduleState.success() = Success;
}
