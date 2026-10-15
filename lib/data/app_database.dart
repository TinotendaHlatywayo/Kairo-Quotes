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
    ExpenseCategories,
    Expenses,
    Documents,
    DocumentLines,
    Payments,
    TermsTemplates,
    NumberSequences,
    AuditLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor, File? databaseFile})
    : super(executor ?? _openConnection(databaseFile));

  static Future<File> defaultDatabaseFile() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return File(p.join(documentsDirectory.path, 'kairo_quotes.sqlite'));
  }

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedExpenseCategories(this);
      await _createExpenseIntegrityTriggers(this);
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
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(catalogItems, catalogItems.defaultPriceCurrencyCode);
      }
      if (from < 3) {
        await customStatement('''
          INSERT INTO audit_logs (entity_type, entity_id, action, occurred_at, before_summary, after_summary, actor)
          SELECT 'quotation', id, 'sent', COALESCE(issued_at, created_at), 'issued', 'sent', 'system'
          FROM documents
          WHERE document_type = 'quotation' AND status = 'issued'
        ''');
        await customStatement('''
          UPDATE documents SET status = 'sent'
          WHERE document_type = 'quotation' AND status = 'issued'
        ''');
      }
      if (from < 4) {
        await _createStage5IntegrityTriggers(this);
      }
      if (from < 5) {
        await m.addColumn(catalogItems, catalogItems.costPriceMinor);
        await m.addColumn(documentLines, documentLines.costPriceMinor);
        await m.createTable(expenseCategories);
        await m.createTable(expenses);
        await _seedExpenseCategories(this);
        await _createExpenseIntegrityTriggers(this);
      }
    },
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

Future<void> _seedExpenseCategories(GeneratedDatabase database) async {
  const categories = <(String, bool)>[
    ('Diesel/Fuel', false),
    ('Casing & Pipes', false),
    ('Gravel', false),
    ('Labour/Wages', false),
    ('Transport', false),
    ('Pump & Equipment', false),
    ('Solar/Electrical', false),
    ('Survey/Geophysical', false),
    ('ZINWA Levy', false),
    ('Rig Maintenance', false),
    ('Rent', true),
    ('Insurance', true),
    ('Phone/Data', true),
    ('Other', false),
  ];
  for (final (name, isOverhead) in categories) {
    await database.customStatement(
      'INSERT OR IGNORE INTO expense_categories (name, is_overhead, is_archived) VALUES (?, ?, 0)',
      [name, isOverhead ? 1 : 0],
    );
  }
}

Future<void> _createExpenseIntegrityTriggers(GeneratedDatabase database) async {
  await database.customStatement('''
    CREATE TRIGGER expenses_validate_insert
    BEFORE INSERT ON expenses
    WHEN NEW.amount_minor <= 0
      OR NEW.status NOT IN ('Active', 'Reversed')
      OR NEW.payment_method NOT IN ('Cash', 'EcoCash', 'Bank transfer', 'Swipe/Card', 'Other')
      OR (NEW.linked_invoice_id IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM documents d WHERE d.id = NEW.linked_invoice_id
          AND d.document_type = 'invoice' AND d.status != 'void'
          AND d.currency_code = NEW.currency_code
      ))
      OR (NEW.reversal_of_id IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM expenses e WHERE e.id = NEW.reversal_of_id
          AND e.status = 'Reversed' AND NEW.status = 'Reversed'
          AND e.amount_minor = NEW.amount_minor
          AND e.currency_code = NEW.currency_code
          AND e.category_id = NEW.category_id
          AND e.linked_invoice_id IS NEW.linked_invoice_id
      ))
    BEGIN
      SELECT RAISE(ABORT, 'expense does not meet amount, currency, invoice, or reversal rules');
    END;
  ''');
  await database.customStatement('''
    CREATE TRIGGER expenses_immutable_update
    BEFORE UPDATE ON expenses
    WHEN NOT (
      OLD.status = 'Active' AND NEW.status = 'Reversed'
      AND OLD.id = NEW.id AND OLD.date = NEW.date
      AND OLD.amount_minor = NEW.amount_minor
      AND OLD.currency_code = NEW.currency_code
      AND OLD.category_id = NEW.category_id
      AND OLD.description = NEW.description AND OLD.supplier IS NEW.supplier
      AND OLD.payment_method = NEW.payment_method
      AND OLD.linked_invoice_id IS NEW.linked_invoice_id
      AND OLD.receipt_photo_path IS NEW.receipt_photo_path
      AND OLD.reversal_of_id IS NEW.reversal_of_id
      AND OLD.created_at = NEW.created_at
    )
    BEGIN
      SELECT RAISE(ABORT, 'expenses are immutable; reverse and replace the entry');
    END;
  ''');
  await database.customStatement('''
    CREATE TRIGGER expenses_immutable_delete
    BEFORE DELETE ON expenses
    BEGIN
      SELECT RAISE(ABORT, 'expenses cannot be deleted; reverse the entry');
    END;
  ''');
  await database.customStatement('''
    CREATE TRIGGER used_expense_categories_no_delete
    BEFORE DELETE ON expense_categories
    WHEN EXISTS (SELECT 1 FROM expenses WHERE category_id = OLD.id)
    BEGIN
      SELECT RAISE(ABORT, 'expense categories in use cannot be deleted; archive them');
    END;
  ''');
}

LazyDatabase _openConnection([File? databaseFile]) {
  return LazyDatabase(() async {
    final file = databaseFile ?? await AppDatabase.defaultDatabaseFile();
    await file.parent.create(recursive: true);
    return NativeDatabase.createInBackground(file);
  });
}
