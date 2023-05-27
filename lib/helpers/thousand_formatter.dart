import 'package:intl/intl.dart';

class ThousandFormatter {
  static String inDouble(double value) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(value);
  }

  static String inInt(int value) {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(value);
  }
}
