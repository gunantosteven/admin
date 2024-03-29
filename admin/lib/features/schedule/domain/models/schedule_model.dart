import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

/// [ScheduleModel] model
@freezed
class ScheduleModel with _$ScheduleModel {
  /// Factory constructor
  /// [id] - [ScheduleModel] id. Null if schedule hasn't been created in the database
  /// [title] - [ScheduleModel] title
  /// [date] - [ScheduleModel] date
  /// [userId] - [ScheduleModel] userId
  /// [user] - [ScheduleModel] user model
  /// [createdAt] - [ScheduleModel] createdAt
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ScheduleModel({
    @JsonKey(includeIfNull: false) String? id,
    @Default('') String title,
    @Default('') String description,
    required DateTime date,
    String? userId,
    @JsonKey(name: 'user') UserModel? userModel,
    DateTime? createdAt,
  }) = _ScheduleModel;

  static const tableName = 'schedule';

  static const idKey = 'id';
  static const titleKey = 'title';
  static const descriptionKey = 'description';
  static const dateKey = 'date';
  static const userIdKey = 'user_id';
  static const userKey = 'user';
  static const createdAtKey = 'created_at';

  /// Serialization
  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}
