import '../domain/analytics_service.dart';
import 'app_database.dart';

class AnalyticsRepository {
  const AnalyticsRepository(this._db, this._service);
  final AppDatabase _db;
  final AnalyticsService _service;

  Future<AnalyticsReport> loadReport({DateTime? now}) async {
    final documents = await (_db.select(
      _db.documents,
    )..where((d) => d.documentType.isIn(['quotation', 'invoice']))).get();
    final documentIds = documents.map((d) => d.id).toList();
    final lines = documentIds.isEmpty
        ? <DocumentLineData>[]
        : await (_db.select(
            _db.documentLines,
          )..where((line) => line.documentId.isIn(documentIds))).get();
    final linesByDocument = <int, List<DocumentLineData>>{};
    for (final line in lines) {
      linesByDocument.putIfAbsent(line.documentId, () => []).add(line);
    }
    final payments = await _db.select(_db.payments).get();
    return _service.calculate(
      now: now ?? DateTime.now(),
      documents: documents
          .map(
            (document) => AnalyticsDocument(
              id: document.id,
              documentType: document.documentType,
              status: document.status,
              currencyCode: document.currencyCode,
              customerName: document.customerNameSnapshot,
              vatRateBasisPoints: document.vatRateBasisPoints,
              discountKind: document.discountKind,
              discountValue: document.discountValue,
              sourceQuoteId: document.sourceQuoteId,
              lines:
                  (linesByDocument[document.id] ?? const <DocumentLineData>[])
                      .map(
                        (line) => AnalyticsLine(
                          designation: line.designation,
                          isSectionHeader: line.isSectionHeader,
                          unitPriceMinor: line.unitPriceMinor,
                          quantityMilli: line.quantityMilli,
                        ),
                      )
                      .toList(growable: false),
            ),
          )
          .toList(growable: false),
      payments: payments
          .map(
            (payment) => AnalyticsPayment(
              invoiceId: payment.invoiceId,
              currencyCode: payment.currencyCode,
              amountMinor: payment.amountMinor,
              paidAt: payment.paidAt,
              entryType: payment.entryType,
            ),
          )
          .toList(growable: false),
    );
  }
}
