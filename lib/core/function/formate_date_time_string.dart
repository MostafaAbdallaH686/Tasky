import 'package:intl/intl.dart';

String formateDateTimeString(String date) {
  DateTime dateTime = DateTime.parse(date).toLocal();
  String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);

  return formattedDate;
}
