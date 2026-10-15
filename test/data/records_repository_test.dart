import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/invoice_repository.dart';
import 'package:quotes/data/quote_repository.dart';
import 'package:quotes/data/records_repository.dart';

void main() {
  late AppDatabase db;
  late RecordsRepository records;
  late QuoteRepository quotes;
  late InvoiceRepository invoices;
  late int customerId;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory());
    records = RecordsRepository(db);
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
        .insert(
          CustomersCompanion.insert(
            name: 'Test Customer',
            location: const Value('Harare'),
          ),
        );
    for (final (type, prefix) in [
      ('quotation', 'QT-'),
      ('invoice', 'INV-'),
      ('receipt', 'RC-'),
    ]) {
      await db
          .into(db.numberSequences)
          .insert(
            NumberSequencesCompanion.insert(documentType: type, prefix: prefix),
          );
    }
  });
  tearDown(() async => db.close());

  Future<(int quoteId, int invoiceId)> createRecords() async {
    final quoteId = await quotes.saveAndIssue(
      QuoteDraft(
        customerId: customerId,
        currencyCode: 'USD',
        vatRateBasisPoints: 1500,
        discountKind: 'none',
        discountValue: 0,
        validityDays: 30,
        terms: '',
        lines: const [
          QuoteLineDraft(
            designation: 'Drilling',
            unitPriceMinor: 10000,
            quantityMilli: 2000,
          ),
        ],
      ),
    );
    await quotes.accept(quoteId);
    final invoiceId = await invoices.createFromAcceptedQuote(quoteId);
    await invoices.recordPayment(
      invoiceId,
      amountMinor: 5000,
      method: 'Cash',
      paidAt: DateTime.now(),
    );
    return (quoteId, invoiceId);
  }

  test(
    'unified document list filters by type, status, customer, search and date',
    () async {
      await createRecords();
      final all = await records.watchDocuments(const DocumentFilters()).first;
      expect(
        all.map((d) => d.documentType),
        containsAll(['quotation', 'invoice', 'receipt']),
      );
      expect(
        await records
            .watchDocuments(DocumentFilters(documentType: 'invoice'))
            .first,
        hasLength(1),
      );
      expect(
        await records.watchDocuments(DocumentFilters(status: 'accepted')).first,
        hasLength(1),
      );
      expect(
        await records
            .watchDocuments(DocumentFilters(customerId: customerId))
            .first,
        hasLength(3),
      );
      expect(
        await records
            .watchDocuments(const DocumentFilters(search: 'test customer'))
            .first,
        hasLength(3),
      );
      expect(
        await records
            .watchDocuments(
              DocumentFilters(
                from: DateTime.now().add(const Duration(days: 1)),
              ),
            )
            .first,
        isEmpty,
      );
    },
  );

  test(
    'customer history includes quote, invoice, payments and currency balance',
    () async {
      await createRecords();
      final history = await records.getCustomerHistory(customerId);
      expect(history.quotations, hasLength(1));
      expect(history.invoices, hasLength(1));
      expect(history.payments, hasLength(1));
      expect(history.payments.single.invoiceNumber, 'INV-0001');
      expect(history.payments.single.receiptNumber, 'RC-0001');
      expect(history.outstandingByCurrency['USD'], 18000);
    },
  );
}
