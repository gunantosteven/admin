import 'package:uuid/uuid.dart';

const uuid = Uuid();

String get generateNewUuid => uuid.v8();
