import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';
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
  int get schemaVersion => 1;

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
    onUpgrade: (m, from, to) async {
      throw UnsupportedError(
        'No migration path is defined from schema $from to $to yet.',
      );
    },
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
