import 'package:admin/features/schedule/domain/forms/title_formz.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_schedule_state.freezed.dart';

@freezed
class UpdateScheduleState with _$UpdateScheduleState {
  const factory UpdateScheduleState({
    @Default(TitleFormz.pure()) TitleFormz title,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _UpdateScheduleState;
}
