import 'package:admin/features/schedule/domain/forms/title_formz.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_schedule_state.freezed.dart';

@freezed
class NewScheduleState with _$NewScheduleState {
  const factory NewScheduleState({
    @Default(TitleFormz.pure()) TitleFormz title,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _NewScheduleState;
}
