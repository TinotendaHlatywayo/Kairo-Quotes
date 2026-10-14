import 'package:intl/intl.dart';

/// The app stores monetary amounts as integer minor units (cents).
class Money {
  const Money(this.minorUnits, {this.currencyCode = 'USD'});

  final int minorUnits;
  final String currencyCode;

  Money operator +(Money other) {
    _requireSameCurrency(other);
    return Money(minorUnits + other.minorUnits, currencyCode: currencyCode);
  }

  Money operator -(Money other) {
    _requireSameCurrency(other);
    return Money(minorUnits - other.minorUnits, currencyCode: currencyCode);
  }

  bool get isNegative => minorUnits < 0;

  void _requireSameCurrency(Money other) {
    if (currencyCode != other.currencyCode) {
      throw ArgumentError.value(
        other.currencyCode,
        'currencyCode',
        'Cannot combine $currencyCode and ${other.currencyCode}.',
      );
    }
  }
}

/// Quantities are stored in thousandths, so 12.5 metres is 12500.
class Quantity {
  const Quantity(this.milliUnits);

  final int milliUnits;

  static Quantity parse(String input) {
    final value = input.trim();
    final match = RegExp(r'^([+-]?)(\d+)(?:\.(\d{1,3}))?$').firstMatch(value);
    if (match == null) {
      throw FormatException('Enter a quantity with up to three decimal places.');
    }
    final sign = match.group(1) == '-' ? -1 : 1;
    final whole = int.parse(match.group(2)!);
    final fraction = (match.group(3) ?? '').padRight(3, '0');
    return Quantity(sign * (whole * 1000 + int.parse(fraction)));
  }

  String format() {
    final sign = milliUnits < 0 ? '-' : '';
    final absolute = milliUnits.abs();
    final whole = absolute ~/ 1000;
    final fraction = (absolute % 1000).toString().padLeft(3, '0');
    final trimmedFraction = fraction.replaceFirst(RegExp(r'0+$'), '');
    return trimmedFraction.isEmpty ? '$sign$whole' : '$sign$whole.$trimmedFraction';
  }
}

class CurrencySpec {
  const CurrencySpec(this.code, this.symbol, {this.decimalPlaces = 2});

  final String code;
  final String symbol;
  final int decimalPlaces;

  static const usd = CurrencySpec('USD', r'$');
  static const zig = CurrencySpec('ZiG', 'ZiG');

  static CurrencySpec forCode(String code) => switch (code.toUpperCase()) {
    'USD' => usd,
    'ZIG' => zig,
    _ => CurrencySpec(code.toUpperCase(), code.toUpperCase()),
  };
}

/// Formats integer minor units without converting money to a floating point value.
class MoneyFormatter {
  const MoneyFormatter._();

  static String format(
    int minorUnits,
    String currencyCode, {
    String? locale,
    bool useSymbol = true,
  }) {
    final currency = CurrencySpec.forCode(currencyCode);
    final scale = _powerOfTen(currency.decimalPlaces);
    final absolute = minorUnits.abs();
    final whole = absolute ~/ scale;
    final fraction = currency.decimalPlaces == 0
        ? ''
        : '.${(absolute % scale).toString().padLeft(currency.decimalPlaces, '0')}';
    final groupedWhole = NumberFormat.decimalPattern(locale).format(whole);
    final sign = minorUnits < 0 ? '-' : '';
    if (currency.code == 'USD' && useSymbol) {
      return '$sign${currency.symbol}$groupedWhole$fraction';
    }
    final prefix = useSymbol ? currency.symbol : currency.code;
    return '$sign$prefix $groupedWhole$fraction';
  }

  static int _powerOfTen(int exponent) {
    var result = 1;
    for (var i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }
}

/// Parses percentages entered as human-readable percent values into basis points.
/// For example, `15.25` percent becomes 1525 basis points.
int parsePercentToBasisPoints(String input) {
  final normalized = input.trim().replaceAll(',', '.');
  final match = RegExp(r'^(\d{1,3})(?:\.(\d{1,2}))?$').firstMatch(normalized);
  if (match == null) {
    throw FormatException('Enter a percentage from 0 to 100 with up to two decimals.');
  }
  final whole = int.parse(match.group(1)!);
  final fraction = int.parse((match.group(2) ?? '').padRight(2, '0'));
  final basisPoints = whole * 100 + fraction;
  if (basisPoints > 10000) {
    throw FormatException('Percentage cannot be greater than 100.');
  }
  return basisPoints;
}
