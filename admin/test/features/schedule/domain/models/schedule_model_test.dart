import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> ktestScheduleMap = {
  "id": '20231115-0620-8a33-8795-947684be0112',
  "title": "title",
  "description": "description",
  "date": "2023-12-05T13:20:33.795Z",
  "created_at": "2023-11-15T13:20:33.795Z",
  "user_id": "da2a8ca2-1763-4a16-b073-1d0da5fdceac",
  "user": {
    "id": "da2a8ca2-1763-4a16-b073-1d0da5fdceac",
    "name": "admin",
    "auth_id": "da2a8ca2-1763-4a16-b073-1d0da5fdceac"
  }
};

ScheduleModel ktestScheduleModel = ScheduleModel.fromJson(ktestScheduleMap);

void main() {
  group(
    'ScheduleModel Test',
    () {
      test('Should parse schedule from json', () {
        expect(ScheduleModel.fromJson(ktestScheduleMap), ktestScheduleModel);
      });

      test('Should return json from schedule', () {
        expect(ktestScheduleModel.toJson(), ktestScheduleMap);
      });

      test('Should return new title', () {
        expect(ktestScheduleModel.copyWith.call(title: 'new title').title,
            'new title');
      });
    },
  );
}
