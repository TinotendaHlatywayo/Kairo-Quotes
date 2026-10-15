import 'package:drift/drift.dart';

import '../domain/pricing_engine.dart';
import 'app_database.dart';

class InvoiceRepository {
  const InvoiceRepository(this._db);
  final AppDatabase _db;

  Stream<List<DocumentData>> watchInvoices({
    String search = '',
    String status = 'all',
  }) =>
      (_db.select(_db.documents)
            ..where((d) => d.documentType.equals('invoice'))
            ..orderBy([(d) => OrderingTerm.desc(d.issuedAt)]))
          .watch()
          .map(
            (rows) => rows
                .where(
                  (d) =>
                      (status == 'all' || d.status == status) &&
                      (search.trim().isEmpty ||
                          d.customerNameSnapshot.toLowerCase().contains(
                            search.trim().toLowerCase(),
                          ) ||
                          (d.documentNumber ?? '').toLowerCase().contains(
                            search.trim().toLowerCase(),
                          )),
                )
                .toList(),
          );

  Future<DocumentData?> getInvoice(int id) async =>
      (_db.select(_db.documents)
            ..where((d) => d.id.equals(id) & d.documentType.equals('invoice')))
          .getSingleOrNull();
  Future<DocumentData?> invoiceForQuote(int quoteId) async => (_db.select(
    _db.documents,
  )..where((d) => d.sourceQuoteId.equals(quoteId))).getSingleOrNull();
  Future<List<DocumentLineData>> getLines(int id) =>
      (_db.select(_db.documentLines)
            ..where((l) => l.documentId.equals(id))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .get();
  Future<List<PaymentData>> getPayments(int id) =>
      (_db.select(_db.payments)
            ..where((p) => p.invoiceId.equals(id))
            ..orderBy([(p) => OrderingTerm.asc(p.paidAt)]))
          .get();

  Future<int> createFromAcceptedQuote(int quoteId) => _db.transaction(() async {
    final quote =
        await (_db.select(_db.documents)..where(
              (d) => d.id.equals(quoteId) & d.documentType.equals('quotation'),
            ))
            .getSingleOrNull();
    if (quote == null || quote.status != 'accepted') {
      throw StateError('Only accepted quotations can be invoiced.');
    }
    final existing = await (_db.select(
      _db.documents,
    )..where((d) => d.sourceQuoteId.equals(quoteId))).getSingleOrNull();
    if (existing != null) {
      throw StateError('This quotation already has an invoice.');
    }
    final number = await _nextNumber('invoice');
    final now = DateTime.now();
    final invoiceId = await _db
        .into(_db.documents)
        .insert(
          DocumentsCompanion.insert(
            documentType: 'invoice',
            status: 'issued',
            customerId: Value(quote.customerId),
            sourceQuoteId: Value(quote.id),
            currencyCode: quote.currencyCode,
            vatRateBasisPoints: Value(quote.vatRateBasisPoints),
            discountKind: Value(quote.discountKind),
            discountValue: Value(quote.discountValue),
            notes: Value(quote.notes),
            termsSnapshot: Value(quote.termsSnapshot),
            customerNameSnapshot: Value(quote.customerNameSnapshot),
            customerLocationSnapshot: Value(quote.customerLocationSnapshot),
            customerPhoneSnapshot: Value(quote.customerPhoneSnapshot),
            companyNameSnapshot: Value(quote.companyNameSnapshot),
            legalNameSnapshot: Value(quote.legalNameSnapshot),
            addressSnapshot: Value(quote.addressSnapshot),
            phoneNumbersSnapshot: Value(quote.phoneNumbersSnapshot),
            taglineSnapshot: Value(quote.taglineSnapshot),
            signatorySnapshot: Value(quote.signatorySnapshot),
            vatNumberSnapshot: Value(quote.vatNumberSnapshot),
            tinNumberSnapshot: Value(quote.tinNumberSnapshot),
            logoPathSnapshot: Value(quote.logoPathSnapshot),
            validityDays: Value(quote.validityDays),
            issuedAt: Value(now),
          ),
        );
    for (final line in await getLinesForQuote(quote.id)) {
      await _db
          .into(_db.documentLines)
          .insert(
            DocumentLinesCompanion.insert(
              documentId: invoiceId,
              sortOrder: line.sortOrder,
              isSectionHeader: Value(line.isSectionHeader),
              designation: line.designation,
              unit: Value(line.unit),
              unitPriceMinor: Value(line.unitPriceMinor),
              quantityMilli: Value(line.quantityMilli),
              costPriceMinor: Value(line.costPriceMinor),
            ),
          );
    }
    await (_db.update(_db.documents)..where((d) => d.id.equals(invoiceId)))
        .write(DocumentsCompanion(documentNumber: Value(number)));
    await _audit(invoiceId, 'issued', 'invoice', after: number, at: now);
    await _audit(quote.id, 'invoiced', 'quotation', after: number, at: now);
    return invoiceId;
  });

  /// Issues a replacement for a voided invoice without converting its quote again.
  Future<int> replaceVoidedInvoice(int oldInvoiceId) =>
      _db.transaction(() async {
        final old = await getInvoice(oldInvoiceId);
        if (old == null || old.status != 'void') {
          throw StateError('Only a voided invoice can be replaced.');
        }
        final oldLines = await getLines(oldInvoiceId);
        final now = DateTime.now();
        final number = await _nextNumber('invoice');
        final id = await _db
            .into(_db.documents)
            .insert(
              DocumentsCompanion.insert(
                documentType: 'invoice',
                status: 'issued',
                customerId: Value(old.customerId),
                replacesDocumentId: Value(old.id),
                currencyCode: old.currencyCode,
                vatRateBasisPoints: Value(old.vatRateBasisPoints),
                discountKind: Value(old.discountKind),
                discountValue: Value(old.discountValue),
                notes: Value(old.notes),
                termsSnapshot: Value(old.termsSnapshot),
                customerNameSnapshot: Value(old.customerNameSnapshot),
                customerLocationSnapshot: Value(old.customerLocationSnapshot),
                customerPhoneSnapshot: Value(old.customerPhoneSnapshot),
                companyNameSnapshot: Value(old.companyNameSnapshot),
                legalNameSnapshot: Value(old.legalNameSnapshot),
                addressSnapshot: Value(old.addressSnapshot),
                phoneNumbersSnapshot: Value(old.phoneNumbersSnapshot),
                taglineSnapshot: Value(old.taglineSnapshot),
                signatorySnapshot: Value(old.signatorySnapshot),
                vatNumberSnapshot: Value(old.vatNumberSnapshot),
                tinNumberSnapshot: Value(old.tinNumberSnapshot),
                logoPathSnapshot: Value(old.logoPathSnapshot),
                issuedAt: Value(now),
              ),
            );
        for (final line in oldLines) {
          await _db
              .into(_db.documentLines)
              .insert(
                DocumentLinesCompanion.insert(
                  documentId: id,
                  sortOrder: line.sortOrder,
                  isSectionHeader: Value(line.isSectionHeader),
                  designation: line.designation,
                  unit: Value(line.unit),
                  unitPriceMinor: Value(line.unitPriceMinor),
                  quantityMilli: Value(line.quantityMilli),
                  costPriceMinor: Value(line.costPriceMinor),
                ),
              );
        }
        await (_db.update(_db.documents)..where((d) => d.id.equals(id))).write(
          DocumentsCompanion(documentNumber: Value(number)),
        );
        await _audit(
          old.id,
          'replacement_issued',
          'invoice',
          after: number,
          at: now,
        );
        await _audit(
          id,
          'issued_as_replacement',
          'invoice',
          before: old.documentNumber,
          after: number,
          at: now,
        );
        return id;
      });

  Future<int> recordPayment(
    int invoiceId, {
    required int amountMinor,
    required String method,
    required DateTime paidAt,
    String note = '',
  }) => _recordEntry(
    invoiceId,
    amountMinor: amountMinor,
    method: method,
    paidAt: paidAt,
    note: note,
    reversalOf: null,
  );

  Future<int> reversePayment(
    int paymentId, {
    required String reason,
    DateTime? reversedAt,
  }) async => _db.transaction(() async {
    final original =
        await (_db.select(_db.payments)..where(
              (p) => p.id.equals(paymentId) & p.entryType.equals('payment'),
            ))
            .getSingleOrNull();
    if (original == null) throw StateError('Payment not found.');
    final existing = await (_db.select(
      _db.payments,
    )..where((p) => p.reversesPaymentId.equals(paymentId))).getSingleOrNull();
    if (existing != null) {
      throw StateError('This payment has already been reversed.');
    }
    if (reason.trim().isEmpty) throw ArgumentError('Enter a reversal reason.');
    return _recordEntry(
      original.invoiceId,
      amountMinor: original.amountMinor,
      method: original.method,
      paidAt: reversedAt ?? DateTime.now(),
      note: reason.trim(),
      reversalOf: original,
    );
  });

  Future<int> _recordEntry(
    int invoiceId, {
    required int amountMinor,
    required String method,
    required DateTime paidAt,
    required String note,
    required PaymentData? reversalOf,
  }) => _db.transaction(() async {
    if (amountMinor <= 0) {
      throw ArgumentError('Amount must be greater than zero.');
    }
    final invoice = await getInvoice(invoiceId);
    if (invoice == null || invoice.status == 'void') {
      throw StateError('Invoice is unavailable.');
    }
    final lines = await getLines(invoiceId);
    final total = _total(invoice, lines);
    final payments = await getPayments(invoiceId);
    final paid = payments.fold<int>(
      0,
      (sum, p) =>
          sum + (p.entryType == 'payment' ? p.amountMinor : -p.amountMinor),
    );
    if (reversalOf == null && amountMinor > total - paid) {
      throw StateError('Payment exceeds the outstanding balance.');
    }
    if (reversalOf != null && reversalOf.invoiceId != invoiceId) {
      throw StateError('Payment belongs to another invoice.');
    }
    final type = reversalOf == null ? 'payment' : 'reversal';
    final receiptNumber = await _nextNumber('receipt');
    final receiptId = await _db
        .into(_db.documents)
        .insert(
          DocumentsCompanion.insert(
            documentType: 'receipt',
            status: 'issued',
            customerId: Value(invoice.customerId),
            currencyCode: invoice.currencyCode,
            vatRateBasisPoints: const Value(0),
            discountKind: const Value('none'),
            discountValue: const Value(0),
            notes: Value(
              type == 'reversal' ? 'PAYMENT REVERSAL' : 'PAYMENT RECEIPT',
            ),
            termsSnapshot: Value(
              'Invoice: ${invoice.documentNumber ?? ''}\nMethod: $method\nDate: ${paidAt.toIso8601String()}\n${note.trim()}',
            ),
            customerNameSnapshot: Value(invoice.customerNameSnapshot),
            customerLocationSnapshot: Value(invoice.customerLocationSnapshot),
            customerPhoneSnapshot: Value(invoice.customerPhoneSnapshot),
            companyNameSnapshot: Value(invoice.companyNameSnapshot),
            legalNameSnapshot: Value(invoice.legalNameSnapshot),
            addressSnapshot: Value(invoice.addressSnapshot),
            phoneNumbersSnapshot: Value(invoice.phoneNumbersSnapshot),
            taglineSnapshot: Value(invoice.taglineSnapshot),
            signatorySnapshot: Value(invoice.signatorySnapshot),
            vatNumberSnapshot: Value(invoice.vatNumberSnapshot),
            tinNumberSnapshot: Value(invoice.tinNumberSnapshot),
            logoPathSnapshot: Value(invoice.logoPathSnapshot),
            issuedAt: Value(paidAt),
          ),
        );
    await _db
        .into(_db.documentLines)
        .insert(
          DocumentLinesCompanion.insert(
            documentId: receiptId,
            sortOrder: 0,
            designation: type == 'reversal'
                ? 'Payment reversal ($method)'
                : 'Payment received ($method)',
            unitPriceMinor: Value(amountMinor),
            quantityMilli: const Value(1000),
          ),
        );
    await (_db.update(_db.documents)..where((d) => d.id.equals(receiptId)))
        .write(DocumentsCompanion(documentNumber: Value(receiptNumber)));
    final paymentId = await _db
        .into(_db.payments)
        .insert(
          PaymentsCompanion.insert(
            invoiceId: invoiceId,
            currencyCode: invoice.currencyCode,
            amountMinor: amountMinor,
            method: method,
            paidAt: paidAt,
            entryType: Value(type),
            reversesPaymentId: Value(reversalOf?.id),
            receiptDocumentId: Value(receiptId),
            note: Value(note.trim()),
          ),
        );
    final updatedPaid = paid + (type == 'payment' ? amountMinor : -amountMinor);
    final status = updatedPaid == 0
        ? 'issued'
        : (updatedPaid >= total ? 'paid' : 'partially_paid');
    await (_db.update(
      _db.documents,
    )..where((d) => d.id.equals(invoiceId))).write(
      DocumentsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _audit(
      invoiceId,
      type,
      'invoice',
      before: '$paid',
      after: '$updatedPaid; receipt $receiptNumber; $note',
    );
    return paymentId;
  });

  Future<void> voidInvoice(int invoiceId, String reason) async {
    if (reason.trim().isEmpty) throw ArgumentError('Enter a void reason.');
    await _db.transaction(() async {
      final invoice = await getInvoice(invoiceId);
      if (invoice == null || invoice.status == 'void') {
        throw StateError('Invoice is unavailable.');
      }
      final paid = (await getPayments(invoiceId)).fold<int>(
        0,
        (sum, p) =>
            sum + (p.entryType == 'payment' ? p.amountMinor : -p.amountMinor),
      );
      if (paid != 0) {
        throw StateError('Reverse all payments before voiding this invoice.');
      }
      final now = DateTime.now();
      await (_db.update(
        _db.documents,
      )..where((d) => d.id.equals(invoiceId))).write(
        DocumentsCompanion(
          status: const Value('void'),
          voidedAt: Value(now),
          voidReason: Value(reason.trim()),
          updatedAt: Value(now),
        ),
      );
      await _audit(
        invoiceId,
        'voided',
        'invoice',
        before: invoice.status,
        after: reason.trim(),
        at: now,
      );
    });
  }

  int calculateTotal(DocumentData invoice, List<DocumentLineData> lines) =>
      _total(invoice, lines);
  int _total(DocumentData invoice, List<DocumentLineData> lines) =>
      const PricingEngine()
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

  Future<List<DocumentLineData>> getLinesForQuote(int id) =>
      (_db.select(_db.documentLines)
            ..where((l) => l.documentId.equals(id))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .get();
  Future<String> _nextNumber(String type) async {
    final seq = await (_db.select(
      _db.numberSequences,
    )..where((s) => s.documentType.equals(type))).getSingleOrNull();
    if (seq == null) {
      throw StateError(
        'Configure the $type number sequence in company settings.',
      );
    }
    await (_db.update(_db.numberSequences)
          ..where((s) => s.documentType.equals(type)))
        .write(NumberSequencesCompanion(nextNumber: Value(seq.nextNumber + 1)));
    return '${seq.prefix}${seq.nextNumber.toString().padLeft(seq.padding, '0')}';
  }

  Future<void> _audit(
    int id,
    String action,
    String type, {
    String? before,
    String? after,
    DateTime? at,
  }) => _db
      .into(_db.auditLogs)
      .insert(
        AuditLogsCompanion.insert(
          entityType: type,
          entityId: id,
          action: action,
          occurredAt: Value(at ?? DateTime.now()),
          beforeSummary: Value(before),
          afterSummary: Value(after),
        ),
      );
}
