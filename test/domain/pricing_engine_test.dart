import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/domain/money.dart';
import 'package:quotes/domain/pricing_engine.dart';

void main() {
  const engine = PricingEngine();

  group('roundHalfUp', () {
    test('rounds below, at, and above half away from zero', () {
      expect(roundHalfUp(4, 10), 0);
      expect(roundHalfUp(5, 10), 1);
      expect(roundHalfUp(6, 10), 1);
      expect(roundHalfUp(-4, 10), 0);
      expect(roundHalfUp(-5, 10), -1);
      expect(roundHalfUp(-6, 10), -1);
    });

    test('rejects a zero or negative denominator', () {
      expect(() => roundHalfUp(1, 0), throwsRangeError);
      expect(() => roundHalfUp(1, -2), throwsRangeError);
    });
  });

  group('Money and Quantity', () {
    test('money only combines amounts in the same currency', () {
      expect(
        (const Money(100) + const Money(50)).minorUnits,
        150,
      );
      expect(
        () => const Money(100) + const Money(50, currencyCode: 'ZiG'),
        throwsArgumentError,
      );
    });

    test('parses and formats quantity to thousandths', () {
      expect(Quantity.parse('12.5').milliUnits, 12500);
      expect(Quantity.parse('0.025').milliUnits, 25);
      expect(Quantity.parse('-3.1').format(), '-3.1');
      expect(const Quantity(12000).format(), '12');
      expect(const Quantity(12050).format(), '12.05');
      expect(() => Quantity.parse('2.1234'), throwsFormatException);
    });

    test('formats USD and ZiG using integer minor units', () {
      expect(MoneyFormatter.format(123456, 'USD', locale: 'en_US'), r'$1,234.56');
      expect(
        MoneyFormatter.format(123456, 'ZiG', locale: 'en_US'),
        'ZiG 1,234.56',
      );
      expect(
        MoneyFormatter.format(123456, 'ZiG', locale: 'en_US', useSymbol: false),
        'ZiG 1,234.56',
      );
      expect(MoneyFormatter.format(-5, 'USD', locale: 'en_US'), r'-$0.05');
      expect(MoneyFormatter.format(0, 'USD', locale: 'en_US'), r'$0.00');
    });

    test('parses entered percent values without floating point money math', () {
      expect(parsePercentToBasisPoints('15'), 1500);
      expect(parsePercentToBasisPoints('15.25'), 1525);
      expect(parsePercentToBasisPoints('0.5'), 50);
      expect(parsePercentToBasisPoints('100'), 10000);
      expect(() => parsePercentToBasisPoints('100.01'), throwsFormatException);
      expect(() => parsePercentToBasisPoints('-1'), throwsFormatException);
      expect(() => parsePercentToBasisPoints('1.001'), throwsFormatException);
    });
  });

  group('PricingEngine', () {
    test('calculates line totals using integer thousandths and half-up rounding', () {
      final result = engine.calculate(
        lines: const [
          PricingLine(unitPriceMinor: 1, quantityMilli: 500),
          PricingLine(unitPriceMinor: 2, quantityMilli: 250),
          PricingLine(unitPriceMinor: 4, quantityMilli: 124),
        ],
        vatRateBasisPoints: 0,
      );

      expect(result.lineTotalsMinor, [1, 1, 0]);
      expect(result.subtotalMinor, 2);
      expect(result.grandTotalMinor, 2);
    });

    test('excludes section headers while keeping row positions aligned', () {
      final result = engine.calculate(
        lines: const [
          PricingLine(isSectionHeader: true),
          PricingLine(unitPriceMinor: 2500, quantityMilli: 1000),
          PricingLine(isSectionHeader: true),
          PricingLine(unitPriceMinor: 3500, quantityMilli: 2000),
        ],
        vatRateBasisPoints: 0,
      );
      expect(result.lineTotalsMinor, [0, 2500, 0, 7000]);
      expect(result.subtotalMinor, 9500);
    });

    test('applies a percentage discount before VAT', () {
      final result = engine.calculate(
        lines: const [PricingLine(unitPriceMinor: 1000, quantityMilli: 1000)],
        discount: const Discount.percent(1000),
        vatRateBasisPoints: 1500,
      );
      expect(result.subtotalMinor, 1000);
      expect(result.discountMinor, 100);
      expect(result.taxableMinor, 900);
      expect(result.vatMinor, 135);
      expect(result.grandTotalMinor, 1035);
    });

    test('rounds percentage discounts to the nearest minor unit', () {
      final result = engine.calculate(
        lines: const [PricingLine(unitPriceMinor: 5, quantityMilli: 1000)],
        discount: const Discount.percent(1000),
        vatRateBasisPoints: 0,
      );
      expect(result.discountMinor, 1);
      expect(result.taxableMinor, 4);
    });

    test('applies fixed discounts and caps them at subtotal', () {
      final lines = const [PricingLine(unitPriceMinor: 1200, quantityMilli: 1000)];
      final fixed = engine.calculate(
        lines: lines,
        discount: const Discount.fixed(250),
        vatRateBasisPoints: 0,
      );
      expect(fixed.discountMinor, 250);
      expect(fixed.taxableMinor, 950);

      final capped = engine.calculate(
        lines: lines,
        discount: const Discount.fixed(5000),
        vatRateBasisPoints: 0,
      );
      expect(capped.discountMinor, 1200);
      expect(capped.taxableMinor, 0);
      expect(capped.grandTotalMinor, 0);
    });

    test('caps a 100 percent discount at the subtotal', () {
      final result = engine.calculate(
        lines: const [PricingLine(unitPriceMinor: 999, quantityMilli: 1000)],
        discount: const Discount.percent(10000),
        vatRateBasisPoints: 1500,
      );
      expect(result.discountMinor, 999);
      expect(result.taxableMinor, 0);
      expect(result.vatMinor, 0);
    });

    test('returns all zero totals for no lines and zero-value lines', () {
      final empty = engine.calculate(lines: const [], vatRateBasisPoints: 1500);
      final zero = engine.calculate(
        lines: const [PricingLine(unitPriceMinor: 0, quantityMilli: 5000)],
        vatRateBasisPoints: 1500,
      );
      for (final result in [empty, zero]) {
        expect(result.subtotalMinor, 0);
        expect(result.discountMinor, 0);
        expect(result.taxableMinor, 0);
        expect(result.vatMinor, 0);
        expect(result.grandTotalMinor, 0);
      }
    });

    test('accepts large prices and quantities without floating point loss', () {
      final result = engine.calculate(
        lines: const [
          PricingLine(unitPriceMinor: 1_000_000_000, quantityMilli: 1_000_000_000),
        ],
        vatRateBasisPoints: 0,
      );
      expect(result.lineTotalsMinor, [1_000_000_000_000_000]);
      expect(result.grandTotalMinor, 1_000_000_000_000_000);
    });

    test('rejects invalid prices, quantities, row shapes, VAT and discounts', () {
      expect(
        () => engine.calculate(
          lines: const [PricingLine(unitPriceMinor: -1, quantityMilli: 1000)],
          vatRateBasisPoints: 0,
        ),
        throwsRangeError,
      );
      expect(
        () => engine.calculate(
          lines: const [PricingLine(unitPriceMinor: 1, quantityMilli: -1)],
          vatRateBasisPoints: 0,
        ),
        throwsRangeError,
      );
      expect(
        () => engine.calculate(
          lines: const [PricingLine(isSectionHeader: true, unitPriceMinor: 0)],
          vatRateBasisPoints: 0,
        ),
        throwsArgumentError,
      );
      expect(
        () => engine.calculate(
          lines: const [PricingLine(unitPriceMinor: 1)],
          vatRateBasisPoints: 0,
        ),
        throwsArgumentError,
      );
      expect(
        () => engine.calculate(lines: const [], vatRateBasisPoints: 10001),
        throwsRangeError,
      );
      expect(
        () => engine.calculate(
          lines: const [],
          vatRateBasisPoints: 0,
          discount: const Discount.percent(10001),
        ),
        throwsRangeError,
      );
      expect(
        () => engine.calculate(
          lines: const [],
          vatRateBasisPoints: 0,
          discount: const Discount.fixed(-1),
        ),
        throwsRangeError,
      );
    });

    test('previews adjusted document prices without changing headers or source list', () {
      final original = <int?>[101, null, 500];
      final preview = engine.previewPriceAdjustment(
        unitPricesMinor: original,
        sectionHeaders: const [false, true, false],
        adjustmentBasisPoints: 500,
      );
      expect(preview.originalUnitPricesMinor, [101, null, 500]);
      expect(preview.adjustedUnitPricesMinor, [106, null, 525]);
      expect(original, [101, null, 500]);
    });

    test('previews negative changes and optional whole-unit rounding', () {
      final down = engine.previewPriceAdjustment(
        unitPricesMinor: const [101],
        sectionHeaders: const [false],
        adjustmentBasisPoints: -500,
      );
      expect(down.adjustedUnitPricesMinor, [96]);

      final rounded = engine.previewPriceAdjustment(
        unitPricesMinor: const [149],
        sectionHeaders: const [false],
        adjustmentBasisPoints: 1000,
        roundToWholeCurrencyUnit: true,
      );
      expect(rounded.adjustedUnitPricesMinor, [200]);
    });

    test('rejects mismatched preview rows and reductions below zero', () {
      expect(
        () => engine.previewPriceAdjustment(
          unitPricesMinor: const [100],
          sectionHeaders: const [],
          adjustmentBasisPoints: 100,
        ),
        throwsArgumentError,
      );
      expect(
        () => engine.previewPriceAdjustment(
          unitPricesMinor: const [100],
          sectionHeaders: const [false],
          adjustmentBasisPoints: -10001,
        ),
        throwsRangeError,
      );
      expect(
        () => engine.previewPriceAdjustment(
          unitPricesMinor: const [-1],
          sectionHeaders: const [false],
          adjustmentBasisPoints: 100,
        ),
        throwsArgumentError,
      );
    });
  });
}
