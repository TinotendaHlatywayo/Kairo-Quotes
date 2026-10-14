import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';
import 'app_database.steps.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CompanyProfiles,
    Customers,
    CatalogItems,
    Documents,
    DocumentLines,
    Payments,
    TermsTemplates,
    NumberSequences,
    AuditLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement('''
        CREATE TRIGGER payments_match_invoice_currency
        BEFORE INSERT ON payments
        WHEN NOT EXISTS (
          SELECT 1 FROM documents
          WHERE id = NEW.invoice_id
            AND document_type = 'invoice'
            AND currency_code = NEW.currency_code
        )
        BEGIN
          SELECT RAISE(ABORT, 'payment must use its invoice currency');
        END;
      ''');
      await customStatement('''
        CREATE TRIGGER document_lines_have_valid_shape
        BEFORE INSERT ON document_lines
        WHEN (NEW.is_section_header = 1 AND
              (NEW.unit_price_minor IS NOT NULL OR NEW.quantity_milli IS NOT NULL))
          OR (NEW.is_section_header = 0 AND
              (NEW.unit_price_minor IS NULL OR NEW.quantity_milli IS NULL))
        BEGIN
          SELECT RAISE(ABORT, 'document line price and quantity do not match row type');
        END;
      ''');
    },
    onUpgrade: stepByStep(
      from1To2: (m, schema) async => m.addColumn(
        schema.catalogItems,
        schema.catalogItems.defaultPriceCurrencyCode,
      ),
      from2To3: (m, schema) async {
        await m.database.customStatement('''
          INSERT INTO audit_logs (entity_type, entity_id, action, occurred_at, before_summary, after_summary, actor)
          SELECT 'quotation', id, 'sent', COALESCE(issued_at, created_at), 'issued', 'sent', 'system'
          FROM documents
          WHERE document_type = 'quotation' AND status = 'issued'
        ''');
        await m.database.customStatement('''
          UPDATE documents SET status = 'sent'
          WHERE document_type = 'quotation' AND status = 'issued'
        ''');
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File(p.join(documentsDirectory.path, 'kairo_quotes.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
