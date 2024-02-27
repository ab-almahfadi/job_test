import 'package:intl/intl.dart';

class TimeHelper {
  static String convertTo12Hours(String date) {
    return DateFormat('hh:mm a').format(DateTime.parse(date).toLocal());
  }

  static String convertTo24Hours(String date) {
    return DateFormat('HH:mm', 'id_ID').format(DateTime.parse(date).toLocal());
  }

  static String convertToDDMMYYYY(String date) {
    return DateFormat('dd MMM yyyy, hh:mm a')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToBirthday(String date) {
    return DateFormat('MM/dd/yyyy')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToDDMMHHmm(String date) {
    return DateFormat('dd MMM, HH:mm')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToDayName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static String convertToDate24(String date) {
    return DateFormat('dd MMM yyyy, HH:mm', 'id_ID')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToDate24withDay(String date) {
    return DateFormat('EEEE, dd MMM yyyy, HH:mm')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToDateWithDay(String date) {
    return DateFormat('EEEE, dd MMM yyyy')
        .format(DateTime.parse(date).toLocal());
  }

  static String convertToDate(String date) {
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date).toLocal());
  }

  static int convertStringToDateTime(String date) {
    return DateTime.parse(date).toLocal().millisecondsSinceEpoch;
  }
}
