import 'pricing_engine.dart';

class AnalyticsLine {
  const AnalyticsLine({
    required this.designation,
    required this.isSectionHeader,
    this.unitPriceMinor,
    this.quantityMilli,
  });

  final String designation;
  final bool isSectionHeader;
  final int? unitPriceMinor;
  final int? quantityMilli;
}

class AnalyticsDocument {
  const AnalyticsDocument({
    required this.id,
    required this.documentType,
    required this.status,
    required this.currencyCode,
    required this.customerName,
    required this.vatRateBasisPoints,
    required this.discountKind,
    required this.discountValue,
    required this.lines,
    this.sourceQuoteId,
  });

  final int id;
  final String documentType;
  final String status;
  final String currencyCode;
  final String customerName;
  final int vatRateBasisPoints;
  final String discountKind;
  final int discountValue;
  final int? sourceQuoteId;
  final List<AnalyticsLine> lines;
}

class AnalyticsPayment {
  const AnalyticsPayment({
    required this.invoiceId,
    required this.currencyCode,
    required this.amountMinor,
    required this.paidAt,
    required this.entryType,
  });

  final int invoiceId;
  final String currencyCode;
  final int amountMinor;
  final DateTime paidAt;
  final String entryType;
}

class MonthlyRevenue {
  const MonthlyRevenue({
    required this.year,
    required this.month,
    required this.amountMinor,
  });
  final int year;
  final int month;
  final int amountMinor;
}

class AnalyticsRanking {
  const AnalyticsRanking({required this.label, required this.amountMinor});
  final String label;
  final int amountMinor;
}

class CurrencyAnalytics {
  const CurrencyAnalytics({
    required this.currencyCode,
    required this.quotedMinor,
    required this.invoicedMinor,
    required this.collectedMinor,
    required this.outstandingMinor,
    required this.monthlyRevenue,
    required this.topCustomers,
    required this.bestSellingServices,
    required this.averageDiscountBasisPoints,
    required this.discountedInvoiceCount,
  });

  final String currencyCode;
  final int quotedMinor;
  final int invoicedMinor;
  final int collectedMinor;
  final int outstandingMinor;
  final List<MonthlyRevenue> monthlyRevenue;
  final List<AnalyticsRanking> topCustomers;
  final List<AnalyticsRanking> bestSellingServices;
  final int averageDiscountBasisPoints;
  final int discountedInvoiceCount;
}

class AnalyticsReport {
  const AnalyticsReport({
    required this.currencies,
    required this.acceptedQuoteCount,
    required this.convertedQuoteCount,
    required this.quoteConversionBasisPoints,
  });

  final Map<String, CurrencyAnalytics> currencies;
  final int acceptedQuoteCount;
  final int convertedQuoteCount;
  final int quoteConversionBasisPoints;
}

/// Calculates business analytics using integer minor units and PricingEngine.
class AnalyticsService {
  const AnalyticsService();

  AnalyticsReport calculate({
    required List<AnalyticsDocument> documents,
    required List<AnalyticsPayment> payments,
    required DateTime now,
  }) {
    final quotes = documents
        .where((d) => d.documentType == 'quotation' && d.status != 'draft')
        .toList();
    final activeInvoices = documents
        .where((d) => d.documentType == 'invoice' && d.status != 'void')
        .toList();
    final invoiceById = {
      for (final invoice in documents.where((d) => d.documentType == 'invoice'))
        invoice.id: invoice,
    };
    final accepted = quotes.where((q) => q.status == 'accepted').toList();
    final convertedIds = documents
        .where((d) => d.documentType == 'invoice')
        .map((i) => i.sourceQuoteId)
        .whereType<int>()
        .toSet();
    final converted = accepted.where((q) => convertedIds.contains(q.id)).length;
    final conversionRate = accepted.isEmpty
        ? 0
        : roundHalfUp(converted * 10000, accepted.length);

    final currencies = <String>{
      ...quotes.map((d) => d.currencyCode),
      ...activeInvoices.map((d) => d.currencyCode),
      ...payments.map((p) => p.currencyCode),
    };
    final report = <String, CurrencyAnalytics>{};
    final firstMonth = DateTime(now.year, now.month - 11);
    for (final currency in currencies.toList()..sort()) {
      final currencyQuotes = quotes
          .where((d) => d.currencyCode == currency)
          .toList();
      final currencyInvoices = activeInvoices
          .where((d) => d.currencyCode == currency)
          .toList();
      final currencyPayments = payments
          .where((p) => p.currencyCode == currency)
          .toList();
      final monthly = <(int, int), int>{};
      for (var i = 0; i < 12; i++) {
        final month = DateTime(firstMonth.year, firstMonth.month + i);
        monthly[(month.year, month.month)] = 0;
      }
      for (final payment in currencyPayments) {
        final key = (payment.paidAt.year, payment.paidAt.month);
        if (!monthly.containsKey(key)) continue;
        final sign = payment.entryType == 'payment' ? 1 : -1;
        monthly[key] = monthly[key]! + sign * payment.amountMinor;
      }

      final customerTotals = <String, int>{};
      var collected = 0;
      for (final payment in currencyPayments) {
        collected += payment.entryType == 'payment'
            ? payment.amountMinor
            : -payment.amountMinor;
        final customer =
            invoiceById[payment.invoiceId]?.customerName ?? 'Unknown customer';
        customerTotals.update(
          customer,
          (value) =>
              value +
              (payment.entryType == 'payment'
                  ? payment.amountMinor
                  : -payment.amountMinor),
          ifAbsent: () => payment.entryType == 'payment'
              ? payment.amountMinor
              : -payment.amountMinor,
        );
      }

      var quoted = 0;
      for (final quote in currencyQuotes) {
        quoted += _price(quote).grandTotalMinor;
      }
      var invoiced = 0;
      var outstanding = 0;
      var discountRateSum = 0;
      var discountedCount = 0;
      final serviceTotals = <String, int>{};
      for (final invoice in currencyInvoices) {
        final result = _price(invoice);
        invoiced += result.grandTotalMinor;
        final paidForInvoice = currencyPayments
            .where((p) => p.invoiceId == invoice.id)
            .fold<int>(
              0,
              (sum, p) =>
                  sum +
                  (p.entryType == 'payment' ? p.amountMinor : -p.amountMinor),
            );
        outstanding += result.grandTotalMinor - paidForInvoice;
        if (result.subtotalMinor > 0) {
          discountRateSum += roundHalfUp(
            result.discountMinor * 10000,
            result.subtotalMinor,
          );
          discountedCount++;
        }
        for (var i = 0; i < invoice.lines.length; i++) {
          final line = invoice.lines[i];
          if (line.isSectionHeader || result.lineTotalsMinor[i] == 0) continue;
          serviceTotals.update(
            line.designation,
            (value) => value + result.lineTotalsMinor[i],
            ifAbsent: () => result.lineTotalsMinor[i],
          );
        }
      }
      List<AnalyticsRanking> ranking(Map<String, int> values) {
        final entries = values.entries.where((e) => e.value > 0).toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        return entries
            .take(5)
            .map((e) => AnalyticsRanking(label: e.key, amountMinor: e.value))
            .toList(growable: false);
      }

      report[currency] = CurrencyAnalytics(
        currencyCode: currency,
        quotedMinor: quoted,
        invoicedMinor: invoiced,
        collectedMinor: collected,
        outstandingMinor: outstanding,
        monthlyRevenue: [
          for (final e in monthly.entries)
            MonthlyRevenue(
              year: e.key.$1,
              month: e.key.$2,
              amountMinor: e.value,
            ),
        ],
        topCustomers: ranking(customerTotals),
        bestSellingServices: ranking(serviceTotals),
        averageDiscountBasisPoints: discountedCount == 0
            ? 0
            : roundHalfUp(discountRateSum, discountedCount),
        discountedInvoiceCount: discountedCount,
      );
    }
    return AnalyticsReport(
      currencies: Map.unmodifiable(report),
      acceptedQuoteCount: accepted.length,
      convertedQuoteCount: converted,
      quoteConversionBasisPoints: conversionRate,
    );
  }

  PricingResult _price(AnalyticsDocument document) =>
      const PricingEngine().calculate(
        lines: document.lines
            .map(
              (line) => PricingLine(
                isSectionHeader: line.isSectionHeader,
                unitPriceMinor: line.unitPriceMinor,
                quantityMilli: line.quantityMilli,
              ),
            )
            .toList(),
        vatRateBasisPoints: document.vatRateBasisPoints,
        discount: switch (document.discountKind) {
          'percent' => Discount.percent(document.discountValue),
          'fixed' => Discount.fixed(document.discountValue),
          _ => const Discount.none(),
        },
      );
}
