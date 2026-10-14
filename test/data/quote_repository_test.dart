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
    expect(row.status, 'sent');
    expect(row.documentNumber, 'Q-001');
    expect(row.expiresAt!.difference(row.issuedAt!).inDays, 30);
    expect((await db.select(db.auditLogs).get()).single.action, 'sent');
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

  test(
    'sent quotations can be accepted or rejected and record status history',
    () async {
      final acceptedId = await quotes.saveAndIssue(draft());
      await quotes.accept(acceptedId);
      expect((await quotes.getQuote(acceptedId))!.status, 'accepted');

      final rejectedId = await quotes.saveAndIssue(draft());
      await quotes.reject(rejectedId);
      expect((await quotes.getQuote(rejectedId))!.status, 'rejected');
      expect((await quotes.getAuditTrail(acceptedId)).map((e) => e.action), [
        'sent',
        'accepted',
      ]);
      expect((await quotes.getAuditTrail(rejectedId)).map((e) => e.action), [
        'sent',
        'rejected',
      ]);
      await expectLater(quotes.reject(acceptedId), throwsStateError);
    },
  );

  test(
    'expiry is recorded once and an expired quote cannot be accepted',
    () async {
      final id = await quotes.saveAndIssue(draft());
      final expiredAt = DateTime.now().add(const Duration(seconds: 1));
      await (db.update(db.documents)..where((row) => row.id.equals(id))).write(
        DocumentsCompanion(
          expiresAt: Value(expiredAt),
          updatedAt: Value(DateTime.now()),
        ),
      );
      final expirationRun = expiredAt.add(const Duration(milliseconds: 1));
      expect(await quotes.expireDueQuotes(now: expirationRun), 1);
      expect(
        await quotes.expireDueQuotes(
          now: expirationRun.add(const Duration(days: 1)),
        ),
        0,
      );
      expect((await quotes.getQuote(id))!.status, 'expired');
      expect((await quotes.getAuditTrail(id)).map((e) => e.action), [
        'sent',
        'expired',
      ]);
      await expectLater(quotes.accept(id), throwsStateError);
    },
  );

  test(
    'revision preserves the sent quote and links an editable snapshot copy',
    () async {
      final id = await quotes.saveAndIssue(draft());
      final revisionId = await quotes.revise(id);
      final source = (await quotes.getQuote(id))!;
      final revision = (await quotes.getQuote(revisionId))!;
      expect(source.status, 'sent');
      expect(revision.status, 'draft');
      expect(revision.replacesDocumentId, id);
      expect(revision.documentNumber, isNull);
      expect((await quotes.getLines(revisionId)).single.unitPriceMinor, 10000);
      expect((await quotes.getAuditTrail(id)).last.action, 'revision_created');
      await expectLater(quotes.revise(revisionId), throwsStateError);
    },
  );

  test('quote search and status filters include customer and number', () async {
    final sentId = await quotes.saveAndIssue(draft());
    final draftId = await quotes.saveDraft(draft());
    expect(await quotes.watchQuotes(status: 'sent').first, hasLength(1));
    expect(await quotes.watchQuotes(search: 'Q-001').first, hasLength(1));
    expect(
      await quotes.watchQuotes(search: 'customer', status: 'draft').first,
      hasLength(1),
    );
    expect(
      (await quotes.watchQuotes().first).map((q) => q.id),
      containsAll([sentId, draftId]),
    );
  });
}
