import 'package:drift/drift.dart';

import '../domain/pricing_engine.dart';
import 'app_database.dart';

class DocumentFilters {
  const DocumentFilters({
    this.search = '',
    this.customerId,
    this.documentType = 'all',
    this.status = 'all',
    this.from,
    this.through,
  });

  final String search;
  final int? customerId;
  final String documentType;
  final String status;
  final DateTime? from;
  final DateTime? through;
}

class CustomerPaymentHistory {
  const CustomerPaymentHistory({
    required this.payment,
    required this.invoiceNumber,
    required this.receiptNumber,
  });

  final PaymentData payment;
  final String? invoiceNumber;
  final String? receiptNumber;
}

class CustomerHistoryData {
  const CustomerHistoryData({
    required this.customer,
    required this.quotations,
    required this.invoices,
    required this.payments,
    required this.outstandingByCurrency,
  });

  final CustomerData customer;
  final List<DocumentData> quotations;
  final List<DocumentData> invoices;
  final List<CustomerPaymentHistory> payments;
  final Map<String, int> outstandingByCurrency;
}

class RecordsRepository {
  const RecordsRepository(this._db);
  final AppDatabase _db;

  Stream<List<DocumentData>> watchDocuments(DocumentFilters filters) =>
      (_db.select(
        _db.documents,
      )..orderBy([(d) => OrderingTerm.desc(d.createdAt)])).watch().map((rows) {
        final query = filters.search.trim().toLowerCase();
        final from = filters.from == null ? null : _day(filters.from!);
        final throughExclusive = filters.through == null
            ? null
            : _day(filters.through!).add(const Duration(days: 1));
        final results = rows.where((document) {
          if (!const [
            'quotation',
            'invoice',
            'receipt',
          ].contains(document.documentType)) {
            return false;
          }
          if (filters.documentType != 'all' &&
              document.documentType != filters.documentType) {
            return false;
          }
          if (filters.status != 'all' && document.status != filters.status) {
            return false;
          }
          if (filters.customerId != null &&
              document.customerId != filters.customerId) {
            return false;
          }
          final date = document.issuedAt ?? document.createdAt;
          if (from != null && date.isBefore(from)) return false;
          if (throughExclusive != null && !date.isBefore(throughExclusive)) {
            return false;
          }
          if (query.isEmpty) return true;
          return document.customerNameSnapshot.toLowerCase().contains(query) ||
              (document.documentNumber?.toLowerCase().contains(query) ??
                  false) ||
              document.status.toLowerCase().contains(query) ||
              document.currencyCode.toLowerCase().contains(query);
        }).toList();
        results.sort(
          (a, b) =>
              (b.issuedAt ?? b.createdAt).compareTo(a.issuedAt ?? a.createdAt),
        );
        return results;
      });

  Future<CustomerHistoryData> getCustomerHistory(int customerId) async {
    final customer = await (_db.select(
      _db.customers,
    )..where((c) => c.id.equals(customerId))).getSingleOrNull();
    if (customer == null) throw StateError('Customer no longer exists.');
    final documents =
        await (_db.select(_db.documents)
              ..where((d) => d.customerId.equals(customerId))
              ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
            .get();
    final quotations = documents
        .where((d) => d.documentType == 'quotation')
        .toList(growable: false);
    final invoices = documents
        .where((d) => d.documentType == 'invoice')
        .toList(growable: false);
    final invoiceIds = invoices.map((i) => i.id).toList();
    final paymentRows = invoiceIds.isEmpty
        ? <PaymentData>[]
        : await (_db.select(_db.payments)
                ..where((p) => p.invoiceId.isIn(invoiceIds))
                ..orderBy([(p) => OrderingTerm.desc(p.paidAt)]))
              .get();
    final invoiceById = {for (final invoice in invoices) invoice.id: invoice};
    final receiptIds = paymentRows
        .map((p) => p.receiptDocumentId)
        .whereType<int>()
        .toSet();
    final receipts = receiptIds.isEmpty
        ? <DocumentData>[]
        : await (_db.select(
            _db.documents,
          )..where((d) => d.id.isIn(receiptIds.toList()))).get();
    final receiptById = {for (final receipt in receipts) receipt.id: receipt};
    final balances = <String, int>{};
    for (final invoice in invoices.where((i) => i.status != 'void')) {
      final lines = await (_db.select(
        _db.documentLines,
      )..where((line) => line.documentId.equals(invoice.id))).get();
      final total = const PricingEngine()
          .calculate(
            lines: lines
                .map(
                  (l) => PricingLine(
                    isSectionHeader: l.isSectionHeader,
                    unitPriceMinor: l.unitPriceMinor,
                    quantityMilli: l.quantityMilli,
                  ),
                )
                .toList(),
            vatRateBasisPoints: invoice.vatRateBasisPoints,
            discount: switch (invoice.discountKind) {
              'percent' => Discount.percent(invoice.discountValue),
              'fixed' => Discount.fixed(invoice.discountValue),
              _ => const Discount.none(),
            },
          )
          .grandTotalMinor;
      final paid = paymentRows
          .where((p) => p.invoiceId == invoice.id)
          .fold<int>(
            0,
            (sum, payment) =>
                sum +
                (payment.entryType == 'payment'
                    ? payment.amountMinor
                    : -payment.amountMinor),
          );
      balances.update(
        invoice.currencyCode,
        (value) => value + total - paid,
        ifAbsent: () => total - paid,
      );
    }
    return CustomerHistoryData(
      customer: customer,
      quotations: quotations,
      invoices: invoices,
      payments: paymentRows
          .map(
            (payment) => CustomerPaymentHistory(
              payment: payment,
              invoiceNumber: invoiceById[payment.invoiceId]?.documentNumber,
              receiptNumber:
                  receiptById[payment.receiptDocumentId]?.documentNumber,
            ),
          )
          .toList(growable: false),
      outstandingByCurrency: Map.unmodifiable(balances),
    );
  }

  static DateTime _day(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
