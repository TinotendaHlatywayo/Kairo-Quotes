import 'package:drift/drift.dart';

import 'app_database.dart';
import 'default_business_data.dart';

class CompanyProfileDraft {
  const CompanyProfileDraft({
    required this.companyName,
    required this.legalName,
    required this.address,
    required this.phoneNumbers,
    required this.tagline,
    required this.signatory,
    required this.vatRateBasisPoints,
    required this.vatNumber,
    required this.tinNumber,
    required this.supportedCurrencies,
    required this.logoPath,
    required this.quotePrefix,
    required this.invoicePrefix,
    required this.receiptPrefix,
  });

  final String companyName;
  final String? legalName;
  final String address;
  final String phoneNumbers;
  final String tagline;
  final String signatory;
  final int vatRateBasisPoints;
  final String? vatNumber;
  final String? tinNumber;
  final List<String> supportedCurrencies;
  final String? logoPath;
  final String quotePrefix;
  final String invoicePrefix;
  final String receiptPrefix;
}

class SettingsRepository {
  const SettingsRepository(this._database);

  final AppDatabase _database;

  Stream<CompanyProfileData?> watchCompanyProfile() {
    return (_database.select(_database.companyProfiles)
          ..where((row) => row.id.equals(1)))
        .watchSingleOrNull();
  }

  Future<TermsTemplateData?> getDefaultTerms() {
    return (_database.select(_database.termsTemplates)
          ..where((row) => row.isDefault.equals(true)))
        .getSingleOrNull();
  }

  Future<void> save({
    required CompanyProfileDraft profile,
    required List<String> defaultTermsLines,
  }) async {
    if (profile.companyName.trim().isEmpty) {
      throw ArgumentError.value(profile.companyName, 'companyName', 'Required.');
    }
    if (profile.vatRateBasisPoints < 0 || profile.vatRateBasisPoints > 10000) {
      throw RangeError.range(profile.vatRateBasisPoints, 0, 10000, 'vatRate');
    }
    if (profile.supportedCurrencies.isEmpty) {
      throw ArgumentError('Select at least one supported currency.');
    }
    for (final prefix in [
      profile.quotePrefix,
      profile.invoicePrefix,
      profile.receiptPrefix,
    ]) {
      if (prefix.trim().isEmpty) {
        throw ArgumentError('Document number prefixes cannot be empty.');
      }
    }

    await _database.transaction(() async {
      await _database.into(_database.companyProfiles).insertOnConflictUpdate(
        CompanyProfilesCompanion.insert(
          id: const Value(1),
          companyName: profile.companyName.trim(),
          legalName: Value(_nullableTrim(profile.legalName)),
          address: Value(profile.address.trim()),
          phoneNumbers: Value(profile.phoneNumbers.trim()),
          tagline: Value(profile.tagline.trim()),
          signatory: Value(profile.signatory.trim()),
          vatRateBasisPoints: Value(profile.vatRateBasisPoints),
          vatNumber: Value(_nullableTrim(profile.vatNumber)),
          tinNumber: Value(_nullableTrim(profile.tinNumber)),
          supportedCurrencies: Value(profile.supportedCurrencies.join(',')),
          logoPath: Value(_nullableTrim(profile.logoPath)),
          quotePrefix: Value(profile.quotePrefix.trim()),
          invoicePrefix: Value(profile.invoicePrefix.trim()),
          receiptPrefix: Value(profile.receiptPrefix.trim()),
        ),
      );

      final termsContent = _cleanLines(defaultTermsLines).join('\n');
      final currentTerms = await getDefaultTerms();
      if (currentTerms == null) {
        await _database.into(_database.termsTemplates).insert(
          TermsTemplatesCompanion.insert(
            name: 'Default terms',
            content: termsContent,
            isDefault: const Value(true),
          ),
        );
      } else {
        await (_database.update(_database.termsTemplates)
              ..where((row) => row.id.equals(currentTerms.id)))
            .write(
              TermsTemplatesCompanion(
                content: Value(termsContent),
                updatedAt: Value(DateTime.now()),
              ),
            );
      }

      if (await _database.select(_database.catalogItems).get().then((rows) => rows.isEmpty)) {
        var order = 0;
        for (final section in starterCatalog) {
          final sectionId = await _database.into(_database.catalogItems).insert(
            CatalogItemsCompanion.insert(
              designation: section.name,
              isSection: const Value(true),
              sortOrder: Value(order++),
            ),
          );
          for (final item in section.items) {
            await _database.into(_database.catalogItems).insert(
              CatalogItemsCompanion.insert(
                designation: item.name,
                unit: Value(item.unit),
                sectionId: Value(sectionId),
                sortOrder: Value(order++),
              ),
            );
          }
        }
      }

      final prefixes = <String, String>{
        'quotation': profile.quotePrefix.trim(),
        'invoice': profile.invoicePrefix.trim(),
        'receipt': profile.receiptPrefix.trim(),
      };
      for (final entry in prefixes.entries) {
        await _database.into(_database.numberSequences).insertOnConflictUpdate(
          NumberSequencesCompanion.insert(
            documentType: entry.key,
            prefix: entry.value,
          ),
        );
      }
    });
  }

  Future<void> resetDefaultTerms() async {
    final content = defaultTerms.join('\n');
    final current = await getDefaultTerms();
    if (current == null) {
      await _database.into(_database.termsTemplates).insert(
        TermsTemplatesCompanion.insert(
          name: 'Default terms',
          content: content,
          isDefault: const Value(true),
        ),
      );
    } else {
      await (_database.update(_database.termsTemplates)
            ..where((row) => row.id.equals(current.id)))
          .write(
            TermsTemplatesCompanion(
              content: Value(content),
              updatedAt: Value(DateTime.now()),
            ),
          );
    }
  }

  static String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  static List<String> _cleanLines(List<String> lines) => lines
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList(growable: false);
}
