import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/default_business_data.dart';
import 'package:quotes/data/settings_repository.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(executor: NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('creates all current tables and enables foreign keys', () async {
    final tableRows = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .get();
    final tableNames = tableRows.map((row) => row.read<String>('name')).toSet();

    expect(database.schemaVersion, 6);
    expect(
      tableNames,
      containsAll([
        'company_profile',
        'customers',
        'catalog_items',
        'expense_categories',
        'expenses',
        'documents',
        'document_lines',
        'payments',
        'terms_templates',
        'number_sequences',
        'audit_logs',
      ]),
    );
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_keys')
        .getSingle();
    expect(foreignKeys.read<int>('foreign_keys'), 1);

    final columns = await database
        .customSelect('PRAGMA table_info(catalog_items)')
        .get();
    expect(
      columns.map((row) => row.read<String>('name')),
      contains('default_price_currency_code'),
    );
  });

  test(
    'prevents a second invoice from referencing the same quotation',
    () async {
      final quoteId = await database
          .into(database.documents)
          .insert(
            DocumentsCompanion.insert(
              documentType: 'quotation',
              status: 'accepted',
              currencyCode: 'USD',
            ),
          );

      Future<int> addInvoice() => database
          .into(database.documents)
          .insert(
            DocumentsCompanion.insert(
              documentType: 'invoice',
              status: 'issued',
              currencyCode: 'USD',
              sourceQuoteId: Value(quoteId),
            ),
          );

      await addInvoice();
      await expectLater(addInvoice(), throwsA(isA<Exception>()));
    },
  );

  test(
    'rejects payment in a currency different from its invoice currency',
    () async {
      final invoiceId = await database
          .into(database.documents)
          .insert(
            DocumentsCompanion.insert(
              documentType: 'invoice',
              status: 'issued',
              currencyCode: 'USD',
            ),
          );

      await expectLater(
        database
            .into(database.payments)
            .insert(
              PaymentsCompanion.insert(
                invoiceId: invoiceId,
                currencyCode: 'ZiG',
                amountMinor: 10000,
                method: 'Cash',
                paidAt: DateTime(2026, 10, 14),
              ),
            ),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'seeds company defaults, numbering, terms and editable blank-price catalog',
    () async {
      final settings = SettingsRepository(database);
      await settings.save(
        profile: const CompanyProfileDraft(
          companyName: 'Kairo Borehole Drilling',
          legalName: '',
          address: 'Harare',
          phoneNumbers: '0772 123 456',
          tagline: '',
          signatory: '',
          vatRateBasisPoints: 1500,
          vatNumber: '',
          tinNumber: '',
          supportedCurrencies: ['USD', 'ZiG'],
          logoPath: null,
          signatureImagePath: null,
          quotePrefix: 'QT-',
          invoicePrefix: 'INV-',
          receiptPrefix: 'RC-',
        ),
        defaultTermsLines: defaultTerms,
      );

      final profile = await settings.watchCompanyProfile().first;
      expect(profile?.companyName, 'Kairo Borehole Drilling');
      expect(profile?.vatRateBasisPoints, 1500);
      expect(profile?.supportedCurrencies, 'USD,ZiG');

      final terms = await settings.getDefaultTerms();
      expect(terms?.content.split('\n'), defaultTerms);
      expect(
        await database.select(database.numberSequences).get(),
        hasLength(3),
      );

      final catalog = await database.select(database.catalogItems).get();
      expect(catalog.where((item) => item.isSection), hasLength(3));
      expect(catalog.where((item) => !item.isSection), hasLength(11));
      expect(
        catalog
            .where((item) => !item.isSection)
            .every((item) => item.defaultUnitPriceMinor == null),
        isTrue,
      );
    },
  );
}
