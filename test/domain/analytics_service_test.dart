import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/domain/analytics_service.dart';

void main() {
  const service = AnalyticsService();
  final now = DateTime(2026, 5, 15, 12);

  AnalyticsDocument quote({
    required int id,
    required String currency,
    required String status,
    required int price,
  }) => AnalyticsDocument(
    id: id,
    documentType: 'quotation',
    status: status,
    currencyCode: currency,
    customerName: 'Test Customer',
    vatRateBasisPoints: 0,
    discountKind: 'none',
    discountValue: 0,
    lines: [
      AnalyticsLine(
        designation: 'Drilling',
        isSectionHeader: false,
        unitPriceMinor: price,
        quantityMilli: 1000,
      ),
    ],
  );

  AnalyticsDocument invoice({
    required int id,
    required String currency,
    required String customer,
    required int price,
    int? sourceQuoteId,
    String status = 'issued',
    String discountKind = 'none',
    int discountValue = 0,
  }) => AnalyticsDocument(
    id: id,
    documentType: 'invoice',
    status: status,
    currencyCode: currency,
    customerName: customer,
    vatRateBasisPoints: 0,
    discountKind: discountKind,
    discountValue: discountValue,
    sourceQuoteId: sourceQuoteId,
    lines: [
      AnalyticsLine(
        designation: 'Drilling',
        isSectionHeader: false,
        unitPriceMinor: price,
        quantityMilli: 1000,
      ),
    ],
  );

  test('keeps currencies separate and calculates sales, paid, outstanding and discounts', () {
    final report = service.calculate(
      now: now,
      documents: [
        quote(id: 1, currency: 'USD', status: 'accepted', price: 20000),
        quote(id: 2, currency: 'ZiG', status: 'accepted', price: 30000),
        quote(id: 3, currency: 'USD', status: 'draft', price: 99999),
        invoice(
          id: 10,
          currency: 'USD',
          customer: 'Alpha',
          price: 20000,
          sourceQuoteId: 1,
          discountKind: 'percent',
          discountValue: 1000,
        ),
        invoice(id: 11, currency: 'ZiG', customer: 'Beta', price: 30000),
        invoice(
          id: 12,
          currency: 'USD',
          customer: 'Void customer',
          price: 50000,
          status: 'void',
        ),
      ],
      payments: [
        AnalyticsPayment(
          invoiceId: 10,
          currencyCode: 'USD',
          amountMinor: 7000,
          paidAt: DateTime(2026, 5, 2),
          entryType: 'payment',
        ),
        AnalyticsPayment(
          invoiceId: 10,
          currencyCode: 'USD',
          amountMinor: 3000,
          paidAt: DateTime(2026, 4, 2),
          entryType: 'payment',
        ),
        AnalyticsPayment(
          invoiceId: 10,
          currencyCode: 'USD',
          amountMinor: 2000,
          paidAt: DateTime(2026, 5, 9),
          entryType: 'reversal',
        ),
      ],
    );

    expect(report.currencies.keys, ['USD', 'ZiG']);
    final usd = report.currencies['USD']!;
    final zig = report.currencies['ZiG']!;
    expect(usd.quotedMinor, 20000);
    expect(usd.invoicedMinor, 18000);
    expect(usd.collectedMinor, 8000);
    expect(usd.outstandingMinor, 10000);
    expect(usd.averageDiscountBasisPoints, 1000);
    expect(usd.bestSellingServices.single.amountMinor, 20000);
    expect(usd.topCustomers.single.label, 'Alpha');
    expect(usd.topCustomers.single.amountMinor, 8000);
    expect(
      usd.monthlyRevenue
          .singleWhere((m) => m.year == 2026 && m.month == 4)
          .amountMinor,
      3000,
    );
    expect(
      usd.monthlyRevenue
          .singleWhere((m) => m.year == 2026 && m.month == 5)
          .amountMinor,
      5000,
    );
    expect(zig.quotedMinor, 30000);
    expect(zig.invoicedMinor, 30000);
    expect(zig.outstandingMinor, 30000);
    expect(zig.collectedMinor, 0);
    expect(report.acceptedQuoteCount, 2);
    expect(report.convertedQuoteCount, 1);
    expect(report.quoteConversionBasisPoints, 5000);
  });

  test('uses zero-safe values when there are no records', () {
    final report = service.calculate(
      now: now,
      documents: const [],
      payments: const [],
    );
    expect(report.currencies, isEmpty);
    expect(report.quoteConversionBasisPoints, 0);
    expect(report.convertedQuoteCount, 0);
  });
}
