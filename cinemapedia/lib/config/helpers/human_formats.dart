import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, {int decimalDigits = 1}) {
    final formatterNumber = NumberFormat.compactCurrency(
            decimalDigits: decimalDigits, symbol: '', locale: 'en')
        .format(number);
    return formatterNumber;
  }
}
