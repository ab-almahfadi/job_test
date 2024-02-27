import 'package:intl/intl.dart';

extension IndonesianDateFormatter on DateTime {
  String get toBirth => DateFormat('dd-MMMM-y', 'id_ID').format(this);

  String get toTransaction =>
      DateFormat('dd MMM y hh:mm', 'id_ID').format(this);
}
