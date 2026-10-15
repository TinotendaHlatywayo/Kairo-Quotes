import '../domain/profit_service.dart';
import 'app_database.dart';

class ProfitRepository {
  const ProfitRepository(this._database, this._service);

  final AppDatabase _database;
  final ProfitService _service;

  Future<ProfitReport> loadReport({
    required DateTime from,
    required DateTime through,
    required ProfitMode mode,
  }) async {
    final invoices = await (_database.select(_database.documents)
          ..where((row) => row.documentType.equals('invoice')))
        .get();
    final invoiceIds = invoices.map((row) => row.id).toList(growable: false);
    final lines = invoiceIds.isEmpty
        ? <DocumentLineData>[]
        : await (_database.select(_database.documentLines)
              ..where((row) => row.documentId.isIn(invoiceIds)))
            .get();
    final linesByInvoice = <int, List<DocumentLineData>>{};
    for (final line in lines) {
      linesByInvoice.putIfAbsent(line.documentId, () => []).add(line);
    }
    final expenses = await _database.select(_database.expenses).get();
    final categories = await _database.select(_database.expenseCategories).get();
    final categoryById = {for (final category in categories) category.id: category};
    final payments = await _database.select(_database.payments).get();

    return _service.calculate(
      from: from,
      through: through,
      mode: mode,
      invoices: invoices
          .map(
            (invoice) => ProfitInvoice(
              id: invoice.id,
              currencyCode: invoice.currencyCode,
              status: invoice.status,
              date: invoice.issuedAt ?? invoice.createdAt,
              vatRateBasisPoints: invoice.vatRateBasisPoints,
              discountKind: invoice.discountKind,
              discountValue: invoice.discountValue,
              lines: (linesByInvoice[invoice.id] ?? const <DocumentLineData>[])
                  .map(
                    (line) => ProfitLine(
                      unitPriceMinor: line.unitPriceMinor,
                      quantityMilli: line.quantityMilli,
                      isSectionHeader: line.isSectionHeader,
                      costPriceMinor: line.costPriceMinor,
                    ),
                  )
                  .toList(growable: false),
            ),
          )
          .toList(growable: false),
      expenses: expenses
          .map(
            (expense) => ProfitExpense(
              id: expense.id,
              date: expense.date,
              amountMinor: expense.amountMinor,
              currencyCode: expense.currencyCode,
              status: expense.status,
              linkedInvoiceId: expense.linkedInvoiceId,
              reversalOfId: expense.reversalOfId,
              isOverhead: categoryById[expense.categoryId]?.isOverhead ?? false,
            ),
          )
          .toList(growable: false),
      payments: payments
          .map(
            (payment) => ProfitPayment(
              invoiceId: payment.invoiceId,
              amountMinor: payment.amountMinor,
              currencyCode: payment.currencyCode,
              paidAt: payment.paidAt,
              entryType: payment.entryType,
            ),
          )
          .toList(growable: false),
    );
  }
}
