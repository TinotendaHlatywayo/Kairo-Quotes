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
  int get schemaVersion => 4;

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
      await _createStage5IntegrityTriggers();
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
      from3To4: (m, schema) async => _createStage5IntegrityTriggers(m.database),
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _createStage5IntegrityTriggers([
    GeneratedDatabase? target,
  ]) async {
    Future<void> execute(String sql) => (target ?? this).customStatement(sql);
    await execute('''
      CREATE TRIGGER payments_validate_insert
      BEFORE INSERT ON payments
      WHEN NEW.amount_minor <= 0
        OR NEW.entry_type NOT IN ('payment', 'reversal')
        OR NEW.receipt_document_id IS NULL
        OR NOT EXISTS (
          SELECT 1 FROM documents r
          WHERE r.id = NEW.receipt_document_id
            AND r.document_type = 'receipt'
            AND r.currency_code = NEW.currency_code
        )
        OR NOT EXISTS (
          SELECT 1 FROM documents i
          WHERE i.id = NEW.invoice_id
            AND i.document_type = 'invoice'
            AND i.status != 'void'
            AND i.currency_code = NEW.currency_code
        )
        OR (NEW.entry_type = 'payment' AND NEW.reverses_payment_id IS NOT NULL)
        OR (NEW.entry_type = 'reversal' AND NOT EXISTS (
          SELECT 1 FROM payments p
          WHERE p.id = NEW.reverses_payment_id
            AND p.entry_type = 'payment'
            AND p.invoice_id = NEW.invoice_id
            AND p.currency_code = NEW.currency_code
            AND p.amount_minor = NEW.amount_minor
        ))
      BEGIN
        SELECT RAISE(ABORT, 'payment does not match invoice, receipt, or reversal rules');
      END;
    ''');
    await execute('''
      CREATE TRIGGER payments_immutable_update
      BEFORE UPDATE ON payments
      BEGIN
        SELECT RAISE(ABORT, 'payments are immutable; add a reversal entry');
      END;
    ''');
    await execute('''
      CREATE TRIGGER payments_immutable_delete
      BEFORE DELETE ON payments
      BEGIN
        SELECT RAISE(ABORT, 'payments cannot be deleted; add a reversal entry');
      END;
    ''');
    await execute('''
      CREATE TRIGGER receipt_documents_immutable_update
      BEFORE UPDATE ON documents WHEN OLD.document_type = 'receipt' AND OLD.document_number IS NOT NULL
      BEGIN
        SELECT RAISE(ABORT, 'receipts are immutable');
      END;
    ''');
    await execute('''
      CREATE TRIGGER issued_financial_documents_immutable_delete
      BEFORE DELETE ON documents
      WHEN OLD.document_type IN ('invoice', 'receipt') AND OLD.document_number IS NOT NULL
      BEGIN
        SELECT RAISE(ABORT, 'issued financial documents cannot be deleted');
      END;
    ''');
    await execute('''
      CREATE TRIGGER issued_financial_lines_immutable_update
      BEFORE UPDATE ON document_lines
      WHEN EXISTS (
        SELECT 1 FROM documents d WHERE d.id = OLD.document_id
          AND d.document_type IN ('invoice', 'receipt')
          AND d.document_number IS NOT NULL
      )
      BEGIN
        SELECT RAISE(ABORT, 'issued invoice and receipt lines are immutable');
      END;
    ''');
    await execute('''
      CREATE TRIGGER issued_financial_lines_no_insert
      BEFORE INSERT ON document_lines
      WHEN EXISTS (
        SELECT 1 FROM documents d WHERE d.id = NEW.document_id
          AND d.document_type IN ('invoice', 'receipt')
          AND d.document_number IS NOT NULL
      )
      BEGIN
        SELECT RAISE(ABORT, 'issued invoice and receipt lines are immutable');
      END;
    ''');
    await execute('''
      CREATE TRIGGER issued_financial_lines_immutable_delete
      BEFORE DELETE ON document_lines
      WHEN EXISTS (
        SELECT 1 FROM documents d WHERE d.id = OLD.document_id
          AND d.document_type IN ('invoice', 'receipt')
          AND d.document_number IS NOT NULL
      )
      BEGIN
        SELECT RAISE(ABORT, 'issued invoice and receipt lines are immutable');
      END;
    ''');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File(p.join(documentsDirectory.path, 'kairo_quotes.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
