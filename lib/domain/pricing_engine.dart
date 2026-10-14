/// A pricing row. Section headers must have no price or quantity.
class PricingLine {
  const PricingLine({
    this.unitPriceMinor,
    this.quantityMilli,
    this.isSectionHeader = false,
  });

  final int? unitPriceMinor;
  final int? quantityMilli;
  final bool isSectionHeader;
}

enum DiscountKind { none, percent, fixed }

class Discount {
  const Discount._(this.kind, this.value);

  const Discount.none() : this._(DiscountKind.none, 0);

  /// [basisPoints] is the percent in hundredths: 5% is 500.
  const Discount.percent(int basisPoints)
    : this._(DiscountKind.percent, basisPoints);

  /// [minorUnits] is an amount in the document's currency.
  const Discount.fixed(int minorUnits)
    : this._(DiscountKind.fixed, minorUnits);

  final DiscountKind kind;
  final int value;
}

class PricingResult {
  const PricingResult({
    required this.lineTotalsMinor,
    required this.subtotalMinor,
    required this.discountMinor,
    required this.taxableMinor,
    required this.vatMinor,
    required this.grandTotalMinor,
  });

  final List<int> lineTotalsMinor;
  final int subtotalMinor;
  final int discountMinor;
  final int taxableMinor;
  final int vatMinor;
  final int grandTotalMinor;
}

class PriceAdjustmentPreview {
  const PriceAdjustmentPreview({
    required this.originalUnitPricesMinor,
    required this.adjustedUnitPricesMinor,
  });

  final List<int?> originalUnitPricesMinor;
  final List<int?> adjustedUnitPricesMinor;
}

/// The single source of truth for document financial calculations.
class PricingEngine {
  const PricingEngine();

  static const int quantityScale = 1000;
  static const int basisPointsPerWhole = 10000;
  static const int minorUnitsPerWhole = 100;

  PricingResult calculate({
    required List<PricingLine> lines,
    required int vatRateBasisPoints,
    Discount discount = const Discount.none(),
  }) {
    if (vatRateBasisPoints < 0 || vatRateBasisPoints > basisPointsPerWhole) {
      throw RangeError.range(
        vatRateBasisPoints,
        0,
        basisPointsPerWhole,
        'vatRateBasisPoints',
      );
    }
    if (discount.value < 0) {
      throw RangeError.value(discount.value, 'discount', 'Cannot be negative.');
    }
    if (discount.kind == DiscountKind.percent &&
        discount.value > basisPointsPerWhole) {
      throw RangeError.range(
        discount.value,
        0,
        basisPointsPerWhole,
        'discount percentage',
      );
    }

    final lineTotals = <int>[];
    var subtotal = 0;
    for (var index = 0; index < lines.length; index++) {
      final line = lines[index];
      if (line.isSectionHeader) {
        if (line.unitPriceMinor != null || line.quantityMilli != null) {
          throw ArgumentError('Section-header rows cannot have a price or quantity.');
        }
        lineTotals.add(0);
        continue;
      }

      final unitPrice = line.unitPriceMinor;
      final quantity = line.quantityMilli;
      if (unitPrice == null || quantity == null) {
        throw ArgumentError('Priced rows require a unit price and quantity.');
      }
      if (unitPrice < 0 || quantity < 0) {
        throw RangeError('Prices and quantities cannot be negative.');
      }
      final total = roundHalfUp(unitPrice * quantity, quantityScale);
      lineTotals.add(total);
      subtotal += total;
    }

    final discountMinor = switch (discount.kind) {
      DiscountKind.none => 0,
      DiscountKind.percent => _percentageOf(subtotal, discount.value),
      DiscountKind.fixed => discount.value,
    };
    final cappedDiscount = discountMinor > subtotal ? subtotal : discountMinor;
    final taxable = subtotal - cappedDiscount;
    final vat = _percentageOf(taxable, vatRateBasisPoints);

    return PricingResult(
      lineTotalsMinor: List.unmodifiable(lineTotals),
      subtotalMinor: subtotal,
      discountMinor: cappedDiscount,
      taxableMinor: taxable,
      vatMinor: vat,
      grandTotalMinor: taxable + vat,
    );
  }

  /// Applies a percentage to one document's unit prices without touching a catalog.
  /// [adjustmentBasisPoints] uses percent hundredths: +5% is 500; -100% is -10000.
  PriceAdjustmentPreview previewPriceAdjustment({
    required List<int?> unitPricesMinor,
    required List<bool> sectionHeaders,
    required int adjustmentBasisPoints,
    bool roundToWholeCurrencyUnit = false,
  }) {
    if (unitPricesMinor.length != sectionHeaders.length) {
      throw ArgumentError('Price and section-header lists must have equal lengths.');
    }
    if (adjustmentBasisPoints < -basisPointsPerWhole) {
      throw RangeError.value(adjustmentBasisPoints, 'adjustmentBasisPoints');
    }

    final adjusted = <int?>[];
    for (var i = 0; i < unitPricesMinor.length; i++) {
      final price = unitPricesMinor[i];
      if (sectionHeaders[i]) {
        if (price != null) {
          throw ArgumentError('Section-header rows cannot have a unit price.');
        }
        adjusted.add(null);
        continue;
      }
      if (price == null || price < 0) {
        throw ArgumentError('Priced rows need a non-negative unit price.');
      }
      var adjustedPrice = roundHalfUp(
        price * (basisPointsPerWhole + adjustmentBasisPoints),
        basisPointsPerWhole,
      );
      if (roundToWholeCurrencyUnit) {
        adjustedPrice =
            roundHalfUp(adjustedPrice, minorUnitsPerWholeUnitScale) *
            minorUnitsPerWholeUnitScale;
      }
      adjusted.add(adjustedPrice);
    }
    return PriceAdjustmentPreview(
      originalUnitPricesMinor: List.unmodifiable(unitPricesMinor),
      adjustedUnitPricesMinor: List.unmodifiable(adjusted),
    );
  }

  static const int minorUnitsPerWholeUnitScale = 100;

  static int _percentageOf(int amountMinor, int rateBasisPoints) =>
      roundHalfUp(amountMinor * rateBasisPoints, basisPointsPerWhole);
}

/// Integer-only round-half-up. For negative values ties are rounded away from zero.
int roundHalfUp(int numerator, int denominator) {
  if (denominator <= 0) {
    throw RangeError.value(denominator, 'denominator', 'Must be positive.');
  }
  final sign = numerator < 0 ? -1 : 1;
  final absolute = numerator.abs();
  final quotient = absolute ~/ denominator;
  final remainder = absolute % denominator;
  return sign * (quotient + (remainder * 2 >= denominator ? 1 : 0));
}
