import 'package:intl/intl.dart';

String formatDate(String date ,{ String? pattern}) {
  DateTime parsedDate = DateTime.parse(date);
  String formattedDate = DateFormat(pattern??'dd/MM/yyyy').format(parsedDate);
  return formattedDate;
}