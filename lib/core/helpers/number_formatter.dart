import 'package:intl/intl.dart';

extension NumX on num {
  String toCurrencyFormatted() {
    num number = this;
    if (!number.hasDecimal) number = number.toInt();

    final formattedNumber = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: hasDecimal ? 2 : 0,
    ).format(number);

    return formattedNumber;
  }

  bool get hasDecimal {
    return this % 1 != 0;
  }
}
