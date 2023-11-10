import 'package:intl/intl.dart';

final simpleDateTime = DateFormat('MMM dd yyyy hh:mm a');
final simpleDate = DateFormat('MMM dd yyyy');

extension DateTimeExtension on DateTime {
  String string(DateType dateType) {
    switch (dateType) {
      case DateType.simpleDateTime:
        return simpleDateTime.format(this);
      case DateType.simpleDate:
        return simpleDate.format(this);
    }
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

DateTime getDateFromString(String string, DateType dateType) {
  switch (dateType) {
    case DateType.simpleDateTime:
      return simpleDateTime.parse(string);
    case DateType.simpleDate:
      return simpleDate.parse(string);
  }
}

enum DateType { simpleDateTime, simpleDate }