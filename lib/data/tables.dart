import 'package:drift/drift.dart';

@DataClassName('CompanyProfileData')
class CompanyProfiles extends Table {
  @override
  String get tableName => 'company_profile';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get companyName => text()();
  TextColumn get legalName => text().nullable()();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get phoneNumbers => text().withDefault(const Constant(''))();
  TextColumn get tagline => text().withDefault(const Constant(''))();
  TextColumn get signatory => text().withDefault(const Constant(''))();
  IntColumn get vatRateBasisPoints =>
      integer().withDefault(const Constant(1500))();
  TextColumn get vatNumber => text().nullable()();
  TextColumn get tinNumber => text().nullable()();
  TextColumn get supportedCurrencies =>
      text().withDefault(const Constant('USD,ZiG'))();
  TextColumn get logoPath => text().nullable()();
  TextColumn get signatureImagePath => text().nullable()();
  TextColumn get quotePrefix => text().withDefault(const Constant('QT-'))();
  TextColumn get invoicePrefix => text().withDefault(const Constant('INV-'))();
  TextColumn get receiptPrefix => text().withDefault(const Constant('RC-'))();
  IntColumn get numberPadding => integer().withDefault(const Constant(4))();
  IntColumn get defaultValidityDays =>
      integer().withDefault(const Constant(30))();
}

@DataClassName('CustomerData')
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('CatalogItemData')
class CatalogItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get designation => text()();
  TextColumn get unit => text().withDefault(const Constant(''))();
  IntColumn get defaultUnitPriceMinor => integer().nullable()();
  IntColumn get costPriceMinor => integer().nullable().customConstraint('CHECK (cost_price_minor IS NULL OR cost_price_minor >= 0)')();
  TextColumn get defaultPriceCurrencyCode =>
      text().withDefault(const Constant('USD'))();
  BoolColumn get isSection => boolean().withDefault(const Constant(false))();
  IntColumn get sectionId =>
      integer().nullable().references(CatalogItems, #id)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('DocumentData')
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get documentType => text()();
  TextColumn get status => text()();
  TextColumn get documentNumber => text().nullable().unique()();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  IntColumn get sourceQuoteId =>
      integer().nullable().unique().references(Documents, #id)();
  IntColumn get replacesDocumentId =>
      integer().nullable().references(Documents, #id)();
  TextColumn get currencyCode => text()();
  IntColumn get vatRateBasisPoints =>
      integer().withDefault(const Constant(1500))();
  TextColumn get discountKind => text().withDefault(const Constant('none'))();
  IntColumn get discountValue => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get termsSnapshot => text().withDefault(const Constant(''))();

  // Immutable customer and company details captured when the document is created.
  TextColumn get customerNameSnapshot =>
      text().withDefault(const Constant(''))();
  TextColumn get customerLocationSnapshot =>
      text().withDefault(const Constant(''))();
  TextColumn get customerPhoneSnapshot =>
      text().withDefault(const Constant(''))();
  TextColumn get companyNameSnapshot =>
      text().withDefault(const Constant(''))();
  TextColumn get legalNameSnapshot => text().withDefault(const Constant(''))();
  TextColumn get addressSnapshot => text().withDefault(const Constant(''))();
  TextColumn get phoneNumbersSnapshot =>
      text().withDefault(const Constant(''))();
  TextColumn get taglineSnapshot => text().withDefault(const Constant(''))();
  TextColumn get signatorySnapshot => text().withDefault(const Constant(''))();
  TextColumn get vatNumberSnapshot => text().nullable()();
  TextColumn get tinNumberSnapshot => text().nullable()();
  TextColumn get logoPathSnapshot => text().nullable()();

  IntColumn get validityDays => integer().withDefault(const Constant(30))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get issuedAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get voidedAt => dateTime().nullable()();
  TextColumn get voidReason => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('DocumentLineData')
class DocumentLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get documentId => integer().references(Documents, #id)();
  IntColumn get sortOrder => integer()();
  BoolColumn get isSectionHeader =>
      boolean().withDefault(const Constant(false))();
  TextColumn get designation => text()();
  TextColumn get unit => text().withDefault(const Constant(''))();
  IntColumn get unitPriceMinor => integer().nullable()();
  IntColumn get costPriceMinor => integer().nullable().customConstraint('CHECK (cost_price_minor IS NULL OR cost_price_minor >= 0)')();
  IntColumn get quantityMilli => integer().nullable()();
}

@DataClassName('ExpenseCategoryData')
class ExpenseCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  BoolColumn get isOverhead => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('ExpenseData')
@TableIndex(name: 'expenses_date_idx', columns: {#date})
@TableIndex(name: 'expenses_linked_invoice_idx', columns: {#linkedInvoiceId})
@TableIndex(name: 'expenses_currency_idx', columns: {#currencyCode})
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get amountMinor => integer().customConstraint('NOT NULL CHECK (amount_minor > 0)')();
  TextColumn get currencyCode => text()();
  IntColumn get categoryId => integer().references(ExpenseCategories, #id)();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get supplier => text().nullable()();
  TextColumn get paymentMethod => text()();
  IntColumn get linkedInvoiceId => integer().nullable().references(Documents, #id)();
  TextColumn get receiptPhotoPath => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('Active'))();
  IntColumn get reversalOfId => integer().nullable().unique().references(Expenses, #id)();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('PaymentData')
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  @ReferenceName('invoicePayments')
  IntColumn get invoiceId => integer().references(Documents, #id)();
  TextColumn get currencyCode => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get method => text()();
  DateTimeColumn get paidAt => dateTime()();
  TextColumn get entryType => text().withDefault(const Constant('payment'))();
  IntColumn get reversesPaymentId =>
      integer().nullable().unique().references(Payments, #id)();
  @ReferenceName('paymentReceipts')
  IntColumn get receiptDocumentId =>
      integer().nullable().unique().references(Documents, #id)();
  TextColumn get note => text().withDefault(const Constant(''))();
}

@DataClassName('TermsTemplateData')
class TermsTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get content => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('NumberSequenceData')
class NumberSequences extends Table {
  TextColumn get documentType => text()();
  TextColumn get prefix => text()();
  IntColumn get nextNumber => integer().withDefault(const Constant(1))();
  IntColumn get padding => integer().withDefault(const Constant(4))();

  @override
  Set<Column<Object>> get primaryKey => {documentType};
}

@DataClassName('AuditLogData')
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  IntColumn get entityId => integer()();
  TextColumn get action => text()();
  DateTimeColumn get occurredAt => dateTime().clientDefault(DateTime.now)();
  TextColumn get beforeSummary => text().nullable()();
  TextColumn get afterSummary => text().nullable()();
  TextColumn get actor => text().withDefault(const Constant('owner'))();
}
