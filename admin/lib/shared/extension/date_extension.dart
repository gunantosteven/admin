import 'package:intl/intl.dart';

final simpleDateTime = DateFormat('MMM dd yyyy HH:mm');
final simpleDate = DateFormat('MMM dd yyyy');
final dayOfWeekDate = DateFormat('E, dd MMM yyyy');

extension DateTimeExtension on DateTime {
  String string(DateType dateType) {
    switch (dateType) {
      case DateType.simpleDateTime:
        return simpleDateTime.format(this);
      case DateType.simpleDate:
        return simpleDate.format(this);
      case DateType.dayOfWeekDate:
        return dayOfWeekDate.format(this);
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
    case DateType.dayOfWeekDate:
      return dayOfWeekDate.parse(string);
  }
}

enum DateType { simpleDateTime, simpleDate, dayOfWeekDate }
