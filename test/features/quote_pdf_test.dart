import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/quote_repository.dart';
import 'package:quotes/features/quotes/quote_pdf.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  test('builds a styled quotation PDF with section and totals data', () async {
    await db
        .into(db.companyProfiles)
        .insert(
          CompanyProfilesCompanion.insert(
            id: const Value(1),
            companyName: 'EM Borehole Drilling',
          ),
        );
    final customerId = await db
        .into(db.customers)
        .insert(
          CustomersCompanion.insert(
            name: 'Test Customer',
            location: const Value('Harare'),
          ),
        );
    final id = await QuoteRepository(db).saveAndIssue(
      QuoteDraft(
        customerId: customerId,
        currencyCode: 'USD',
        vatRateBasisPoints: 1500,
        discountKind: 'none',
        discountValue: 0,
        validityDays: 30,
        terms: 'Payment terms. Work starts after site access is confirmed.',
        lines: [
          const QuoteLineDraft(
            designation: 'BOREHOLE WORK',
            isSectionHeader: true,
          ),
          const QuoteLineDraft(
            designation: 'Drilling to required depth',
            unit: 'm',
            unitPriceMinor: 12500,
            quantityMilli: 80000,
          ),
          ...List.generate(
            48,
            (i) => QuoteLineDraft(
              designation:
                  'Additional service ${i + 1} with a deliberately long description that can wrap across more than one line',
              unit: 'm',
              unitPriceMinor: 5000,
              quantityMilli: 1250,
            ),
          ),
        ],
      ),
    );
    final quote = (await QuoteRepository(db).getQuote(id))!;
    final lines = await QuoteRepository(db).getLines(id);
    final bytes = await QuotePdf.build(quote, lines);
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(bytes.length, greaterThan(5000));
    final pageCount = RegExp(r'/Type\s*/Page\b')
        .allMatches(String.fromCharCodes(bytes))
        .length;
    expect(pageCount, greaterThan(1));
  });

  test('builds separately titled invoice and receipt PDFs', () async {
    final invoiceId = await db
        .into(db.documents)
        .insert(
          DocumentsCompanion.insert(
            documentType: 'invoice',
            status: 'paid',
            currencyCode: 'USD',
            companyNameSnapshot: const Value('Kairo Drilling'),
            customerNameSnapshot: const Value('Test Customer'),
            issuedAt: Value(DateTime(2026, 10, 14)),
          ),
        );
    final invoiceLines = [
      DocumentLinesCompanion.insert(
        documentId: invoiceId,
        sortOrder: 0,
        designation: 'Drilling',
        unitPriceMinor: const Value(23000),
        quantityMilli: const Value(1000),
      ),
    ];
    for (final line in invoiceLines) {
      await db.into(db.documentLines).insert(line);
    }
    await (db.update(db.documents)..where((d) => d.id.equals(invoiceId))).write(
      const DocumentsCompanion(documentNumber: Value('INV-0001')),
    );
    final invoice = (await (db.select(
      db.documents,
    )..where((d) => d.id.equals(invoiceId))).getSingle());
    final invoicePdf = await QuotePdf.build(
      invoice,
      await QuoteRepository(db).getLines(invoiceId),
      title: 'INVOICE',
      numberLabel: 'Invoice',
      sectionTitle: 'INVOICE DETAILS',
      showValidity: false,
    );

    final receiptId = await db
        .into(db.documents)
        .insert(
          DocumentsCompanion.insert(
            documentType: 'receipt',
            status: 'issued',
            currencyCode: 'USD',
            companyNameSnapshot: const Value('Kairo Drilling'),
            customerNameSnapshot: const Value('Test Customer'),
            notes: const Value('PAYMENT RECEIPT'),
            termsSnapshot: const Value('Method: Cash'),
            issuedAt: Value(DateTime(2026, 10, 14)),
          ),
        );
    await db
        .into(db.documentLines)
        .insert(
          DocumentLinesCompanion.insert(
            documentId: receiptId,
            sortOrder: 0,
            designation: 'Payment received (Cash)',
            unitPriceMinor: const Value(23000),
            quantityMilli: const Value(1000),
          ),
        );
    await (db.update(db.documents)..where((d) => d.id.equals(receiptId))).write(
      const DocumentsCompanion(documentNumber: Value('RC-0001')),
    );
    final receipt = (await (db.select(
      db.documents,
    )..where((d) => d.id.equals(receiptId))).getSingle());
    final receiptPdf = await QuotePdf.build(
      receipt,
      await QuoteRepository(db).getLines(receiptId),
      title: 'PAYMENT RECEIPT',
      numberLabel: 'Receipt',
      sectionTitle: 'RECEIPT DETAILS',
      showValidity: false,
    );
    expect(String.fromCharCodes(invoicePdf.take(5)), '%PDF-');
    expect(String.fromCharCodes(receiptPdf.take(5)), '%PDF-');
    expect(invoicePdf.length, greaterThan(1000));
    expect(receiptPdf.length, greaterThan(1000));
  });
}
