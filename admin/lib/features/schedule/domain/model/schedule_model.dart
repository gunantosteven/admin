import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

/// [ScheduleModel] model
@freezed
class ScheduleModel with _$ScheduleModel {
  /// Factory constructor
  /// [id] - [ScheduleModel] id. Null if schedule hasn't been created in the database
  /// [title] - [ScheduleModel] title
  /// [createdAt] - [ScheduleModel] createdAt
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ScheduleModel({
    @JsonKey(includeIfNull: false) String? id,
    @Default('') String title,
    DateTime? createdAt,
  }) = _ScheduleModel;

  static const idKey = 'id';
  static const titleKey = 'title';
  static const createdAtKey = 'created_at';

  /// Serialization
  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}
