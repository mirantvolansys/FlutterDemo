import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();

  var formatter = DateFormat("EEE, MMM d  ''yy");
  return formatter.format(now);
}