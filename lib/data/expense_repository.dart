import 'package:drift/drift.dart';

import '../domain/payment_methods.dart';
import 'app_database.dart';

class ExpenseDraft {
  const ExpenseDraft({
    required this.date,
    required this.amountMinor,
    required this.currencyCode,
    required this.categoryId,
    required this.description,
    required this.paymentMethod,
    this.supplier,
    this.linkedInvoiceId,
    this.receiptPhotoPath,
  });

  final DateTime date;
  final int amountMinor;
  final String currencyCode;
  final int categoryId;
  final String description;
  final String? supplier;
  final String paymentMethod;
  final int? linkedInvoiceId;
  final String? receiptPhotoPath;
}

class ExpenseRepository {
  const ExpenseRepository(this._database);

  final AppDatabase _database;

  Stream<List<ExpenseCategoryData>> watchCategories({bool includeArchived = false}) =>
      (_database.select(_database.expenseCategories)
            ..where((row) => includeArchived ? const Constant(true) : row.isArchived.equals(false))
            ..orderBy([(row) => OrderingTerm.asc(row.name)]))
          .watch();

  Future<List<ExpenseCategoryData>> getCategories({bool includeArchived = false}) =>
      (_database.select(_database.expenseCategories)
            ..where((row) => includeArchived ? const Constant(true) : row.isArchived.equals(false))
            ..orderBy([(row) => OrderingTerm.asc(row.name)]))
          .get();

  Stream<List<ExpenseData>> watchExpenses() => (_database.select(_database.expenses)
        ..orderBy([
          (row) => OrderingTerm.desc(row.date),
          (row) => OrderingTerm.desc(row.id),
        ]))
      .watch();

  Future<ExpenseData?> getExpense(int id) => (_database.select(
    _database.expenses,
  )..where((row) => row.id.equals(id))).getSingleOrNull();

  Future<int> saveCategory({required String name, required bool isOverhead, int? id}) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) throw ArgumentError('Enter a category name.');
    if (id == null) {
      return _database.into(_database.expenseCategories).insert(
        ExpenseCategoriesCompanion.insert(name: cleanName, isOverhead: Value(isOverhead)),
      );
    }
    final changed = await (_database.update(_database.expenseCategories)
          ..where((row) => row.id.equals(id)))
        .write(ExpenseCategoriesCompanion(name: Value(cleanName), isOverhead: Value(isOverhead)));
    if (changed == 0) throw StateError('Expense category no longer exists.');
    return id;
  }

  Future<void> archiveCategory(int id, {required bool archived}) async {
    final changed = await (_database.update(_database.expenseCategories)
          ..where((row) => row.id.equals(id)))
        .write(ExpenseCategoriesCompanion(isArchived: Value(archived)));
    if (changed == 0) throw StateError('Expense category no longer exists.');
  }

  Future<int> addExpense(ExpenseDraft draft) => _database.transaction(() async {
    await _validateDraft(draft);
    final id = await _database.into(_database.expenses).insert(
      ExpensesCompanion.insert(
        date: draft.date,
        amountMinor: draft.amountMinor,
        currencyCode: draft.currencyCode.trim(),
        categoryId: draft.categoryId,
        description: Value(draft.description.trim()),
        supplier: Value(_optional(draft.supplier)),
        paymentMethod: draft.paymentMethod,
        linkedInvoiceId: Value(draft.linkedInvoiceId),
        receiptPhotoPath: Value(draft.receiptPhotoPath),
      ),
    );
    await _audit(id, 'created', after: _summary(draft));
    return id;
  });

  /// Corrects an active expense by preserving it as a reversal pair, then
  /// writing the corrected active entry. Existing expense rows are never
  /// hard-deleted or rewritten apart from their one-way Active -> Reversed state.
  Future<int> correctExpense(
    int expenseId,
    ExpenseDraft replacement, {
    String reason = 'Corrected expense',
  }) => _database.transaction(() async {
    final original = await getExpense(expenseId);
    if (original == null || original.status != 'Active') {
      throw StateError('Only an active expense can be corrected.');
    }
    await _validateDraft(replacement);
    await (_database.update(_database.expenses)
          ..where((row) => row.id.equals(expenseId) & row.status.equals('Active')))
        .write(const ExpensesCompanion(status: Value('Reversed')));
    await _audit(
      original.id,
      'reversed',
      before: 'Active · ${original.amountMinor} ${original.currencyCode}',
      after: reason.trim().isEmpty ? 'Corrected expense' : reason.trim(),
    );
    final reversalId = await _database.into(_database.expenses).insert(
      ExpensesCompanion.insert(
        date: DateTime.now(),
        amountMinor: original.amountMinor,
        currencyCode: original.currencyCode,
        categoryId: original.categoryId,
        description: Value('Reversal of expense #${original.id}'),
        supplier: Value(original.supplier),
        paymentMethod: original.paymentMethod,
        linkedInvoiceId: Value(original.linkedInvoiceId),
        status: const Value('Reversed'),
        reversalOfId: Value(original.id),
      ),
    );
    await _audit(
      reversalId,
      'reversal_created',
      after: 'expense:${original.id}',
    );
    final newId = await _database.into(_database.expenses).insert(
      ExpensesCompanion.insert(
        date: replacement.date,
        amountMinor: replacement.amountMinor,
        currencyCode: replacement.currencyCode.trim(),
        categoryId: replacement.categoryId,
        description: Value(replacement.description.trim()),
        supplier: Value(_optional(replacement.supplier)),
        paymentMethod: replacement.paymentMethod,
        linkedInvoiceId: Value(replacement.linkedInvoiceId),
        receiptPhotoPath: Value(replacement.receiptPhotoPath),
      ),
    );
    await _audit(newId, 'created_as_correction', after: _summary(replacement));
    return newId;
  });

  Future<void> _validateDraft(ExpenseDraft draft) async {
    if (draft.amountMinor <= 0) throw ArgumentError('Expense amount must be greater than zero.');
    if (draft.currencyCode.trim().isEmpty) throw ArgumentError('Choose a currency.');
    if (!paymentMethodOptions.contains(draft.paymentMethod)) {
      throw ArgumentError('Choose a supported payment method.');
    }
    final category = await (_database.select(_database.expenseCategories)
          ..where((row) => row.id.equals(draft.categoryId)))
        .getSingleOrNull();
    if (category == null || category.isArchived) {
      throw StateError('Choose an active expense category.');
    }
    if (draft.linkedInvoiceId case final invoiceId?) {
      final invoice = await (_database.select(_database.documents)
            ..where((row) => row.id.equals(invoiceId)))
          .getSingleOrNull();
      if (invoice == null || invoice.documentType != 'invoice' || invoice.status == 'void') {
        throw StateError('Expenses can only be linked to an active invoice.');
      }
      if (invoice.currencyCode != draft.currencyCode.trim()) {
        throw ArgumentError('The expense currency must match its invoice currency.');
      }
    }
  }

  Future<void> _audit(int id, String action, {String? before, String? after}) =>
      _database.into(_database.auditLogs).insert(
        AuditLogsCompanion.insert(
          entityType: 'expense',
          entityId: id,
          action: action,
          beforeSummary: Value(before),
          afterSummary: Value(after),
        ),
      );

  static String? _optional(String? value) {
    final clean = value?.trim();
    return clean == null || clean.isEmpty ? null : clean;
  }

  static String _summary(ExpenseDraft draft) =>
      '${draft.amountMinor} ${draft.currencyCode} · ${draft.description.trim()}';
}
