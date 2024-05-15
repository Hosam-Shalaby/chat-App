import 'package:intl/intl.dart';

String formatMessageDate(int messageDateTime) {
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(messageDateTime);
  DateFormat dateFormat = DateFormat('hh:mm a');
  return dateFormat.format(dateTime);
}
