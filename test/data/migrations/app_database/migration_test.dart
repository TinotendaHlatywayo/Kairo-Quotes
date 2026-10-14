// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:quotes/data/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(executor: schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldCompanyProfileData = <v1.CompanyProfileData>[];
    final expectedNewCompanyProfileData = <v2.CompanyProfileData>[];

    final oldCustomersData = <v1.CustomersData>[];
    final expectedNewCustomersData = <v2.CustomersData>[];

    final oldCatalogItem = v1.CatalogItemsData(
      id: 1,
      designation: 'Survey',
      unit: 'site',
      defaultUnitPriceMinor: 12500,
      isSection: 0,
      sortOrder: 1,
      isArchived: 0,
      createdAt: 0,
    );
    final oldCatalogItemsData = [oldCatalogItem];
    final expectedNewCatalogItemsData = [
      v2.CatalogItemsData(
        id: oldCatalogItem.id,
        designation: oldCatalogItem.designation,
        unit: oldCatalogItem.unit,
        defaultUnitPriceMinor: oldCatalogItem.defaultUnitPriceMinor,
        defaultPriceCurrencyCode: 'USD',
        isSection: oldCatalogItem.isSection,
        sectionId: oldCatalogItem.sectionId,
        sortOrder: oldCatalogItem.sortOrder,
        isArchived: oldCatalogItem.isArchived,
        createdAt: oldCatalogItem.createdAt,
      ),
    ];

    final oldDocumentsData = <v1.DocumentsData>[];
    final expectedNewDocumentsData = <v2.DocumentsData>[];

    final oldDocumentLinesData = <v1.DocumentLinesData>[];
    final expectedNewDocumentLinesData = <v2.DocumentLinesData>[];

    final oldPaymentsData = <v1.PaymentsData>[];
    final expectedNewPaymentsData = <v2.PaymentsData>[];

    final oldTermsTemplatesData = <v1.TermsTemplatesData>[];
    final expectedNewTermsTemplatesData = <v2.TermsTemplatesData>[];

    final oldNumberSequencesData = <v1.NumberSequencesData>[];
    final expectedNewNumberSequencesData = <v2.NumberSequencesData>[];

    final oldAuditLogsData = <v1.AuditLogsData>[];
    final expectedNewAuditLogsData = <v2.AuditLogsData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: (executor) => AppDatabase(executor: executor),
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.companyProfile, oldCompanyProfileData);
        batch.insertAll(oldDb.customers, oldCustomersData);
        batch.insertAll(oldDb.catalogItems, oldCatalogItemsData);
        batch.insertAll(oldDb.documents, oldDocumentsData);
        batch.insertAll(oldDb.documentLines, oldDocumentLinesData);
        batch.insertAll(oldDb.payments, oldPaymentsData);
        batch.insertAll(oldDb.termsTemplates, oldTermsTemplatesData);
        batch.insertAll(oldDb.numberSequences, oldNumberSequencesData);
        batch.insertAll(oldDb.auditLogs, oldAuditLogsData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewCompanyProfileData,
          await newDb.select(newDb.companyProfile).get(),
        );
        expect(
          expectedNewCustomersData,
          await newDb.select(newDb.customers).get(),
        );
        expect(
          expectedNewCatalogItemsData,
          await newDb.select(newDb.catalogItems).get(),
        );
        expect(
          expectedNewDocumentsData,
          await newDb.select(newDb.documents).get(),
        );
        expect(
          expectedNewDocumentLinesData,
          await newDb.select(newDb.documentLines).get(),
        );
        expect(
          expectedNewPaymentsData,
          await newDb.select(newDb.payments).get(),
        );
        expect(
          expectedNewTermsTemplatesData,
          await newDb.select(newDb.termsTemplates).get(),
        );
        expect(
          expectedNewNumberSequencesData,
          await newDb.select(newDb.numberSequences).get(),
        );
        expect(
          expectedNewAuditLogsData,
          await newDb.select(newDb.auditLogs).get(),
        );
      },
    );
  });
}
