import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

/// [ScheduleModel] model
@freezed
class ScheduleModel with _$ScheduleModel {
  /// Factory constructor
  /// [id] - [ScheduleModel] id. Null if schedule hasn't been created in the database
  /// [job] - [ScheduleModel] job
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ScheduleModel({
    @JsonKey(includeIfNull: false) String? id,
    @Default('') String job,
  }) = _ScheduleModel;

  /// Serialization
  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  // @override
  // Map<String, dynamic> toJson() => _$OrganizationEntityToJson(this);
}
