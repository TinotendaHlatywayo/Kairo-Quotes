import 'package:drift/drift.dart';

import '../domain/pricing_engine.dart';
import 'app_database.dart';

class QuoteLineDraft {
  const QuoteLineDraft({
    required this.designation,
    this.unit = '',
    this.unitPriceMinor,
    this.quantityMilli,
    this.isSectionHeader = false,
  });

  final String designation;
  final String unit;
  final int? unitPriceMinor;
  final int? quantityMilli;
  final bool isSectionHeader;
}

class QuoteDraft {
  const QuoteDraft({
    required this.customerId,
    required this.currencyCode,
    required this.vatRateBasisPoints,
    required this.discountKind,
    required this.discountValue,
    required this.validityDays,
    required this.terms,
    required this.lines,
    this.saveTermsAsDefault = false,
  });

  final int customerId;
  final String currencyCode;
  final int vatRateBasisPoints;
  final String discountKind;
  final int discountValue;
  final int validityDays;
  final String terms;
  final List<QuoteLineDraft> lines;
  final bool saveTermsAsDefault;
}

class QuoteRepository {
  const QuoteRepository(this._db);
  final AppDatabase _db;

  Stream<List<DocumentData>> watchQuotes() =>
      (_db.select(_db.documents)
            ..where((d) => d.documentType.equals('quotation'))
            ..orderBy([
              (d) => OrderingTerm.desc(d.createdAt),
              (d) => OrderingTerm.desc(d.id),
            ]))
          .watch();

  Future<DocumentData?> getQuote(int id) async =>
      (_db.select(
            _db.documents,
          )..where((d) => d.id.equals(id) & d.documentType.equals('quotation')))
          .getSingleOrNull();

  Future<List<DocumentLineData>> getLines(int id) =>
      (_db.select(_db.documentLines)
            ..where((line) => line.documentId.equals(id))
            ..orderBy([(line) => OrderingTerm.asc(line.sortOrder)]))
          .get();

  Future<int> saveDraft(QuoteDraft draft, {int? id}) =>
      _save(draft, id: id, issue: false);

  Future<int> saveAndIssue(QuoteDraft draft, {int? id}) =>
      _save(draft, id: id, issue: true);

  Future<int> _save(QuoteDraft draft, {int? id, required bool issue}) async {
    _validate(draft, requirePricedLine: issue);
    return _db.transaction(() async {
      final profile = await (_db.select(
        _db.companyProfiles,
      )..where((row) => row.id.equals(1))).getSingleOrNull();
      if (profile == null) throw StateError('Complete company settings first.');
      final customer = await (_db.select(
        _db.customers,
      )..where((row) => row.id.equals(draft.customerId))).getSingleOrNull();
      if (customer == null || customer.isArchived) {
        throw StateError('Choose an active customer.');
      }
      final now = DateTime.now();
      DocumentData? existing;
      if (id != null) {
        existing = await getQuote(id);
        if (existing == null) throw StateError('Quotation no longer exists.');
        if (existing.status != 'draft') {
          throw StateError('Issued quotations are locked.');
        }
      }
      final company = existing == null;
      final companion = DocumentsCompanion(
        documentType: const Value('quotation'),
        status: const Value('draft'),
        customerId: Value(draft.customerId),
        currencyCode: Value(draft.currencyCode),
        vatRateBasisPoints: Value(draft.vatRateBasisPoints),
        discountKind: Value(draft.discountKind),
        discountValue: Value(draft.discountValue),
        termsSnapshot: Value(draft.terms.trim()),
        customerNameSnapshot: Value(customer.name),
        customerLocationSnapshot: Value(customer.location),
        customerPhoneSnapshot: Value(customer.phone),
        companyNameSnapshot: Value(
          company ? profile.companyName : existing.companyNameSnapshot,
        ),
        legalNameSnapshot: Value(
          company ? (profile.legalName ?? '') : existing.legalNameSnapshot,
        ),
        addressSnapshot: Value(
          company ? profile.address : existing.addressSnapshot,
        ),
        phoneNumbersSnapshot: Value(
          company ? profile.phoneNumbers : existing.phoneNumbersSnapshot,
        ),
        taglineSnapshot: Value(
          company ? profile.tagline : existing.taglineSnapshot,
        ),
        signatorySnapshot: Value(
          company ? profile.signatory : existing.signatorySnapshot,
        ),
        vatNumberSnapshot: Value(
          company ? profile.vatNumber : existing.vatNumberSnapshot,
        ),
        tinNumberSnapshot: Value(
          company ? profile.tinNumber : existing.tinNumberSnapshot,
        ),
        logoPathSnapshot: Value(
          company ? profile.logoPath : existing.logoPathSnapshot,
        ),
        validityDays: Value(draft.validityDays),
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
      );
      final quoteId = id == null
          ? await _db.into(_db.documents).insert(companion)
          : (
              await (_db.update(
                _db.documents,
              )..where((row) => row.id.equals(id))).write(companion),
              id,
            ).$2;
      await (_db.delete(
        _db.documentLines,
      )..where((row) => row.documentId.equals(quoteId))).go();
      for (var index = 0; index < draft.lines.length; index++) {
        final line = draft.lines[index];
        await _db
            .into(_db.documentLines)
            .insert(
              DocumentLinesCompanion.insert(
                documentId: quoteId,
                sortOrder: index,
                isSectionHeader: Value(line.isSectionHeader),
                designation: line.designation.trim(),
                unit: Value(line.unit.trim()),
                unitPriceMinor: Value(line.unitPriceMinor),
                quantityMilli: Value(line.quantityMilli),
              ),
            );
      }
      if (draft.saveTermsAsDefault) {
        await _saveDefaultTerms(draft.terms.trim(), now);
      }
      if (issue) await _issue(quoteId, profile, now);
      return quoteId;
    });
  }

  Future<void> _issue(int id, CompanyProfileData profile, DateTime now) async {
    final sequence = await (_db.select(
      _db.numberSequences,
    )..where((s) => s.documentType.equals('quotation'))).getSingleOrNull();
    final prefix = sequence?.prefix ?? profile.quotePrefix;
    final next = sequence?.nextNumber ?? 1;
    final padding = sequence?.padding ?? profile.numberPadding;
    final number = '$prefix${next.toString().padLeft(padding, '0')}';
    await _db
        .into(_db.numberSequences)
        .insertOnConflictUpdate(
          NumberSequencesCompanion.insert(
            documentType: 'quotation',
            prefix: prefix,
            nextNumber: Value(next + 1),
            padding: Value(padding),
          ),
        );
    await (_db.update(_db.documents)..where((d) => d.id.equals(id))).write(
      DocumentsCompanion(
        status: const Value('issued'),
        documentNumber: Value(number),
        issuedAt: Value(now),
        expiresAt: Value(
          now.add(Duration(days: (await getQuote(id))!.validityDays)),
        ),
        updatedAt: Value(now),
      ),
    );
    await _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            entityType: 'quotation',
            entityId: id,
            action: 'issued',
            occurredAt: Value(now),
            afterSummary: Value(number),
          ),
        );
  }

  Future<void> _saveDefaultTerms(String content, DateTime now) async {
    await (_db.update(_db.termsTemplates)
          ..where((t) => t.isDefault.equals(true)))
        .write(TermsTemplatesCompanion(isDefault: const Value(false)));
    final existing = await (_db.select(
      _db.termsTemplates,
    )..where((t) => t.name.equals('Default terms'))).getSingleOrNull();
    if (existing == null) {
      await _db
          .into(_db.termsTemplates)
          .insert(
            TermsTemplatesCompanion.insert(
              name: 'Default terms',
              content: content,
              isDefault: const Value(true),
              updatedAt: Value(now),
            ),
          );
    } else {
      await (_db.update(
        _db.termsTemplates,
      )..where((t) => t.id.equals(existing.id))).write(
        TermsTemplatesCompanion(
          content: Value(content),
          isDefault: const Value(true),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<int> duplicate(int sourceId) async {
    return _db.transaction(() async {
      final source = await getQuote(sourceId);
      if (source == null) throw StateError('Quotation no longer exists.');
      final id = await _db
          .into(_db.documents)
          .insert(
            DocumentsCompanion.insert(
              documentType: 'quotation',
              status: 'draft',
              customerId: Value(source.customerId),
              currencyCode: source.currencyCode,
              vatRateBasisPoints: Value(source.vatRateBasisPoints),
              discountKind: Value(source.discountKind),
              discountValue: Value(source.discountValue),
              termsSnapshot: Value(source.termsSnapshot),
              customerNameSnapshot: Value(source.customerNameSnapshot),
              customerLocationSnapshot: Value(source.customerLocationSnapshot),
              customerPhoneSnapshot: Value(source.customerPhoneSnapshot),
              companyNameSnapshot: Value(source.companyNameSnapshot),
              legalNameSnapshot: Value(source.legalNameSnapshot),
              addressSnapshot: Value(source.addressSnapshot),
              phoneNumbersSnapshot: Value(source.phoneNumbersSnapshot),
              taglineSnapshot: Value(source.taglineSnapshot),
              signatorySnapshot: Value(source.signatorySnapshot),
              vatNumberSnapshot: Value(source.vatNumberSnapshot),
              tinNumberSnapshot: Value(source.tinNumberSnapshot),
              logoPathSnapshot: Value(source.logoPathSnapshot),
              validityDays: Value(source.validityDays),
            ),
          );
      final lines = await getLines(sourceId);
      for (final line in lines) {
        await _db
            .into(_db.documentLines)
            .insert(
              DocumentLinesCompanion.insert(
                documentId: id,
                sortOrder: line.sortOrder,
                isSectionHeader: Value(line.isSectionHeader),
                designation: line.designation,
                unit: Value(line.unit),
                unitPriceMinor: Value(line.unitPriceMinor),
                quantityMilli: Value(line.quantityMilli),
              ),
            );
      }
      return id;
    });
  }

  static void _validate(QuoteDraft draft, {required bool requirePricedLine}) {
    if (draft.customerId <= 0) throw ArgumentError('Choose a customer.');
    if (draft.currencyCode.trim().isEmpty) {
      throw ArgumentError('Choose a currency.');
    }
    if (draft.validityDays < 1 || draft.validityDays > 3650) {
      throw ArgumentError('Validity must be 1–3650 days.');
    }
    if (!['none', 'percent', 'fixed'].contains(draft.discountKind)) {
      throw ArgumentError('Invalid discount type.');
    }
    if (draft.lines.any((line) => line.designation.trim().isEmpty)) {
      throw ArgumentError('Every row needs a description.');
    }
    final pricingLines = draft.lines
        .map(
          (l) => PricingLine(
            unitPriceMinor: l.unitPriceMinor,
            quantityMilli: l.quantityMilli,
            isSectionHeader: l.isSectionHeader,
          ),
        )
        .toList();
    const engine = PricingEngine();
    engine.calculate(
      lines: pricingLines,
      vatRateBasisPoints: draft.vatRateBasisPoints,
      discount: switch (draft.discountKind) {
        'percent' => Discount.percent(draft.discountValue),
        'fixed' => Discount.fixed(draft.discountValue),
        _ => const Discount.none(),
      },
    );
    if (requirePricedLine &&
        !draft.lines.any((line) => !line.isSectionHeader)) {
      throw ArgumentError('Add at least one priced item before issuing.');
    }
  }
}
