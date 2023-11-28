import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabaseClient;
  final String tableName;

  SupabaseService(this.supabaseClient, this.tableName);

  Stream<List<Map<String, dynamic>>> stream(
      {required String idKey,
      required String orderKey,
      bool ascending = false,
      required int limit}) {
    final stream = supabaseClient
        .from(tableName)
        .stream(primaryKey: [idKey])
        .order(orderKey, ascending: ascending)
        .limit(limit);

    return stream;
  }

  Future<void> insert(dynamic value) async {
    await supabaseClient.from(tableName).insert(
          value,
        );
  }

  Future<void> update(dynamic value,
      {required Map<dynamic, dynamic> match}) async {
    await supabaseClient
        .from(tableName)
        .update(
          value,
        )
        .match(match);
  }

  Future<dynamic> delete(String column, dynamic value) async {
    final data =
        await supabaseClient.from(tableName).select().eq(column, value);
    if (data is List<dynamic> && data.isEmpty) {
      return AppException(
        message: 'Schedule not found!',
        statusCode: 1,
        identifier: 'SCHEDULENOTFOUNDScheduleDataSource.deleteSchedule',
      );
    }
    await supabaseClient.from(tableName).delete().match(
      {column: value},
    );
  }

  Future<dynamic> search({
    required String columnSearch,
    required String pattern,
    required String orderKey,
    required bool ascending,
    required int limit,
  }) async {
    return await supabaseClient
        .from(tableName)
        .select()
        .ilike(columnSearch, '%$pattern%')
        .order(orderKey, ascending: ascending)
        .limit(limit);
  }
}
