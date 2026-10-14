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
}
