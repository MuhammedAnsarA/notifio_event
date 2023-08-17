import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String get timeOnly => DateFormat("hh:mm").format(this);

  String get dateOnly => DateFormat("dd-MM-yyyy").format(this);
}
