import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('MMMM d, y').format(dateTime); // e.g., June 19, 2024
    } catch (e) {
      return rawDate; // fallback if parsing fails
    }
  }
}
