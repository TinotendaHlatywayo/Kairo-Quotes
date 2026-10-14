import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/quote_repository.dart';

void main() {
  late AppDatabase db;
  late QuoteRepository quotes;
  late int customerId;

  setUp(() async {
    db = AppDatabase(executor: NativeDatabase.memory());
    quotes = QuoteRepository(db);
    await db
        .into(db.companyProfiles)
        .insert(
          CompanyProfilesCompanion.insert(
            id: const Value(1),
            companyName: 'Test Drilling',
            quotePrefix: const Value('Q-'),
          ),
        );
    customerId = await db
        .into(db.customers)
        .insert(
          CustomersCompanion.insert(
            name: 'Customer',
            location: const Value('Town'),
          ),
        );
    await db
        .into(db.numberSequences)
        .insert(
          NumberSequencesCompanion.insert(
            documentType: 'quotation',
            prefix: 'Q-',
            padding: const Value(3),
          ),
        );
  });

  tearDown(() async => db.close());

  QuoteDraft draft({String terms = 'Terms'}) => QuoteDraft(
    customerId: customerId,
    currencyCode: 'USD',
    vatRateBasisPoints: 1500,
    discountKind: 'percent',
    discountValue: 500,
    validityDays: 30,
    terms: terms,
    lines: const [
      QuoteLineDraft(
        designation: 'Drilling',
        unit: 'm',
        unitPriceMinor: 10000,
        quantityMilli: 2000,
      ),
    ],
  );

  test('draft has no number; issue assigns number and snapshots validity atomically', () async {
    final id = await quotes.saveDraft(draft());
    var row = (await quotes.getQuote(id))!;
    expect(row.status, 'draft');
    expect(row.documentNumber, isNull);
    expect((await quotes.getLines(id)).single.designation, 'Drilling');

    await quotes.saveAndIssue(draft(), id: id);
    row = (await quotes.getQuote(id))!;
    expect(row.status, 'issued');
    expect(row.documentNumber, 'Q-001');
    expect(row.expiresAt!.difference(row.issuedAt!).inDays, 30);
    expect((await db.select(db.auditLogs).get()).single.action, 'issued');
    expect((await db.select(db.numberSequences).get()).single.nextNumber, 2);
  });

  test(
    'issued quote cannot be changed and duplicate creates an unnumbered draft',
    () async {
      final id = await quotes.saveAndIssue(draft());
      await expectLater(
        quotes.saveDraft(draft(terms: 'edited'), id: id),
        throwsStateError,
      );
      final copyId = await quotes.duplicate(id);
      final copy = (await quotes.getQuote(copyId))!;
      expect(copy.status, 'draft');
      expect(copy.documentNumber, isNull);
      expect(copy.termsSnapshot, 'Terms');
      expect((await quotes.getLines(copyId)).single.unitPriceMinor, 10000);
    },
  );

  test('failed issue leaves sequence and draft state unchanged', () async {
    final id = await quotes.saveDraft(draft());
    final invalid = QuoteDraft(
      customerId: customerId,
      currencyCode: 'USD',
      vatRateBasisPoints: 1500,
      discountKind: 'none',
      discountValue: 0,
      validityDays: 30,
      terms: '',
      lines: const [
        QuoteLineDraft(designation: 'Heading', isSectionHeader: true),
      ],
    );
    await expectLater(
      quotes.saveAndIssue(invalid, id: id),
      throwsArgumentError,
    );
    expect((await quotes.getQuote(id))!.status, 'draft');
    expect((await db.select(db.numberSequences).get()).single.nextNumber, 1);
  });
}
