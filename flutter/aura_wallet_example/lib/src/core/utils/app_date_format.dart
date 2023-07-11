import 'package:intl/intl.dart';

class AppDateFormatter {
  static final DateFormat amPm = DateFormat('a');
  static final DateFormat hourMinute = DateFormat('HH:mm');
  static final DateFormat hourMinuteSecond = DateFormat('HH:mm:ss');
  static final DateFormat hourMinuteAmPm = DateFormat('hh:mm a');
  static final DateFormat day = DateFormat('dd');
  static final DateFormat dayMonthYearWithSlash = DateFormat('dd/MM/yyyy');
  static final DateFormat hourMinuteDayMonthYearWithSlash =
      DateFormat('HH:mm dd/MM/yyyy');
  static final DateFormat dayMonthYearWithDot = DateFormat('dd.MM.yyyy');
  static final DateFormat yearMonthDayWithDot = DateFormat('yyyy.MM.dd');
  static final DateFormat yearMonthDayWithHyphen = DateFormat('yyyy-MM-dd');
  static DateFormat yearMonthDayHourMinuteSecond =
      DateFormat('yyyy-MM-dd HH:mm:ss');
  static DateFormat yearMonthDayHourMinute = DateFormat('yyyy-MM-dd HH:mm');
  static final DateFormat dowFullWithDayMonthYear =
      DateFormat('EEEE, dd/MM/yyyy');
  static final DateFormat dowShortWithDayMonthYear =
      DateFormat('EEE, dd/MM/yyyy');
  static final DateFormat dowShort = DateFormat('EEE');
  static final DateFormat monthShort = DateFormat('MMM');
  static final DateFormat monthShortWithYear = DateFormat('MMM yyyy');
}

class AppDateTime {
  static DateTime parseDateTime(String date) {
    if (date.lastIndexOf('Z') != -1) {
      return DateTime.parse(date).toLocal();
    }
    return DateTime.parse(date);
  }

  static String formatDateToString(
    DateTime date, {
    required DateFormat format,
  }) {
    return format.format(date);
  }
}
