import 'package:admin/features/schedule/application/state/new_schedule_state.dart';
import 'package:admin/features/schedule/domain/forms/title_formz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  group(
    'NewScheduleState Test',
    () {
      test('Initial State NewScheduleState', () {
        NewScheduleState testNewScheduleState = const NewScheduleState();
        expect(testNewScheduleState.status, FormzSubmissionStatus.initial);
        expect(testNewScheduleState.title, const TitleFormz.pure());
      });
    },
  );
}
