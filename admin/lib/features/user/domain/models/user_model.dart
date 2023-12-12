import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// [UserModel] model
@freezed
class UserModel with _$UserModel {
  /// Factory constructor
  /// [id] - [UserModel] id. Null if schedule hasn't been created in the database
  /// [name] - [UserModel] name
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserModel({
    @JsonKey(includeIfNull: false) String? id,
    @Default('') String name,
    required String authId,
  }) = _UserModel;

  static const tableName = 'user';

  static const idKey = 'id';
  static const nameKey = 'name';
  static const authIdKey = 'auth_id';

  /// Serialization
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
