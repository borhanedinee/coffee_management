import 'package:intl/intl.dart';

String formatDateWithOrdinal(DateTime date) {
  // Format the month and year using intl
  final monthYearFormat = DateFormat('MMMM dd ,yyy'); // e.g., "January 2025"
  // final day = date.day;

  // // Determine the ordinal suffix (st, nd, rd, th)
  // String ordinalSuffix;
  // if (day % 10 == 1 && day != 11) {
  //   ordinalSuffix = 'st';
  // } else if (day % 10 == 2 && day != 12) {
  //   ordinalSuffix = 'nd';
  // } else if (day % 10 == 3 && day != 13) {
  //   ordinalSuffix = 'rd';
  // } else {
  //   ordinalSuffix = 'th';
  // }

  // Combine the formatted month, day with ordinal, and year
  return '${monthYearFormat.format(date)} ';
}
