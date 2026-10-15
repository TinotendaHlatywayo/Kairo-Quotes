import 'pricing_engine.dart';

class ProfitLine {
  const ProfitLine({
    required this.unitPriceMinor,
    required this.quantityMilli,
    required this.isSectionHeader,
    this.costPriceMinor,
  });

  final int? unitPriceMinor;
  final int? quantityMilli;
  final bool isSectionHeader;
  final int? costPriceMinor;
}

class ProfitInvoice {
  const ProfitInvoice({
    required this.id,
    required this.currencyCode,
    required this.status,
    required this.date,
    required this.vatRateBasisPoints,
    required this.discountKind,
    required this.discountValue,
    required this.lines,
  });

  final int id;
  final String currencyCode;
  final String status;
  final DateTime date;
  final int vatRateBasisPoints;
  final String discountKind;
  final int discountValue;
  final List<ProfitLine> lines;
}

class ProfitExpense {
  const ProfitExpense({
    required this.id,
    required this.date,
    required this.amountMinor,
    required this.currencyCode,
    required this.status,
    this.linkedInvoiceId,
    this.reversalOfId,
    this.isOverhead = false,
  });

  final int id;
  final DateTime date;
  final int amountMinor;
  final String currencyCode;
  final String status;
  final int? linkedInvoiceId;
  final int? reversalOfId;
  final bool isOverhead;
}

class ProfitPayment {
  const ProfitPayment({
    required this.invoiceId,
    required this.amountMinor,
    required this.currencyCode,
    required this.paidAt,
    required this.entryType,
  });

  final int invoiceId;
  final int amountMinor;
  final String currencyCode;
  final DateTime paidAt;
  final String entryType;
}

enum ProfitMode { accrual, cash }

class JobProfit {
  const JobProfit({
    required this.invoiceId,
    required this.currencyCode,
    required this.revenueMinor,
    required this.costMinor,
    required this.profitMinor,
    required this.marginBasisPoints,
  });

  final int invoiceId;
  final String currencyCode;
  final int revenueMinor;
  final int costMinor;
  final int profitMinor;
  /// Null for zero revenue; otherwise 10000 basis points represents 100%.
  final int? marginBasisPoints;
}

class CurrencyProfit {
  const CurrencyProfit({
    required this.currencyCode,
    required this.revenueMinor,
    required this.expenseMinor,
    required this.netProfitMinor,
    required this.jobProfits,
  });

  final String currencyCode;
  /// Ex-VAT invoice revenue in accrual mode, or ex-VAT collections in cash mode.
  final int revenueMinor;
  final int expenseMinor;
  final int netProfitMinor;
  final Map<int, JobProfit> jobProfits;
}

class ProfitReport {
  const ProfitReport({required this.mode, required this.currencies});

  final ProfitMode mode;
  final Map<String, CurrencyProfit> currencies;
}

class QuoteProfitEstimate {
  const QuoteProfitEstimate({
    required this.currencyCode,
    required this.revenueMinor,
    required this.knownCostMinor,
    required this.profitMinor,
    required this.marginBasisPoints,
    required this.isPartial,
  });

  final String currencyCode;
  final int revenueMinor;
  final int knownCostMinor;
  final int profitMinor;
  final int? marginBasisPoints;
  final bool isPartial;
}

/// The sole domain calculation service for estimated and realized profit.
/// All values are integer minor units; date boundaries use local calendar days.
class ProfitService {
  const ProfitService({this.pricingEngine = const PricingEngine()});

  final PricingEngine pricingEngine;

  QuoteProfitEstimate estimateQuote({
    required String currencyCode,
    required List<ProfitLine> lines,
    required int vatRateBasisPoints,
    required String discountKind,
    required int discountValue,
  }) {
    final price = _price(
      lines: lines,
      vatRateBasisPoints: vatRateBasisPoints,
      discountKind: discountKind,
      discountValue: discountValue,
    );
    var knownCost = 0;
    var partial = false;
    for (final line in lines) {
      if (line.isSectionHeader) continue;
      final cost = line.costPriceMinor;
      final quantity = line.quantityMilli;
      if (cost == null) {
        partial = true;
        continue;
      }
      if (cost < 0 || quantity == null || quantity < 0) {
        throw ArgumentError('Quote costs and quantities must be non-negative.');
      }
      knownCost += roundHalfUp(
        cost * quantity,
        PricingEngine.quantityScale,
      );
    }
    final profit = price.taxableMinor - knownCost;
    return QuoteProfitEstimate(
      currencyCode: currencyCode,
      revenueMinor: price.taxableMinor,
      knownCostMinor: knownCost,
      profitMinor: profit,
      marginBasisPoints: price.taxableMinor == 0
          ? null
          : roundHalfUp(profit * 10000, price.taxableMinor),
      isPartial: partial,
    );
  }

  ProfitReport calculate({
    required List<ProfitInvoice> invoices,
    required List<ProfitExpense> expenses,
    required List<ProfitPayment> payments,
    required DateTime from,
    required DateTime through,
    required ProfitMode mode,
  }) {
    if (_dayKey(through) < _dayKey(from)) {
      throw ArgumentError('The end date must not be before the start date.');
    }
    final activeInvoices = {
      for (final invoice in invoices)
        if (invoice.status != 'void' && invoice.status != 'draft') invoice.id: invoice,
    };
    final prices = <int, PricingResult>{
      for (final invoice in activeInvoices.values)
        invoice.id: _price(
          lines: invoice.lines,
          vatRateBasisPoints: invoice.vatRateBasisPoints,
          discountKind: invoice.discountKind,
          discountValue: invoice.discountValue,
        ),
    };
    final linkedCosts = <int, int>{};
    for (final expense in expenses) {
      if (expense.amountMinor <= 0) {
        throw ArgumentError('Expense amounts must be positive minor-unit values.');
      }
      if (expense.status != 'Active') continue;
      final invoiceId = expense.linkedInvoiceId;
      if (invoiceId != null) {
        final invoice = activeInvoices[invoiceId];
        if (invoice == null) continue; // A void invoice and its job costs are excluded.
        if (invoice.currencyCode != expense.currencyCode) {
          throw ArgumentError('A linked expense must use its invoice currency.');
        }
        linkedCosts.update(invoiceId, (amount) => amount + expense.amountMinor,
            ifAbsent: () => expense.amountMinor);
      }
    }

    final jobProfits = <int, JobProfit>{};
    for (final invoice in activeInvoices.values) {
      final price = prices[invoice.id]!;
      final cost = linkedCosts[invoice.id] ?? 0;
      final profit = price.taxableMinor - cost;
      jobProfits[invoice.id] = JobProfit(
        invoiceId: invoice.id,
        currencyCode: invoice.currencyCode,
        revenueMinor: price.taxableMinor,
        costMinor: cost,
        profitMinor: profit,
        marginBasisPoints: price.taxableMinor == 0
            ? null
            : roundHalfUp(profit * 10000, price.taxableMinor),
      );
    }

    final revenues = <String, int>{};
    final expensesByCurrency = <String, int>{};
    if (mode == ProfitMode.accrual) {
      for (final invoice in activeInvoices.values) {
        if (_within(invoice.date, from, through)) {
          revenues.update(invoice.currencyCode,
              (value) => value + prices[invoice.id]!.taxableMinor,
              ifAbsent: () => prices[invoice.id]!.taxableMinor);
          expensesByCurrency.update(invoice.currencyCode,
              (value) => value + (linkedCosts[invoice.id] ?? 0),
              ifAbsent: () => linkedCosts[invoice.id] ?? 0);
        }
      }
      for (final expense in expenses) {
        if (expense.status == 'Active' &&
            expense.linkedInvoiceId == null &&
            _within(expense.date, from, through)) {
          expensesByCurrency.update(expense.currencyCode,
              (value) => value + expense.amountMinor,
              ifAbsent: () => expense.amountMinor);
        }
      }
    } else {
      for (final payment in payments) {
        if (!_within(payment.paidAt, from, through)) continue;
        if (payment.entryType != 'payment' && payment.entryType != 'reversal') {
          throw ArgumentError('Unsupported payment entry type: ${payment.entryType}');
        }
        final invoice = activeInvoices[payment.invoiceId];
        if (invoice == null) continue;
        if (invoice.currencyCode != payment.currencyCode) {
          throw ArgumentError('A payment must use its invoice currency.');
        }
        final price = prices[invoice.id]!;
        final exVat = price.grandTotalMinor == 0
            ? 0
            : roundHalfUp(
                payment.amountMinor * price.taxableMinor,
                price.grandTotalMinor,
              );
        final sign = payment.entryType == 'payment' ? 1 : -1;
        revenues.update(payment.currencyCode,
            (value) => value + sign * exVat,
            ifAbsent: () => sign * exVat);
      }
      for (final expense in expenses) {
        if (expense.status != 'Active' || !_within(expense.date, from, through)) {
          continue;
        }
        if (expense.linkedInvoiceId case final invoiceId?) {
          final invoice = activeInvoices[invoiceId];
          if (invoice == null) continue;
          if (invoice.currencyCode != expense.currencyCode) {
            throw ArgumentError('A linked expense must use its invoice currency.');
          }
        }
        expensesByCurrency.update(expense.currencyCode,
            (value) => value + expense.amountMinor,
            ifAbsent: () => expense.amountMinor);
      }
    }

    final currencies = <String>{
      ...revenues.keys,
      ...expensesByCurrency.keys,
      ...jobProfits.values.map((job) => job.currencyCode),
    }.toList()..sort();
    return ProfitReport(
      mode: mode,
      currencies: Map.unmodifiable({
        for (final currency in currencies)
          currency: CurrencyProfit(
            currencyCode: currency,
            revenueMinor: revenues[currency] ?? 0,
            expenseMinor: expensesByCurrency[currency] ?? 0,
            netProfitMinor: (revenues[currency] ?? 0) -
                (expensesByCurrency[currency] ?? 0),
            jobProfits: Map.unmodifiable({
              for (final entry in jobProfits.entries)
                if (entry.value.currencyCode == currency) entry.key: entry.value,
            }),
          ),
      }),
    );
  }

  PricingResult _price({
    required List<ProfitLine> lines,
    required int vatRateBasisPoints,
    required String discountKind,
    required int discountValue,
  }) => pricingEngine.calculate(
    lines: lines
        .map((line) => PricingLine(
              unitPriceMinor: line.unitPriceMinor,
              quantityMilli: line.quantityMilli,
              isSectionHeader: line.isSectionHeader,
            ))
        .toList(growable: false),
    vatRateBasisPoints: vatRateBasisPoints,
    discount: switch (discountKind) {
      'none' => const Discount.none(),
      'percent' => Discount.percent(discountValue),
      'fixed' => Discount.fixed(discountValue),
      _ => throw ArgumentError('Unsupported discount kind: $discountKind'),
    },
  );

  static bool _within(DateTime value, DateTime from, DateTime through) {
    final key = _dayKey(value);
    return key >= _dayKey(from) && key <= _dayKey(through);
  }

  static int _dayKey(DateTime date) =>
      date.year * 10000 + date.month * 100 + date.day;
}
