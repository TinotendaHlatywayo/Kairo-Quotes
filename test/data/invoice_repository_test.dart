import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/invoice_repository.dart';
import 'package:quotes/data/quote_repository.dart';

void main() {
  late AppDatabase db;
  late QuoteRepository quotes;
  late InvoiceRepository invoices;
  late int customerId;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory());
    quotes = QuoteRepository(db);
    invoices = InvoiceRepository(db);
    await db
        .into(db.companyProfiles)
        .insert(
          CompanyProfilesCompanion.insert(
            id: const Value(1),
            companyName: 'Kairo',
          ),
        );
    customerId = await db
        .into(db.customers)
        .insert(CustomersCompanion.insert(name: 'Customer'));
    for (final (type, prefix) in [
      ('quotation', 'QT-'),
      ('invoice', 'INV-'),
      ('receipt', 'RC-'),
    ]) {
      await db
          .into(db.numberSequences)
          .insert(
            NumberSequencesCompanion.insert(
              documentType: type,
              prefix: prefix,
              padding: const Value(3),
            ),
          );
    }
  });
  tearDown(() async => db.close());

  Future<int> acceptedQuote() async {
    final id = await quotes.saveAndIssue(
      QuoteDraft(
        customerId: customerId,
        currencyCode: 'USD',
        vatRateBasisPoints: 1500,
        discountKind: 'none',
        discountValue: 0,
        validityDays: 30,
        terms: 'Payment due',
        lines: const [
          QuoteLineDraft(
            designation: 'Drilling',
            unit: 'm',
            unitPriceMinor: 10000,
            quantityMilli: 2000,
          ),
        ],
      ),
    );
    await quotes.accept(id);
    return id;
  }

  test(
    'only accepted quotes convert once and preserve their financial snapshot',
    () async {
      final qid = await acceptedQuote();
      final id = await invoices.createFromAcceptedQuote(qid);
      final invoice = (await invoices.getInvoice(id))!;
      expect(invoice.documentNumber, 'INV-001');
      expect(invoice.sourceQuoteId, qid);
      expect(invoice.customerNameSnapshot, 'Customer');
      expect(
        invoices.calculateTotal(invoice, await invoices.getLines(id)),
        23000,
      );
      await expectLater(
        invoices.createFromAcceptedQuote(qid),
        throwsStateError,
      );
      expect(
        (await db.select(db.numberSequences).get())
            .singleWhere((s) => s.documentType == 'invoice')
            .nextNumber,
        2,
      );
    },
  );

  test(
    'partial and full payments issue unique receipts and block overpayment',
    () async {
      final qid = await acceptedQuote();
      final id = await invoices.createFromAcceptedQuote(qid);
      final day = DateTime(2026, 10, 14);
      final first = await invoices.recordPayment(
        id,
        amountMinor: 10000,
        method: 'Cash',
        paidAt: day,
      );
      expect((await invoices.getInvoice(id))!.status, 'partially_paid');
      await expectLater(
        invoices.recordPayment(
          id,
          amountMinor: 13001,
          method: 'Cash',
          paidAt: day,
        ),
        throwsStateError,
      );
      await invoices.recordPayment(
        id,
        amountMinor: 13000,
        method: 'EcoCash',
        paidAt: day,
      );
      expect((await invoices.getInvoice(id))!.status, 'paid');
      final payments = await invoices.getPayments(id);
      expect(payments, hasLength(2));
      expect(payments.map((p) => p.receiptDocumentId).toSet(), hasLength(2));
      final receipt =
          (await (db.select(db.documents)
                ..where((d) => d.id.equals(payments.first.receiptDocumentId!)))
              .getSingle());
      expect(receipt.documentNumber, 'RC-001');
      await expectLater(
        db
            .update(db.payments)
            .write(const PaymentsCompanion(note: Value('edited'))),
        throwsA(isA<Exception>()),
      );
      expect(first, payments.first.id);
    },
  );

  test('payment can be reversed once, balance and status are derived, void requires zero balance', () async {
    final qid = await acceptedQuote();
    final id = await invoices.createFromAcceptedQuote(qid);
    final paymentId = await invoices.recordPayment(
      id,
      amountMinor: 23000,
      method: 'Bank transfer',
      paidAt: DateTime(2026, 10, 14),
    );
    await expectLater(invoices.voidInvoice(id, 'Mistake'), throwsStateError);
    await invoices.reversePayment(paymentId, reason: 'Bank transfer returned');
    expect((await invoices.getInvoice(id))!.status, 'issued');
    final history = await invoices.getPayments(id);
    expect(history.map((p) => p.entryType), ['payment', 'reversal']);
    expect(history.last.amountMinor, history.first.amountMinor);
    expect(
      history.last.receiptDocumentId,
      isNot(history.first.receiptDocumentId),
    );
    await expectLater(
      invoices.reversePayment(paymentId, reason: 'Again'),
      throwsStateError,
    );
    await invoices.voidInvoice(id, 'Invoice entered in error');
    expect((await invoices.getInvoice(id))!.status, 'void');
    await expectLater(
      invoices.recordPayment(
        id,
        amountMinor: 100,
        method: 'Cash',
        paidAt: DateTime.now(),
      ),
      throwsStateError,
    );
    final replacementId = await invoices.replaceVoidedInvoice(id);
    final replacement = (await invoices.getInvoice(replacementId))!;
    expect(replacement.replacesDocumentId, id);
    expect(replacement.sourceQuoteId, isNull);
    expect(replacement.documentNumber, 'INV-002');
  });

  test(
    'unaccepted quotes and blank void or reversal reasons are rejected',
    () async {
      final id = await quotes.saveAndIssue(
        QuoteDraft(
          customerId: customerId,
          currencyCode: 'USD',
          vatRateBasisPoints: 0,
          discountKind: 'none',
          discountValue: 0,
          validityDays: 30,
          terms: '',
          lines: const [
            QuoteLineDraft(
              designation: 'Work',
              unitPriceMinor: 100,
              quantityMilli: 1000,
            ),
          ],
        ),
      );
      await expectLater(invoices.createFromAcceptedQuote(id), throwsStateError);
      await quotes.accept(id);
      final invoice = await invoices.createFromAcceptedQuote(id);
      await expectLater(
        invoices.voidInvoice(invoice, '  '),
        throwsArgumentError,
      );
    },
  );
}
