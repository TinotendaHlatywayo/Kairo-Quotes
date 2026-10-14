// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CompanyProfilesTable extends CompanyProfiles
    with TableInfo<$CompanyProfilesTable, CompanyProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _legalNameMeta = const VerificationMeta(
    'legalName',
  );
  @override
  late final GeneratedColumn<String> legalName = GeneratedColumn<String>(
    'legal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneNumbersMeta = const VerificationMeta(
    'phoneNumbers',
  );
  @override
  late final GeneratedColumn<String> phoneNumbers = GeneratedColumn<String>(
    'phone_numbers',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _taglineMeta = const VerificationMeta(
    'tagline',
  );
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
    'tagline',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signatoryMeta = const VerificationMeta(
    'signatory',
  );
  @override
  late final GeneratedColumn<String> signatory = GeneratedColumn<String>(
    'signatory',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _vatRateBasisPointsMeta =
      const VerificationMeta('vatRateBasisPoints');
  @override
  late final GeneratedColumn<int> vatRateBasisPoints = GeneratedColumn<int>(
    'vat_rate_basis_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1500),
  );
  static const VerificationMeta _vatNumberMeta = const VerificationMeta(
    'vatNumber',
  );
  @override
  late final GeneratedColumn<String> vatNumber = GeneratedColumn<String>(
    'vat_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tinNumberMeta = const VerificationMeta(
    'tinNumber',
  );
  @override
  late final GeneratedColumn<String> tinNumber = GeneratedColumn<String>(
    'tin_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supportedCurrenciesMeta =
      const VerificationMeta('supportedCurrencies');
  @override
  late final GeneratedColumn<String> supportedCurrencies =
      GeneratedColumn<String>(
        'supported_currencies',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('USD,ZiG'),
      );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quotePrefixMeta = const VerificationMeta(
    'quotePrefix',
  );
  @override
  late final GeneratedColumn<String> quotePrefix = GeneratedColumn<String>(
    'quote_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('QT-'),
  );
  static const VerificationMeta _invoicePrefixMeta = const VerificationMeta(
    'invoicePrefix',
  );
  @override
  late final GeneratedColumn<String> invoicePrefix = GeneratedColumn<String>(
    'invoice_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INV-'),
  );
  static const VerificationMeta _receiptPrefixMeta = const VerificationMeta(
    'receiptPrefix',
  );
  @override
  late final GeneratedColumn<String> receiptPrefix = GeneratedColumn<String>(
    'receipt_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('RC-'),
  );
  static const VerificationMeta _numberPaddingMeta = const VerificationMeta(
    'numberPadding',
  );
  @override
  late final GeneratedColumn<int> numberPadding = GeneratedColumn<int>(
    'number_padding',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _defaultValidityDaysMeta =
      const VerificationMeta('defaultValidityDays');
  @override
  late final GeneratedColumn<int> defaultValidityDays = GeneratedColumn<int>(
    'default_validity_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyName,
    legalName,
    address,
    phoneNumbers,
    tagline,
    signatory,
    vatRateBasisPoints,
    vatNumber,
    tinNumber,
    supportedCurrencies,
    logoPath,
    quotePrefix,
    invoicePrefix,
    receiptPrefix,
    numberPadding,
    defaultValidityDays,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanyProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('legal_name')) {
      context.handle(
        _legalNameMeta,
        legalName.isAcceptableOrUnknown(data['legal_name']!, _legalNameMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone_numbers')) {
      context.handle(
        _phoneNumbersMeta,
        phoneNumbers.isAcceptableOrUnknown(
          data['phone_numbers']!,
          _phoneNumbersMeta,
        ),
      );
    }
    if (data.containsKey('tagline')) {
      context.handle(
        _taglineMeta,
        tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta),
      );
    }
    if (data.containsKey('signatory')) {
      context.handle(
        _signatoryMeta,
        signatory.isAcceptableOrUnknown(data['signatory']!, _signatoryMeta),
      );
    }
    if (data.containsKey('vat_rate_basis_points')) {
      context.handle(
        _vatRateBasisPointsMeta,
        vatRateBasisPoints.isAcceptableOrUnknown(
          data['vat_rate_basis_points']!,
          _vatRateBasisPointsMeta,
        ),
      );
    }
    if (data.containsKey('vat_number')) {
      context.handle(
        _vatNumberMeta,
        vatNumber.isAcceptableOrUnknown(data['vat_number']!, _vatNumberMeta),
      );
    }
    if (data.containsKey('tin_number')) {
      context.handle(
        _tinNumberMeta,
        tinNumber.isAcceptableOrUnknown(data['tin_number']!, _tinNumberMeta),
      );
    }
    if (data.containsKey('supported_currencies')) {
      context.handle(
        _supportedCurrenciesMeta,
        supportedCurrencies.isAcceptableOrUnknown(
          data['supported_currencies']!,
          _supportedCurrenciesMeta,
        ),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('quote_prefix')) {
      context.handle(
        _quotePrefixMeta,
        quotePrefix.isAcceptableOrUnknown(
          data['quote_prefix']!,
          _quotePrefixMeta,
        ),
      );
    }
    if (data.containsKey('invoice_prefix')) {
      context.handle(
        _invoicePrefixMeta,
        invoicePrefix.isAcceptableOrUnknown(
          data['invoice_prefix']!,
          _invoicePrefixMeta,
        ),
      );
    }
    if (data.containsKey('receipt_prefix')) {
      context.handle(
        _receiptPrefixMeta,
        receiptPrefix.isAcceptableOrUnknown(
          data['receipt_prefix']!,
          _receiptPrefixMeta,
        ),
      );
    }
    if (data.containsKey('number_padding')) {
      context.handle(
        _numberPaddingMeta,
        numberPadding.isAcceptableOrUnknown(
          data['number_padding']!,
          _numberPaddingMeta,
        ),
      );
    }
    if (data.containsKey('default_validity_days')) {
      context.handle(
        _defaultValidityDaysMeta,
        defaultValidityDays.isAcceptableOrUnknown(
          data['default_validity_days']!,
          _defaultValidityDaysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      legalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_name'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      phoneNumbers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_numbers'],
      )!,
      tagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline'],
      )!,
      signatory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signatory'],
      )!,
      vatRateBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_rate_basis_points'],
      )!,
      vatNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_number'],
      ),
      tinNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tin_number'],
      ),
      supportedCurrencies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supported_currencies'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      quotePrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_prefix'],
      )!,
      invoicePrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_prefix'],
      )!,
      receiptPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_prefix'],
      )!,
      numberPadding: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_padding'],
      )!,
      defaultValidityDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_validity_days'],
      )!,
    );
  }

  @override
  $CompanyProfilesTable createAlias(String alias) {
    return $CompanyProfilesTable(attachedDatabase, alias);
  }
}

class CompanyProfileData extends DataClass
    implements Insertable<CompanyProfileData> {
  final int id;
  final String companyName;
  final String? legalName;
  final String address;
  final String phoneNumbers;
  final String tagline;
  final String signatory;
  final int vatRateBasisPoints;
  final String? vatNumber;
  final String? tinNumber;
  final String supportedCurrencies;
  final String? logoPath;
  final String quotePrefix;
  final String invoicePrefix;
  final String receiptPrefix;
  final int numberPadding;
  final int defaultValidityDays;
  const CompanyProfileData({
    required this.id,
    required this.companyName,
    this.legalName,
    required this.address,
    required this.phoneNumbers,
    required this.tagline,
    required this.signatory,
    required this.vatRateBasisPoints,
    this.vatNumber,
    this.tinNumber,
    required this.supportedCurrencies,
    this.logoPath,
    required this.quotePrefix,
    required this.invoicePrefix,
    required this.receiptPrefix,
    required this.numberPadding,
    required this.defaultValidityDays,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['company_name'] = Variable<String>(companyName);
    if (!nullToAbsent || legalName != null) {
      map['legal_name'] = Variable<String>(legalName);
    }
    map['address'] = Variable<String>(address);
    map['phone_numbers'] = Variable<String>(phoneNumbers);
    map['tagline'] = Variable<String>(tagline);
    map['signatory'] = Variable<String>(signatory);
    map['vat_rate_basis_points'] = Variable<int>(vatRateBasisPoints);
    if (!nullToAbsent || vatNumber != null) {
      map['vat_number'] = Variable<String>(vatNumber);
    }
    if (!nullToAbsent || tinNumber != null) {
      map['tin_number'] = Variable<String>(tinNumber);
    }
    map['supported_currencies'] = Variable<String>(supportedCurrencies);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    map['quote_prefix'] = Variable<String>(quotePrefix);
    map['invoice_prefix'] = Variable<String>(invoicePrefix);
    map['receipt_prefix'] = Variable<String>(receiptPrefix);
    map['number_padding'] = Variable<int>(numberPadding);
    map['default_validity_days'] = Variable<int>(defaultValidityDays);
    return map;
  }

  CompanyProfilesCompanion toCompanion(bool nullToAbsent) {
    return CompanyProfilesCompanion(
      id: Value(id),
      companyName: Value(companyName),
      legalName: legalName == null && nullToAbsent
          ? const Value.absent()
          : Value(legalName),
      address: Value(address),
      phoneNumbers: Value(phoneNumbers),
      tagline: Value(tagline),
      signatory: Value(signatory),
      vatRateBasisPoints: Value(vatRateBasisPoints),
      vatNumber: vatNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(vatNumber),
      tinNumber: tinNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(tinNumber),
      supportedCurrencies: Value(supportedCurrencies),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      quotePrefix: Value(quotePrefix),
      invoicePrefix: Value(invoicePrefix),
      receiptPrefix: Value(receiptPrefix),
      numberPadding: Value(numberPadding),
      defaultValidityDays: Value(defaultValidityDays),
    );
  }

  factory CompanyProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyProfileData(
      id: serializer.fromJson<int>(json['id']),
      companyName: serializer.fromJson<String>(json['companyName']),
      legalName: serializer.fromJson<String?>(json['legalName']),
      address: serializer.fromJson<String>(json['address']),
      phoneNumbers: serializer.fromJson<String>(json['phoneNumbers']),
      tagline: serializer.fromJson<String>(json['tagline']),
      signatory: serializer.fromJson<String>(json['signatory']),
      vatRateBasisPoints: serializer.fromJson<int>(json['vatRateBasisPoints']),
      vatNumber: serializer.fromJson<String?>(json['vatNumber']),
      tinNumber: serializer.fromJson<String?>(json['tinNumber']),
      supportedCurrencies: serializer.fromJson<String>(
        json['supportedCurrencies'],
      ),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      quotePrefix: serializer.fromJson<String>(json['quotePrefix']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      receiptPrefix: serializer.fromJson<String>(json['receiptPrefix']),
      numberPadding: serializer.fromJson<int>(json['numberPadding']),
      defaultValidityDays: serializer.fromJson<int>(
        json['defaultValidityDays'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companyName': serializer.toJson<String>(companyName),
      'legalName': serializer.toJson<String?>(legalName),
      'address': serializer.toJson<String>(address),
      'phoneNumbers': serializer.toJson<String>(phoneNumbers),
      'tagline': serializer.toJson<String>(tagline),
      'signatory': serializer.toJson<String>(signatory),
      'vatRateBasisPoints': serializer.toJson<int>(vatRateBasisPoints),
      'vatNumber': serializer.toJson<String?>(vatNumber),
      'tinNumber': serializer.toJson<String?>(tinNumber),
      'supportedCurrencies': serializer.toJson<String>(supportedCurrencies),
      'logoPath': serializer.toJson<String?>(logoPath),
      'quotePrefix': serializer.toJson<String>(quotePrefix),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'receiptPrefix': serializer.toJson<String>(receiptPrefix),
      'numberPadding': serializer.toJson<int>(numberPadding),
      'defaultValidityDays': serializer.toJson<int>(defaultValidityDays),
    };
  }

  CompanyProfileData copyWith({
    int? id,
    String? companyName,
    Value<String?> legalName = const Value.absent(),
    String? address,
    String? phoneNumbers,
    String? tagline,
    String? signatory,
    int? vatRateBasisPoints,
    Value<String?> vatNumber = const Value.absent(),
    Value<String?> tinNumber = const Value.absent(),
    String? supportedCurrencies,
    Value<String?> logoPath = const Value.absent(),
    String? quotePrefix,
    String? invoicePrefix,
    String? receiptPrefix,
    int? numberPadding,
    int? defaultValidityDays,
  }) => CompanyProfileData(
    id: id ?? this.id,
    companyName: companyName ?? this.companyName,
    legalName: legalName.present ? legalName.value : this.legalName,
    address: address ?? this.address,
    phoneNumbers: phoneNumbers ?? this.phoneNumbers,
    tagline: tagline ?? this.tagline,
    signatory: signatory ?? this.signatory,
    vatRateBasisPoints: vatRateBasisPoints ?? this.vatRateBasisPoints,
    vatNumber: vatNumber.present ? vatNumber.value : this.vatNumber,
    tinNumber: tinNumber.present ? tinNumber.value : this.tinNumber,
    supportedCurrencies: supportedCurrencies ?? this.supportedCurrencies,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    quotePrefix: quotePrefix ?? this.quotePrefix,
    invoicePrefix: invoicePrefix ?? this.invoicePrefix,
    receiptPrefix: receiptPrefix ?? this.receiptPrefix,
    numberPadding: numberPadding ?? this.numberPadding,
    defaultValidityDays: defaultValidityDays ?? this.defaultValidityDays,
  );
  CompanyProfileData copyWithCompanion(CompanyProfilesCompanion data) {
    return CompanyProfileData(
      id: data.id.present ? data.id.value : this.id,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      legalName: data.legalName.present ? data.legalName.value : this.legalName,
      address: data.address.present ? data.address.value : this.address,
      phoneNumbers: data.phoneNumbers.present
          ? data.phoneNumbers.value
          : this.phoneNumbers,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      signatory: data.signatory.present ? data.signatory.value : this.signatory,
      vatRateBasisPoints: data.vatRateBasisPoints.present
          ? data.vatRateBasisPoints.value
          : this.vatRateBasisPoints,
      vatNumber: data.vatNumber.present ? data.vatNumber.value : this.vatNumber,
      tinNumber: data.tinNumber.present ? data.tinNumber.value : this.tinNumber,
      supportedCurrencies: data.supportedCurrencies.present
          ? data.supportedCurrencies.value
          : this.supportedCurrencies,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      quotePrefix: data.quotePrefix.present
          ? data.quotePrefix.value
          : this.quotePrefix,
      invoicePrefix: data.invoicePrefix.present
          ? data.invoicePrefix.value
          : this.invoicePrefix,
      receiptPrefix: data.receiptPrefix.present
          ? data.receiptPrefix.value
          : this.receiptPrefix,
      numberPadding: data.numberPadding.present
          ? data.numberPadding.value
          : this.numberPadding,
      defaultValidityDays: data.defaultValidityDays.present
          ? data.defaultValidityDays.value
          : this.defaultValidityDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyProfileData(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('legalName: $legalName, ')
          ..write('address: $address, ')
          ..write('phoneNumbers: $phoneNumbers, ')
          ..write('tagline: $tagline, ')
          ..write('signatory: $signatory, ')
          ..write('vatRateBasisPoints: $vatRateBasisPoints, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('tinNumber: $tinNumber, ')
          ..write('supportedCurrencies: $supportedCurrencies, ')
          ..write('logoPath: $logoPath, ')
          ..write('quotePrefix: $quotePrefix, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('receiptPrefix: $receiptPrefix, ')
          ..write('numberPadding: $numberPadding, ')
          ..write('defaultValidityDays: $defaultValidityDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyName,
    legalName,
    address,
    phoneNumbers,
    tagline,
    signatory,
    vatRateBasisPoints,
    vatNumber,
    tinNumber,
    supportedCurrencies,
    logoPath,
    quotePrefix,
    invoicePrefix,
    receiptPrefix,
    numberPadding,
    defaultValidityDays,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyProfileData &&
          other.id == this.id &&
          other.companyName == this.companyName &&
          other.legalName == this.legalName &&
          other.address == this.address &&
          other.phoneNumbers == this.phoneNumbers &&
          other.tagline == this.tagline &&
          other.signatory == this.signatory &&
          other.vatRateBasisPoints == this.vatRateBasisPoints &&
          other.vatNumber == this.vatNumber &&
          other.tinNumber == this.tinNumber &&
          other.supportedCurrencies == this.supportedCurrencies &&
          other.logoPath == this.logoPath &&
          other.quotePrefix == this.quotePrefix &&
          other.invoicePrefix == this.invoicePrefix &&
          other.receiptPrefix == this.receiptPrefix &&
          other.numberPadding == this.numberPadding &&
          other.defaultValidityDays == this.defaultValidityDays);
}

class CompanyProfilesCompanion extends UpdateCompanion<CompanyProfileData> {
  final Value<int> id;
  final Value<String> companyName;
  final Value<String?> legalName;
  final Value<String> address;
  final Value<String> phoneNumbers;
  final Value<String> tagline;
  final Value<String> signatory;
  final Value<int> vatRateBasisPoints;
  final Value<String?> vatNumber;
  final Value<String?> tinNumber;
  final Value<String> supportedCurrencies;
  final Value<String?> logoPath;
  final Value<String> quotePrefix;
  final Value<String> invoicePrefix;
  final Value<String> receiptPrefix;
  final Value<int> numberPadding;
  final Value<int> defaultValidityDays;
  const CompanyProfilesCompanion({
    this.id = const Value.absent(),
    this.companyName = const Value.absent(),
    this.legalName = const Value.absent(),
    this.address = const Value.absent(),
    this.phoneNumbers = const Value.absent(),
    this.tagline = const Value.absent(),
    this.signatory = const Value.absent(),
    this.vatRateBasisPoints = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.tinNumber = const Value.absent(),
    this.supportedCurrencies = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.quotePrefix = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.receiptPrefix = const Value.absent(),
    this.numberPadding = const Value.absent(),
    this.defaultValidityDays = const Value.absent(),
  });
  CompanyProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String companyName,
    this.legalName = const Value.absent(),
    this.address = const Value.absent(),
    this.phoneNumbers = const Value.absent(),
    this.tagline = const Value.absent(),
    this.signatory = const Value.absent(),
    this.vatRateBasisPoints = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.tinNumber = const Value.absent(),
    this.supportedCurrencies = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.quotePrefix = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.receiptPrefix = const Value.absent(),
    this.numberPadding = const Value.absent(),
    this.defaultValidityDays = const Value.absent(),
  }) : companyName = Value(companyName);
  static Insertable<CompanyProfileData> custom({
    Expression<int>? id,
    Expression<String>? companyName,
    Expression<String>? legalName,
    Expression<String>? address,
    Expression<String>? phoneNumbers,
    Expression<String>? tagline,
    Expression<String>? signatory,
    Expression<int>? vatRateBasisPoints,
    Expression<String>? vatNumber,
    Expression<String>? tinNumber,
    Expression<String>? supportedCurrencies,
    Expression<String>? logoPath,
    Expression<String>? quotePrefix,
    Expression<String>? invoicePrefix,
    Expression<String>? receiptPrefix,
    Expression<int>? numberPadding,
    Expression<int>? defaultValidityDays,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyName != null) 'company_name': companyName,
      if (legalName != null) 'legal_name': legalName,
      if (address != null) 'address': address,
      if (phoneNumbers != null) 'phone_numbers': phoneNumbers,
      if (tagline != null) 'tagline': tagline,
      if (signatory != null) 'signatory': signatory,
      if (vatRateBasisPoints != null)
        'vat_rate_basis_points': vatRateBasisPoints,
      if (vatNumber != null) 'vat_number': vatNumber,
      if (tinNumber != null) 'tin_number': tinNumber,
      if (supportedCurrencies != null)
        'supported_currencies': supportedCurrencies,
      if (logoPath != null) 'logo_path': logoPath,
      if (quotePrefix != null) 'quote_prefix': quotePrefix,
      if (invoicePrefix != null) 'invoice_prefix': invoicePrefix,
      if (receiptPrefix != null) 'receipt_prefix': receiptPrefix,
      if (numberPadding != null) 'number_padding': numberPadding,
      if (defaultValidityDays != null)
        'default_validity_days': defaultValidityDays,
    });
  }

  CompanyProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? companyName,
    Value<String?>? legalName,
    Value<String>? address,
    Value<String>? phoneNumbers,
    Value<String>? tagline,
    Value<String>? signatory,
    Value<int>? vatRateBasisPoints,
    Value<String?>? vatNumber,
    Value<String?>? tinNumber,
    Value<String>? supportedCurrencies,
    Value<String?>? logoPath,
    Value<String>? quotePrefix,
    Value<String>? invoicePrefix,
    Value<String>? receiptPrefix,
    Value<int>? numberPadding,
    Value<int>? defaultValidityDays,
  }) {
    return CompanyProfilesCompanion(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      legalName: legalName ?? this.legalName,
      address: address ?? this.address,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      tagline: tagline ?? this.tagline,
      signatory: signatory ?? this.signatory,
      vatRateBasisPoints: vatRateBasisPoints ?? this.vatRateBasisPoints,
      vatNumber: vatNumber ?? this.vatNumber,
      tinNumber: tinNumber ?? this.tinNumber,
      supportedCurrencies: supportedCurrencies ?? this.supportedCurrencies,
      logoPath: logoPath ?? this.logoPath,
      quotePrefix: quotePrefix ?? this.quotePrefix,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      receiptPrefix: receiptPrefix ?? this.receiptPrefix,
      numberPadding: numberPadding ?? this.numberPadding,
      defaultValidityDays: defaultValidityDays ?? this.defaultValidityDays,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (legalName.present) {
      map['legal_name'] = Variable<String>(legalName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phoneNumbers.present) {
      map['phone_numbers'] = Variable<String>(phoneNumbers.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (signatory.present) {
      map['signatory'] = Variable<String>(signatory.value);
    }
    if (vatRateBasisPoints.present) {
      map['vat_rate_basis_points'] = Variable<int>(vatRateBasisPoints.value);
    }
    if (vatNumber.present) {
      map['vat_number'] = Variable<String>(vatNumber.value);
    }
    if (tinNumber.present) {
      map['tin_number'] = Variable<String>(tinNumber.value);
    }
    if (supportedCurrencies.present) {
      map['supported_currencies'] = Variable<String>(supportedCurrencies.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (quotePrefix.present) {
      map['quote_prefix'] = Variable<String>(quotePrefix.value);
    }
    if (invoicePrefix.present) {
      map['invoice_prefix'] = Variable<String>(invoicePrefix.value);
    }
    if (receiptPrefix.present) {
      map['receipt_prefix'] = Variable<String>(receiptPrefix.value);
    }
    if (numberPadding.present) {
      map['number_padding'] = Variable<int>(numberPadding.value);
    }
    if (defaultValidityDays.present) {
      map['default_validity_days'] = Variable<int>(defaultValidityDays.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyProfilesCompanion(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('legalName: $legalName, ')
          ..write('address: $address, ')
          ..write('phoneNumbers: $phoneNumbers, ')
          ..write('tagline: $tagline, ')
          ..write('signatory: $signatory, ')
          ..write('vatRateBasisPoints: $vatRateBasisPoints, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('tinNumber: $tinNumber, ')
          ..write('supportedCurrencies: $supportedCurrencies, ')
          ..write('logoPath: $logoPath, ')
          ..write('quotePrefix: $quotePrefix, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('receiptPrefix: $receiptPrefix, ')
          ..write('numberPadding: $numberPadding, ')
          ..write('defaultValidityDays: $defaultValidityDays')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    phone,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerData extends DataClass implements Insertable<CustomerData> {
  final int id;
  final String name;
  final String location;
  final String phone;
  final String notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomerData({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['phone'] = Variable<String>(phone);
    map['notes'] = Variable<String>(notes);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      phone: Value(phone),
      notes: Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      phone: serializer.fromJson<String>(json['phone']),
      notes: serializer.fromJson<String>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'phone': serializer.toJson<String>(phone),
      'notes': serializer.toJson<String>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomerData copyWith({
    int? id,
    String? name,
    String? location,
    String? phone,
    String? notes,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomerData(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    phone: phone ?? this.phone,
    notes: notes ?? this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomerData copyWithCompanion(CustomersCompanion data) {
    return CustomerData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    location,
    phone,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerData &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersCompanion extends UpdateCompanion<CustomerData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> phone;
  final Value<String> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.location = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CustomerData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? phone,
    Value<String>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CatalogItemsTable extends CatalogItems
    with TableInfo<$CatalogItemsTable, CatalogItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatalogItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultUnitPriceMinorMeta =
      const VerificationMeta('defaultUnitPriceMinor');
  @override
  late final GeneratedColumn<int> defaultUnitPriceMinor = GeneratedColumn<int>(
    'default_unit_price_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultPriceCurrencyCodeMeta =
      const VerificationMeta('defaultPriceCurrencyCode');
  @override
  late final GeneratedColumn<String> defaultPriceCurrencyCode =
      GeneratedColumn<String>(
        'default_price_currency_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('USD'),
      );
  static const VerificationMeta _isSectionMeta = const VerificationMeta(
    'isSection',
  );
  @override
  late final GeneratedColumn<bool> isSection = GeneratedColumn<bool>(
    'is_section',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_section" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<int> sectionId = GeneratedColumn<int>(
    'section_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES catalog_items (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    designation,
    unit,
    defaultUnitPriceMinor,
    defaultPriceCurrencyCode,
    isSection,
    sectionId,
    sortOrder,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catalog_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatalogItemData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_designationMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('default_unit_price_minor')) {
      context.handle(
        _defaultUnitPriceMinorMeta,
        defaultUnitPriceMinor.isAcceptableOrUnknown(
          data['default_unit_price_minor']!,
          _defaultUnitPriceMinorMeta,
        ),
      );
    }
    if (data.containsKey('default_price_currency_code')) {
      context.handle(
        _defaultPriceCurrencyCodeMeta,
        defaultPriceCurrencyCode.isAcceptableOrUnknown(
          data['default_price_currency_code']!,
          _defaultPriceCurrencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('is_section')) {
      context.handle(
        _isSectionMeta,
        isSection.isAcceptableOrUnknown(data['is_section']!, _isSectionMeta),
      );
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatalogItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatalogItemData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      defaultUnitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_unit_price_minor'],
      ),
      defaultPriceCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_price_currency_code'],
      )!,
      isSection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_section'],
      )!,
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}section_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CatalogItemsTable createAlias(String alias) {
    return $CatalogItemsTable(attachedDatabase, alias);
  }
}

class CatalogItemData extends DataClass implements Insertable<CatalogItemData> {
  final int id;
  final String designation;
  final String unit;
  final int? defaultUnitPriceMinor;
  final String defaultPriceCurrencyCode;
  final bool isSection;
  final int? sectionId;
  final int sortOrder;
  final bool isArchived;
  final DateTime createdAt;
  const CatalogItemData({
    required this.id,
    required this.designation,
    required this.unit,
    this.defaultUnitPriceMinor,
    required this.defaultPriceCurrencyCode,
    required this.isSection,
    this.sectionId,
    required this.sortOrder,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['designation'] = Variable<String>(designation);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || defaultUnitPriceMinor != null) {
      map['default_unit_price_minor'] = Variable<int>(defaultUnitPriceMinor);
    }
    map['default_price_currency_code'] = Variable<String>(
      defaultPriceCurrencyCode,
    );
    map['is_section'] = Variable<bool>(isSection);
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<int>(sectionId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CatalogItemsCompanion toCompanion(bool nullToAbsent) {
    return CatalogItemsCompanion(
      id: Value(id),
      designation: Value(designation),
      unit: Value(unit),
      defaultUnitPriceMinor: defaultUnitPriceMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultUnitPriceMinor),
      defaultPriceCurrencyCode: Value(defaultPriceCurrencyCode),
      isSection: Value(isSection),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory CatalogItemData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatalogItemData(
      id: serializer.fromJson<int>(json['id']),
      designation: serializer.fromJson<String>(json['designation']),
      unit: serializer.fromJson<String>(json['unit']),
      defaultUnitPriceMinor: serializer.fromJson<int?>(
        json['defaultUnitPriceMinor'],
      ),
      defaultPriceCurrencyCode: serializer.fromJson<String>(
        json['defaultPriceCurrencyCode'],
      ),
      isSection: serializer.fromJson<bool>(json['isSection']),
      sectionId: serializer.fromJson<int?>(json['sectionId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'designation': serializer.toJson<String>(designation),
      'unit': serializer.toJson<String>(unit),
      'defaultUnitPriceMinor': serializer.toJson<int?>(defaultUnitPriceMinor),
      'defaultPriceCurrencyCode': serializer.toJson<String>(
        defaultPriceCurrencyCode,
      ),
      'isSection': serializer.toJson<bool>(isSection),
      'sectionId': serializer.toJson<int?>(sectionId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CatalogItemData copyWith({
    int? id,
    String? designation,
    String? unit,
    Value<int?> defaultUnitPriceMinor = const Value.absent(),
    String? defaultPriceCurrencyCode,
    bool? isSection,
    Value<int?> sectionId = const Value.absent(),
    int? sortOrder,
    bool? isArchived,
    DateTime? createdAt,
  }) => CatalogItemData(
    id: id ?? this.id,
    designation: designation ?? this.designation,
    unit: unit ?? this.unit,
    defaultUnitPriceMinor: defaultUnitPriceMinor.present
        ? defaultUnitPriceMinor.value
        : this.defaultUnitPriceMinor,
    defaultPriceCurrencyCode:
        defaultPriceCurrencyCode ?? this.defaultPriceCurrencyCode,
    isSection: isSection ?? this.isSection,
    sectionId: sectionId.present ? sectionId.value : this.sectionId,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  CatalogItemData copyWithCompanion(CatalogItemsCompanion data) {
    return CatalogItemData(
      id: data.id.present ? data.id.value : this.id,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      unit: data.unit.present ? data.unit.value : this.unit,
      defaultUnitPriceMinor: data.defaultUnitPriceMinor.present
          ? data.defaultUnitPriceMinor.value
          : this.defaultUnitPriceMinor,
      defaultPriceCurrencyCode: data.defaultPriceCurrencyCode.present
          ? data.defaultPriceCurrencyCode.value
          : this.defaultPriceCurrencyCode,
      isSection: data.isSection.present ? data.isSection.value : this.isSection,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatalogItemData(')
          ..write('id: $id, ')
          ..write('designation: $designation, ')
          ..write('unit: $unit, ')
          ..write('defaultUnitPriceMinor: $defaultUnitPriceMinor, ')
          ..write('defaultPriceCurrencyCode: $defaultPriceCurrencyCode, ')
          ..write('isSection: $isSection, ')
          ..write('sectionId: $sectionId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    designation,
    unit,
    defaultUnitPriceMinor,
    defaultPriceCurrencyCode,
    isSection,
    sectionId,
    sortOrder,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatalogItemData &&
          other.id == this.id &&
          other.designation == this.designation &&
          other.unit == this.unit &&
          other.defaultUnitPriceMinor == this.defaultUnitPriceMinor &&
          other.defaultPriceCurrencyCode == this.defaultPriceCurrencyCode &&
          other.isSection == this.isSection &&
          other.sectionId == this.sectionId &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class CatalogItemsCompanion extends UpdateCompanion<CatalogItemData> {
  final Value<int> id;
  final Value<String> designation;
  final Value<String> unit;
  final Value<int?> defaultUnitPriceMinor;
  final Value<String> defaultPriceCurrencyCode;
  final Value<bool> isSection;
  final Value<int?> sectionId;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const CatalogItemsCompanion({
    this.id = const Value.absent(),
    this.designation = const Value.absent(),
    this.unit = const Value.absent(),
    this.defaultUnitPriceMinor = const Value.absent(),
    this.defaultPriceCurrencyCode = const Value.absent(),
    this.isSection = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CatalogItemsCompanion.insert({
    this.id = const Value.absent(),
    required String designation,
    this.unit = const Value.absent(),
    this.defaultUnitPriceMinor = const Value.absent(),
    this.defaultPriceCurrencyCode = const Value.absent(),
    this.isSection = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : designation = Value(designation);
  static Insertable<CatalogItemData> custom({
    Expression<int>? id,
    Expression<String>? designation,
    Expression<String>? unit,
    Expression<int>? defaultUnitPriceMinor,
    Expression<String>? defaultPriceCurrencyCode,
    Expression<bool>? isSection,
    Expression<int>? sectionId,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (designation != null) 'designation': designation,
      if (unit != null) 'unit': unit,
      if (defaultUnitPriceMinor != null)
        'default_unit_price_minor': defaultUnitPriceMinor,
      if (defaultPriceCurrencyCode != null)
        'default_price_currency_code': defaultPriceCurrencyCode,
      if (isSection != null) 'is_section': isSection,
      if (sectionId != null) 'section_id': sectionId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CatalogItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? designation,
    Value<String>? unit,
    Value<int?>? defaultUnitPriceMinor,
    Value<String>? defaultPriceCurrencyCode,
    Value<bool>? isSection,
    Value<int?>? sectionId,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return CatalogItemsCompanion(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      unit: unit ?? this.unit,
      defaultUnitPriceMinor:
          defaultUnitPriceMinor ?? this.defaultUnitPriceMinor,
      defaultPriceCurrencyCode:
          defaultPriceCurrencyCode ?? this.defaultPriceCurrencyCode,
      isSection: isSection ?? this.isSection,
      sectionId: sectionId ?? this.sectionId,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (defaultUnitPriceMinor.present) {
      map['default_unit_price_minor'] = Variable<int>(
        defaultUnitPriceMinor.value,
      );
    }
    if (defaultPriceCurrencyCode.present) {
      map['default_price_currency_code'] = Variable<String>(
        defaultPriceCurrencyCode.value,
      );
    }
    if (isSection.present) {
      map['is_section'] = Variable<bool>(isSection.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<int>(sectionId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatalogItemsCompanion(')
          ..write('id: $id, ')
          ..write('designation: $designation, ')
          ..write('unit: $unit, ')
          ..write('defaultUnitPriceMinor: $defaultUnitPriceMinor, ')
          ..write('defaultPriceCurrencyCode: $defaultPriceCurrencyCode, ')
          ..write('isSection: $isSection, ')
          ..write('sectionId: $sectionId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, DocumentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _sourceQuoteIdMeta = const VerificationMeta(
    'sourceQuoteId',
  );
  @override
  late final GeneratedColumn<int> sourceQuoteId = GeneratedColumn<int>(
    'source_quote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _replacesDocumentIdMeta =
      const VerificationMeta('replacesDocumentId');
  @override
  late final GeneratedColumn<int> replacesDocumentId = GeneratedColumn<int>(
    'replaces_document_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatRateBasisPointsMeta =
      const VerificationMeta('vatRateBasisPoints');
  @override
  late final GeneratedColumn<int> vatRateBasisPoints = GeneratedColumn<int>(
    'vat_rate_basis_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1500),
  );
  static const VerificationMeta _discountKindMeta = const VerificationMeta(
    'discountKind',
  );
  @override
  late final GeneratedColumn<String> discountKind = GeneratedColumn<String>(
    'discount_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _discountValueMeta = const VerificationMeta(
    'discountValue',
  );
  @override
  late final GeneratedColumn<int> discountValue = GeneratedColumn<int>(
    'discount_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _termsSnapshotMeta = const VerificationMeta(
    'termsSnapshot',
  );
  @override
  late final GeneratedColumn<String> termsSnapshot = GeneratedColumn<String>(
    'terms_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _customerNameSnapshotMeta =
      const VerificationMeta('customerNameSnapshot');
  @override
  late final GeneratedColumn<String> customerNameSnapshot =
      GeneratedColumn<String>(
        'customer_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _customerLocationSnapshotMeta =
      const VerificationMeta('customerLocationSnapshot');
  @override
  late final GeneratedColumn<String> customerLocationSnapshot =
      GeneratedColumn<String>(
        'customer_location_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _customerPhoneSnapshotMeta =
      const VerificationMeta('customerPhoneSnapshot');
  @override
  late final GeneratedColumn<String> customerPhoneSnapshot =
      GeneratedColumn<String>(
        'customer_phone_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _companyNameSnapshotMeta =
      const VerificationMeta('companyNameSnapshot');
  @override
  late final GeneratedColumn<String> companyNameSnapshot =
      GeneratedColumn<String>(
        'company_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _legalNameSnapshotMeta = const VerificationMeta(
    'legalNameSnapshot',
  );
  @override
  late final GeneratedColumn<String> legalNameSnapshot =
      GeneratedColumn<String>(
        'legal_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _addressSnapshotMeta = const VerificationMeta(
    'addressSnapshot',
  );
  @override
  late final GeneratedColumn<String> addressSnapshot = GeneratedColumn<String>(
    'address_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneNumbersSnapshotMeta =
      const VerificationMeta('phoneNumbersSnapshot');
  @override
  late final GeneratedColumn<String> phoneNumbersSnapshot =
      GeneratedColumn<String>(
        'phone_numbers_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _taglineSnapshotMeta = const VerificationMeta(
    'taglineSnapshot',
  );
  @override
  late final GeneratedColumn<String> taglineSnapshot = GeneratedColumn<String>(
    'tagline_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signatorySnapshotMeta = const VerificationMeta(
    'signatorySnapshot',
  );
  @override
  late final GeneratedColumn<String> signatorySnapshot =
      GeneratedColumn<String>(
        'signatory_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _vatNumberSnapshotMeta = const VerificationMeta(
    'vatNumberSnapshot',
  );
  @override
  late final GeneratedColumn<String> vatNumberSnapshot =
      GeneratedColumn<String>(
        'vat_number_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tinNumberSnapshotMeta = const VerificationMeta(
    'tinNumberSnapshot',
  );
  @override
  late final GeneratedColumn<String> tinNumberSnapshot =
      GeneratedColumn<String>(
        'tin_number_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _logoPathSnapshotMeta = const VerificationMeta(
    'logoPathSnapshot',
  );
  @override
  late final GeneratedColumn<String> logoPathSnapshot = GeneratedColumn<String>(
    'logo_path_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validityDaysMeta = const VerificationMeta(
    'validityDays',
  );
  @override
  late final GeneratedColumn<int> validityDays = GeneratedColumn<int>(
    'validity_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voidedAtMeta = const VerificationMeta(
    'voidedAt',
  );
  @override
  late final GeneratedColumn<DateTime> voidedAt = GeneratedColumn<DateTime>(
    'voided_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voidReasonMeta = const VerificationMeta(
    'voidReason',
  );
  @override
  late final GeneratedColumn<String> voidReason = GeneratedColumn<String>(
    'void_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentType,
    status,
    documentNumber,
    customerId,
    sourceQuoteId,
    replacesDocumentId,
    currencyCode,
    vatRateBasisPoints,
    discountKind,
    discountValue,
    notes,
    termsSnapshot,
    customerNameSnapshot,
    customerLocationSnapshot,
    customerPhoneSnapshot,
    companyNameSnapshot,
    legalNameSnapshot,
    addressSnapshot,
    phoneNumbersSnapshot,
    taglineSnapshot,
    signatorySnapshot,
    vatNumberSnapshot,
    tinNumberSnapshot,
    logoPathSnapshot,
    validityDays,
    createdAt,
    issuedAt,
    expiresAt,
    voidedAt,
    voidReason,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('source_quote_id')) {
      context.handle(
        _sourceQuoteIdMeta,
        sourceQuoteId.isAcceptableOrUnknown(
          data['source_quote_id']!,
          _sourceQuoteIdMeta,
        ),
      );
    }
    if (data.containsKey('replaces_document_id')) {
      context.handle(
        _replacesDocumentIdMeta,
        replacesDocumentId.isAcceptableOrUnknown(
          data['replaces_document_id']!,
          _replacesDocumentIdMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('vat_rate_basis_points')) {
      context.handle(
        _vatRateBasisPointsMeta,
        vatRateBasisPoints.isAcceptableOrUnknown(
          data['vat_rate_basis_points']!,
          _vatRateBasisPointsMeta,
        ),
      );
    }
    if (data.containsKey('discount_kind')) {
      context.handle(
        _discountKindMeta,
        discountKind.isAcceptableOrUnknown(
          data['discount_kind']!,
          _discountKindMeta,
        ),
      );
    }
    if (data.containsKey('discount_value')) {
      context.handle(
        _discountValueMeta,
        discountValue.isAcceptableOrUnknown(
          data['discount_value']!,
          _discountValueMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('terms_snapshot')) {
      context.handle(
        _termsSnapshotMeta,
        termsSnapshot.isAcceptableOrUnknown(
          data['terms_snapshot']!,
          _termsSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('customer_name_snapshot')) {
      context.handle(
        _customerNameSnapshotMeta,
        customerNameSnapshot.isAcceptableOrUnknown(
          data['customer_name_snapshot']!,
          _customerNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('customer_location_snapshot')) {
      context.handle(
        _customerLocationSnapshotMeta,
        customerLocationSnapshot.isAcceptableOrUnknown(
          data['customer_location_snapshot']!,
          _customerLocationSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('customer_phone_snapshot')) {
      context.handle(
        _customerPhoneSnapshotMeta,
        customerPhoneSnapshot.isAcceptableOrUnknown(
          data['customer_phone_snapshot']!,
          _customerPhoneSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('company_name_snapshot')) {
      context.handle(
        _companyNameSnapshotMeta,
        companyNameSnapshot.isAcceptableOrUnknown(
          data['company_name_snapshot']!,
          _companyNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('legal_name_snapshot')) {
      context.handle(
        _legalNameSnapshotMeta,
        legalNameSnapshot.isAcceptableOrUnknown(
          data['legal_name_snapshot']!,
          _legalNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('address_snapshot')) {
      context.handle(
        _addressSnapshotMeta,
        addressSnapshot.isAcceptableOrUnknown(
          data['address_snapshot']!,
          _addressSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('phone_numbers_snapshot')) {
      context.handle(
        _phoneNumbersSnapshotMeta,
        phoneNumbersSnapshot.isAcceptableOrUnknown(
          data['phone_numbers_snapshot']!,
          _phoneNumbersSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('tagline_snapshot')) {
      context.handle(
        _taglineSnapshotMeta,
        taglineSnapshot.isAcceptableOrUnknown(
          data['tagline_snapshot']!,
          _taglineSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('signatory_snapshot')) {
      context.handle(
        _signatorySnapshotMeta,
        signatorySnapshot.isAcceptableOrUnknown(
          data['signatory_snapshot']!,
          _signatorySnapshotMeta,
        ),
      );
    }
    if (data.containsKey('vat_number_snapshot')) {
      context.handle(
        _vatNumberSnapshotMeta,
        vatNumberSnapshot.isAcceptableOrUnknown(
          data['vat_number_snapshot']!,
          _vatNumberSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('tin_number_snapshot')) {
      context.handle(
        _tinNumberSnapshotMeta,
        tinNumberSnapshot.isAcceptableOrUnknown(
          data['tin_number_snapshot']!,
          _tinNumberSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('logo_path_snapshot')) {
      context.handle(
        _logoPathSnapshotMeta,
        logoPathSnapshot.isAcceptableOrUnknown(
          data['logo_path_snapshot']!,
          _logoPathSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('validity_days')) {
      context.handle(
        _validityDaysMeta,
        validityDays.isAcceptableOrUnknown(
          data['validity_days']!,
          _validityDaysMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('voided_at')) {
      context.handle(
        _voidedAtMeta,
        voidedAt.isAcceptableOrUnknown(data['voided_at']!, _voidedAtMeta),
      );
    }
    if (data.containsKey('void_reason')) {
      context.handle(
        _voidReasonMeta,
        voidReason.isAcceptableOrUnknown(data['void_reason']!, _voidReasonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      sourceQuoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_quote_id'],
      ),
      replacesDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}replaces_document_id'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      vatRateBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_rate_basis_points'],
      )!,
      discountKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discount_kind'],
      )!,
      discountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_value'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      termsSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_snapshot'],
      )!,
      customerNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name_snapshot'],
      )!,
      customerLocationSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_location_snapshot'],
      )!,
      customerPhoneSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_phone_snapshot'],
      )!,
      companyNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name_snapshot'],
      )!,
      legalNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_name_snapshot'],
      )!,
      addressSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_snapshot'],
      )!,
      phoneNumbersSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_numbers_snapshot'],
      )!,
      taglineSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline_snapshot'],
      )!,
      signatorySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signatory_snapshot'],
      )!,
      vatNumberSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_number_snapshot'],
      ),
      tinNumberSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tin_number_snapshot'],
      ),
      logoPathSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path_snapshot'],
      ),
      validityDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}validity_days'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      voidedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}voided_at'],
      ),
      voidReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}void_reason'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class DocumentData extends DataClass implements Insertable<DocumentData> {
  final int id;
  final String documentType;
  final String status;
  final String? documentNumber;
  final int? customerId;
  final int? sourceQuoteId;
  final int? replacesDocumentId;
  final String currencyCode;
  final int vatRateBasisPoints;
  final String discountKind;
  final int discountValue;
  final String notes;
  final String termsSnapshot;
  final String customerNameSnapshot;
  final String customerLocationSnapshot;
  final String customerPhoneSnapshot;
  final String companyNameSnapshot;
  final String legalNameSnapshot;
  final String addressSnapshot;
  final String phoneNumbersSnapshot;
  final String taglineSnapshot;
  final String signatorySnapshot;
  final String? vatNumberSnapshot;
  final String? tinNumberSnapshot;
  final String? logoPathSnapshot;
  final int validityDays;
  final DateTime createdAt;
  final DateTime? issuedAt;
  final DateTime? expiresAt;
  final DateTime? voidedAt;
  final String? voidReason;
  final DateTime updatedAt;
  const DocumentData({
    required this.id,
    required this.documentType,
    required this.status,
    this.documentNumber,
    this.customerId,
    this.sourceQuoteId,
    this.replacesDocumentId,
    required this.currencyCode,
    required this.vatRateBasisPoints,
    required this.discountKind,
    required this.discountValue,
    required this.notes,
    required this.termsSnapshot,
    required this.customerNameSnapshot,
    required this.customerLocationSnapshot,
    required this.customerPhoneSnapshot,
    required this.companyNameSnapshot,
    required this.legalNameSnapshot,
    required this.addressSnapshot,
    required this.phoneNumbersSnapshot,
    required this.taglineSnapshot,
    required this.signatorySnapshot,
    this.vatNumberSnapshot,
    this.tinNumberSnapshot,
    this.logoPathSnapshot,
    required this.validityDays,
    required this.createdAt,
    this.issuedAt,
    this.expiresAt,
    this.voidedAt,
    this.voidReason,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_type'] = Variable<String>(documentType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || sourceQuoteId != null) {
      map['source_quote_id'] = Variable<int>(sourceQuoteId);
    }
    if (!nullToAbsent || replacesDocumentId != null) {
      map['replaces_document_id'] = Variable<int>(replacesDocumentId);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['vat_rate_basis_points'] = Variable<int>(vatRateBasisPoints);
    map['discount_kind'] = Variable<String>(discountKind);
    map['discount_value'] = Variable<int>(discountValue);
    map['notes'] = Variable<String>(notes);
    map['terms_snapshot'] = Variable<String>(termsSnapshot);
    map['customer_name_snapshot'] = Variable<String>(customerNameSnapshot);
    map['customer_location_snapshot'] = Variable<String>(
      customerLocationSnapshot,
    );
    map['customer_phone_snapshot'] = Variable<String>(customerPhoneSnapshot);
    map['company_name_snapshot'] = Variable<String>(companyNameSnapshot);
    map['legal_name_snapshot'] = Variable<String>(legalNameSnapshot);
    map['address_snapshot'] = Variable<String>(addressSnapshot);
    map['phone_numbers_snapshot'] = Variable<String>(phoneNumbersSnapshot);
    map['tagline_snapshot'] = Variable<String>(taglineSnapshot);
    map['signatory_snapshot'] = Variable<String>(signatorySnapshot);
    if (!nullToAbsent || vatNumberSnapshot != null) {
      map['vat_number_snapshot'] = Variable<String>(vatNumberSnapshot);
    }
    if (!nullToAbsent || tinNumberSnapshot != null) {
      map['tin_number_snapshot'] = Variable<String>(tinNumberSnapshot);
    }
    if (!nullToAbsent || logoPathSnapshot != null) {
      map['logo_path_snapshot'] = Variable<String>(logoPathSnapshot);
    }
    map['validity_days'] = Variable<int>(validityDays);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || issuedAt != null) {
      map['issued_at'] = Variable<DateTime>(issuedAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    if (!nullToAbsent || voidedAt != null) {
      map['voided_at'] = Variable<DateTime>(voidedAt);
    }
    if (!nullToAbsent || voidReason != null) {
      map['void_reason'] = Variable<String>(voidReason);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      documentType: Value(documentType),
      status: Value(status),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      sourceQuoteId: sourceQuoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceQuoteId),
      replacesDocumentId: replacesDocumentId == null && nullToAbsent
          ? const Value.absent()
          : Value(replacesDocumentId),
      currencyCode: Value(currencyCode),
      vatRateBasisPoints: Value(vatRateBasisPoints),
      discountKind: Value(discountKind),
      discountValue: Value(discountValue),
      notes: Value(notes),
      termsSnapshot: Value(termsSnapshot),
      customerNameSnapshot: Value(customerNameSnapshot),
      customerLocationSnapshot: Value(customerLocationSnapshot),
      customerPhoneSnapshot: Value(customerPhoneSnapshot),
      companyNameSnapshot: Value(companyNameSnapshot),
      legalNameSnapshot: Value(legalNameSnapshot),
      addressSnapshot: Value(addressSnapshot),
      phoneNumbersSnapshot: Value(phoneNumbersSnapshot),
      taglineSnapshot: Value(taglineSnapshot),
      signatorySnapshot: Value(signatorySnapshot),
      vatNumberSnapshot: vatNumberSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(vatNumberSnapshot),
      tinNumberSnapshot: tinNumberSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(tinNumberSnapshot),
      logoPathSnapshot: logoPathSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPathSnapshot),
      validityDays: Value(validityDays),
      createdAt: Value(createdAt),
      issuedAt: issuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(issuedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      voidedAt: voidedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(voidedAt),
      voidReason: voidReason == null && nullToAbsent
          ? const Value.absent()
          : Value(voidReason),
      updatedAt: Value(updatedAt),
    );
  }

  factory DocumentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentData(
      id: serializer.fromJson<int>(json['id']),
      documentType: serializer.fromJson<String>(json['documentType']),
      status: serializer.fromJson<String>(json['status']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      sourceQuoteId: serializer.fromJson<int?>(json['sourceQuoteId']),
      replacesDocumentId: serializer.fromJson<int?>(json['replacesDocumentId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      vatRateBasisPoints: serializer.fromJson<int>(json['vatRateBasisPoints']),
      discountKind: serializer.fromJson<String>(json['discountKind']),
      discountValue: serializer.fromJson<int>(json['discountValue']),
      notes: serializer.fromJson<String>(json['notes']),
      termsSnapshot: serializer.fromJson<String>(json['termsSnapshot']),
      customerNameSnapshot: serializer.fromJson<String>(
        json['customerNameSnapshot'],
      ),
      customerLocationSnapshot: serializer.fromJson<String>(
        json['customerLocationSnapshot'],
      ),
      customerPhoneSnapshot: serializer.fromJson<String>(
        json['customerPhoneSnapshot'],
      ),
      companyNameSnapshot: serializer.fromJson<String>(
        json['companyNameSnapshot'],
      ),
      legalNameSnapshot: serializer.fromJson<String>(json['legalNameSnapshot']),
      addressSnapshot: serializer.fromJson<String>(json['addressSnapshot']),
      phoneNumbersSnapshot: serializer.fromJson<String>(
        json['phoneNumbersSnapshot'],
      ),
      taglineSnapshot: serializer.fromJson<String>(json['taglineSnapshot']),
      signatorySnapshot: serializer.fromJson<String>(json['signatorySnapshot']),
      vatNumberSnapshot: serializer.fromJson<String?>(
        json['vatNumberSnapshot'],
      ),
      tinNumberSnapshot: serializer.fromJson<String?>(
        json['tinNumberSnapshot'],
      ),
      logoPathSnapshot: serializer.fromJson<String?>(json['logoPathSnapshot']),
      validityDays: serializer.fromJson<int>(json['validityDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      issuedAt: serializer.fromJson<DateTime?>(json['issuedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      voidedAt: serializer.fromJson<DateTime?>(json['voidedAt']),
      voidReason: serializer.fromJson<String?>(json['voidReason']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentType': serializer.toJson<String>(documentType),
      'status': serializer.toJson<String>(status),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'customerId': serializer.toJson<int?>(customerId),
      'sourceQuoteId': serializer.toJson<int?>(sourceQuoteId),
      'replacesDocumentId': serializer.toJson<int?>(replacesDocumentId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'vatRateBasisPoints': serializer.toJson<int>(vatRateBasisPoints),
      'discountKind': serializer.toJson<String>(discountKind),
      'discountValue': serializer.toJson<int>(discountValue),
      'notes': serializer.toJson<String>(notes),
      'termsSnapshot': serializer.toJson<String>(termsSnapshot),
      'customerNameSnapshot': serializer.toJson<String>(customerNameSnapshot),
      'customerLocationSnapshot': serializer.toJson<String>(
        customerLocationSnapshot,
      ),
      'customerPhoneSnapshot': serializer.toJson<String>(customerPhoneSnapshot),
      'companyNameSnapshot': serializer.toJson<String>(companyNameSnapshot),
      'legalNameSnapshot': serializer.toJson<String>(legalNameSnapshot),
      'addressSnapshot': serializer.toJson<String>(addressSnapshot),
      'phoneNumbersSnapshot': serializer.toJson<String>(phoneNumbersSnapshot),
      'taglineSnapshot': serializer.toJson<String>(taglineSnapshot),
      'signatorySnapshot': serializer.toJson<String>(signatorySnapshot),
      'vatNumberSnapshot': serializer.toJson<String?>(vatNumberSnapshot),
      'tinNumberSnapshot': serializer.toJson<String?>(tinNumberSnapshot),
      'logoPathSnapshot': serializer.toJson<String?>(logoPathSnapshot),
      'validityDays': serializer.toJson<int>(validityDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'issuedAt': serializer.toJson<DateTime?>(issuedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'voidedAt': serializer.toJson<DateTime?>(voidedAt),
      'voidReason': serializer.toJson<String?>(voidReason),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DocumentData copyWith({
    int? id,
    String? documentType,
    String? status,
    Value<String?> documentNumber = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    Value<int?> sourceQuoteId = const Value.absent(),
    Value<int?> replacesDocumentId = const Value.absent(),
    String? currencyCode,
    int? vatRateBasisPoints,
    String? discountKind,
    int? discountValue,
    String? notes,
    String? termsSnapshot,
    String? customerNameSnapshot,
    String? customerLocationSnapshot,
    String? customerPhoneSnapshot,
    String? companyNameSnapshot,
    String? legalNameSnapshot,
    String? addressSnapshot,
    String? phoneNumbersSnapshot,
    String? taglineSnapshot,
    String? signatorySnapshot,
    Value<String?> vatNumberSnapshot = const Value.absent(),
    Value<String?> tinNumberSnapshot = const Value.absent(),
    Value<String?> logoPathSnapshot = const Value.absent(),
    int? validityDays,
    DateTime? createdAt,
    Value<DateTime?> issuedAt = const Value.absent(),
    Value<DateTime?> expiresAt = const Value.absent(),
    Value<DateTime?> voidedAt = const Value.absent(),
    Value<String?> voidReason = const Value.absent(),
    DateTime? updatedAt,
  }) => DocumentData(
    id: id ?? this.id,
    documentType: documentType ?? this.documentType,
    status: status ?? this.status,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    customerId: customerId.present ? customerId.value : this.customerId,
    sourceQuoteId: sourceQuoteId.present
        ? sourceQuoteId.value
        : this.sourceQuoteId,
    replacesDocumentId: replacesDocumentId.present
        ? replacesDocumentId.value
        : this.replacesDocumentId,
    currencyCode: currencyCode ?? this.currencyCode,
    vatRateBasisPoints: vatRateBasisPoints ?? this.vatRateBasisPoints,
    discountKind: discountKind ?? this.discountKind,
    discountValue: discountValue ?? this.discountValue,
    notes: notes ?? this.notes,
    termsSnapshot: termsSnapshot ?? this.termsSnapshot,
    customerNameSnapshot: customerNameSnapshot ?? this.customerNameSnapshot,
    customerLocationSnapshot:
        customerLocationSnapshot ?? this.customerLocationSnapshot,
    customerPhoneSnapshot: customerPhoneSnapshot ?? this.customerPhoneSnapshot,
    companyNameSnapshot: companyNameSnapshot ?? this.companyNameSnapshot,
    legalNameSnapshot: legalNameSnapshot ?? this.legalNameSnapshot,
    addressSnapshot: addressSnapshot ?? this.addressSnapshot,
    phoneNumbersSnapshot: phoneNumbersSnapshot ?? this.phoneNumbersSnapshot,
    taglineSnapshot: taglineSnapshot ?? this.taglineSnapshot,
    signatorySnapshot: signatorySnapshot ?? this.signatorySnapshot,
    vatNumberSnapshot: vatNumberSnapshot.present
        ? vatNumberSnapshot.value
        : this.vatNumberSnapshot,
    tinNumberSnapshot: tinNumberSnapshot.present
        ? tinNumberSnapshot.value
        : this.tinNumberSnapshot,
    logoPathSnapshot: logoPathSnapshot.present
        ? logoPathSnapshot.value
        : this.logoPathSnapshot,
    validityDays: validityDays ?? this.validityDays,
    createdAt: createdAt ?? this.createdAt,
    issuedAt: issuedAt.present ? issuedAt.value : this.issuedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    voidedAt: voidedAt.present ? voidedAt.value : this.voidedAt,
    voidReason: voidReason.present ? voidReason.value : this.voidReason,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DocumentData copyWithCompanion(DocumentsCompanion data) {
    return DocumentData(
      id: data.id.present ? data.id.value : this.id,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      status: data.status.present ? data.status.value : this.status,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      sourceQuoteId: data.sourceQuoteId.present
          ? data.sourceQuoteId.value
          : this.sourceQuoteId,
      replacesDocumentId: data.replacesDocumentId.present
          ? data.replacesDocumentId.value
          : this.replacesDocumentId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      vatRateBasisPoints: data.vatRateBasisPoints.present
          ? data.vatRateBasisPoints.value
          : this.vatRateBasisPoints,
      discountKind: data.discountKind.present
          ? data.discountKind.value
          : this.discountKind,
      discountValue: data.discountValue.present
          ? data.discountValue.value
          : this.discountValue,
      notes: data.notes.present ? data.notes.value : this.notes,
      termsSnapshot: data.termsSnapshot.present
          ? data.termsSnapshot.value
          : this.termsSnapshot,
      customerNameSnapshot: data.customerNameSnapshot.present
          ? data.customerNameSnapshot.value
          : this.customerNameSnapshot,
      customerLocationSnapshot: data.customerLocationSnapshot.present
          ? data.customerLocationSnapshot.value
          : this.customerLocationSnapshot,
      customerPhoneSnapshot: data.customerPhoneSnapshot.present
          ? data.customerPhoneSnapshot.value
          : this.customerPhoneSnapshot,
      companyNameSnapshot: data.companyNameSnapshot.present
          ? data.companyNameSnapshot.value
          : this.companyNameSnapshot,
      legalNameSnapshot: data.legalNameSnapshot.present
          ? data.legalNameSnapshot.value
          : this.legalNameSnapshot,
      addressSnapshot: data.addressSnapshot.present
          ? data.addressSnapshot.value
          : this.addressSnapshot,
      phoneNumbersSnapshot: data.phoneNumbersSnapshot.present
          ? data.phoneNumbersSnapshot.value
          : this.phoneNumbersSnapshot,
      taglineSnapshot: data.taglineSnapshot.present
          ? data.taglineSnapshot.value
          : this.taglineSnapshot,
      signatorySnapshot: data.signatorySnapshot.present
          ? data.signatorySnapshot.value
          : this.signatorySnapshot,
      vatNumberSnapshot: data.vatNumberSnapshot.present
          ? data.vatNumberSnapshot.value
          : this.vatNumberSnapshot,
      tinNumberSnapshot: data.tinNumberSnapshot.present
          ? data.tinNumberSnapshot.value
          : this.tinNumberSnapshot,
      logoPathSnapshot: data.logoPathSnapshot.present
          ? data.logoPathSnapshot.value
          : this.logoPathSnapshot,
      validityDays: data.validityDays.present
          ? data.validityDays.value
          : this.validityDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      voidedAt: data.voidedAt.present ? data.voidedAt.value : this.voidedAt,
      voidReason: data.voidReason.present
          ? data.voidReason.value
          : this.voidReason,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentData(')
          ..write('id: $id, ')
          ..write('documentType: $documentType, ')
          ..write('status: $status, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('customerId: $customerId, ')
          ..write('sourceQuoteId: $sourceQuoteId, ')
          ..write('replacesDocumentId: $replacesDocumentId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('vatRateBasisPoints: $vatRateBasisPoints, ')
          ..write('discountKind: $discountKind, ')
          ..write('discountValue: $discountValue, ')
          ..write('notes: $notes, ')
          ..write('termsSnapshot: $termsSnapshot, ')
          ..write('customerNameSnapshot: $customerNameSnapshot, ')
          ..write('customerLocationSnapshot: $customerLocationSnapshot, ')
          ..write('customerPhoneSnapshot: $customerPhoneSnapshot, ')
          ..write('companyNameSnapshot: $companyNameSnapshot, ')
          ..write('legalNameSnapshot: $legalNameSnapshot, ')
          ..write('addressSnapshot: $addressSnapshot, ')
          ..write('phoneNumbersSnapshot: $phoneNumbersSnapshot, ')
          ..write('taglineSnapshot: $taglineSnapshot, ')
          ..write('signatorySnapshot: $signatorySnapshot, ')
          ..write('vatNumberSnapshot: $vatNumberSnapshot, ')
          ..write('tinNumberSnapshot: $tinNumberSnapshot, ')
          ..write('logoPathSnapshot: $logoPathSnapshot, ')
          ..write('validityDays: $validityDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('voidedAt: $voidedAt, ')
          ..write('voidReason: $voidReason, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    documentType,
    status,
    documentNumber,
    customerId,
    sourceQuoteId,
    replacesDocumentId,
    currencyCode,
    vatRateBasisPoints,
    discountKind,
    discountValue,
    notes,
    termsSnapshot,
    customerNameSnapshot,
    customerLocationSnapshot,
    customerPhoneSnapshot,
    companyNameSnapshot,
    legalNameSnapshot,
    addressSnapshot,
    phoneNumbersSnapshot,
    taglineSnapshot,
    signatorySnapshot,
    vatNumberSnapshot,
    tinNumberSnapshot,
    logoPathSnapshot,
    validityDays,
    createdAt,
    issuedAt,
    expiresAt,
    voidedAt,
    voidReason,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentData &&
          other.id == this.id &&
          other.documentType == this.documentType &&
          other.status == this.status &&
          other.documentNumber == this.documentNumber &&
          other.customerId == this.customerId &&
          other.sourceQuoteId == this.sourceQuoteId &&
          other.replacesDocumentId == this.replacesDocumentId &&
          other.currencyCode == this.currencyCode &&
          other.vatRateBasisPoints == this.vatRateBasisPoints &&
          other.discountKind == this.discountKind &&
          other.discountValue == this.discountValue &&
          other.notes == this.notes &&
          other.termsSnapshot == this.termsSnapshot &&
          other.customerNameSnapshot == this.customerNameSnapshot &&
          other.customerLocationSnapshot == this.customerLocationSnapshot &&
          other.customerPhoneSnapshot == this.customerPhoneSnapshot &&
          other.companyNameSnapshot == this.companyNameSnapshot &&
          other.legalNameSnapshot == this.legalNameSnapshot &&
          other.addressSnapshot == this.addressSnapshot &&
          other.phoneNumbersSnapshot == this.phoneNumbersSnapshot &&
          other.taglineSnapshot == this.taglineSnapshot &&
          other.signatorySnapshot == this.signatorySnapshot &&
          other.vatNumberSnapshot == this.vatNumberSnapshot &&
          other.tinNumberSnapshot == this.tinNumberSnapshot &&
          other.logoPathSnapshot == this.logoPathSnapshot &&
          other.validityDays == this.validityDays &&
          other.createdAt == this.createdAt &&
          other.issuedAt == this.issuedAt &&
          other.expiresAt == this.expiresAt &&
          other.voidedAt == this.voidedAt &&
          other.voidReason == this.voidReason &&
          other.updatedAt == this.updatedAt);
}

class DocumentsCompanion extends UpdateCompanion<DocumentData> {
  final Value<int> id;
  final Value<String> documentType;
  final Value<String> status;
  final Value<String?> documentNumber;
  final Value<int?> customerId;
  final Value<int?> sourceQuoteId;
  final Value<int?> replacesDocumentId;
  final Value<String> currencyCode;
  final Value<int> vatRateBasisPoints;
  final Value<String> discountKind;
  final Value<int> discountValue;
  final Value<String> notes;
  final Value<String> termsSnapshot;
  final Value<String> customerNameSnapshot;
  final Value<String> customerLocationSnapshot;
  final Value<String> customerPhoneSnapshot;
  final Value<String> companyNameSnapshot;
  final Value<String> legalNameSnapshot;
  final Value<String> addressSnapshot;
  final Value<String> phoneNumbersSnapshot;
  final Value<String> taglineSnapshot;
  final Value<String> signatorySnapshot;
  final Value<String?> vatNumberSnapshot;
  final Value<String?> tinNumberSnapshot;
  final Value<String?> logoPathSnapshot;
  final Value<int> validityDays;
  final Value<DateTime> createdAt;
  final Value<DateTime?> issuedAt;
  final Value<DateTime?> expiresAt;
  final Value<DateTime?> voidedAt;
  final Value<String?> voidReason;
  final Value<DateTime> updatedAt;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.documentType = const Value.absent(),
    this.status = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.sourceQuoteId = const Value.absent(),
    this.replacesDocumentId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.vatRateBasisPoints = const Value.absent(),
    this.discountKind = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.notes = const Value.absent(),
    this.termsSnapshot = const Value.absent(),
    this.customerNameSnapshot = const Value.absent(),
    this.customerLocationSnapshot = const Value.absent(),
    this.customerPhoneSnapshot = const Value.absent(),
    this.companyNameSnapshot = const Value.absent(),
    this.legalNameSnapshot = const Value.absent(),
    this.addressSnapshot = const Value.absent(),
    this.phoneNumbersSnapshot = const Value.absent(),
    this.taglineSnapshot = const Value.absent(),
    this.signatorySnapshot = const Value.absent(),
    this.vatNumberSnapshot = const Value.absent(),
    this.tinNumberSnapshot = const Value.absent(),
    this.logoPathSnapshot = const Value.absent(),
    this.validityDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.voidedAt = const Value.absent(),
    this.voidReason = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String documentType,
    required String status,
    this.documentNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.sourceQuoteId = const Value.absent(),
    this.replacesDocumentId = const Value.absent(),
    required String currencyCode,
    this.vatRateBasisPoints = const Value.absent(),
    this.discountKind = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.notes = const Value.absent(),
    this.termsSnapshot = const Value.absent(),
    this.customerNameSnapshot = const Value.absent(),
    this.customerLocationSnapshot = const Value.absent(),
    this.customerPhoneSnapshot = const Value.absent(),
    this.companyNameSnapshot = const Value.absent(),
    this.legalNameSnapshot = const Value.absent(),
    this.addressSnapshot = const Value.absent(),
    this.phoneNumbersSnapshot = const Value.absent(),
    this.taglineSnapshot = const Value.absent(),
    this.signatorySnapshot = const Value.absent(),
    this.vatNumberSnapshot = const Value.absent(),
    this.tinNumberSnapshot = const Value.absent(),
    this.logoPathSnapshot = const Value.absent(),
    this.validityDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.voidedAt = const Value.absent(),
    this.voidReason = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : documentType = Value(documentType),
       status = Value(status),
       currencyCode = Value(currencyCode);
  static Insertable<DocumentData> custom({
    Expression<int>? id,
    Expression<String>? documentType,
    Expression<String>? status,
    Expression<String>? documentNumber,
    Expression<int>? customerId,
    Expression<int>? sourceQuoteId,
    Expression<int>? replacesDocumentId,
    Expression<String>? currencyCode,
    Expression<int>? vatRateBasisPoints,
    Expression<String>? discountKind,
    Expression<int>? discountValue,
    Expression<String>? notes,
    Expression<String>? termsSnapshot,
    Expression<String>? customerNameSnapshot,
    Expression<String>? customerLocationSnapshot,
    Expression<String>? customerPhoneSnapshot,
    Expression<String>? companyNameSnapshot,
    Expression<String>? legalNameSnapshot,
    Expression<String>? addressSnapshot,
    Expression<String>? phoneNumbersSnapshot,
    Expression<String>? taglineSnapshot,
    Expression<String>? signatorySnapshot,
    Expression<String>? vatNumberSnapshot,
    Expression<String>? tinNumberSnapshot,
    Expression<String>? logoPathSnapshot,
    Expression<int>? validityDays,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? issuedAt,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? voidedAt,
    Expression<String>? voidReason,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentType != null) 'document_type': documentType,
      if (status != null) 'status': status,
      if (documentNumber != null) 'document_number': documentNumber,
      if (customerId != null) 'customer_id': customerId,
      if (sourceQuoteId != null) 'source_quote_id': sourceQuoteId,
      if (replacesDocumentId != null)
        'replaces_document_id': replacesDocumentId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (vatRateBasisPoints != null)
        'vat_rate_basis_points': vatRateBasisPoints,
      if (discountKind != null) 'discount_kind': discountKind,
      if (discountValue != null) 'discount_value': discountValue,
      if (notes != null) 'notes': notes,
      if (termsSnapshot != null) 'terms_snapshot': termsSnapshot,
      if (customerNameSnapshot != null)
        'customer_name_snapshot': customerNameSnapshot,
      if (customerLocationSnapshot != null)
        'customer_location_snapshot': customerLocationSnapshot,
      if (customerPhoneSnapshot != null)
        'customer_phone_snapshot': customerPhoneSnapshot,
      if (companyNameSnapshot != null)
        'company_name_snapshot': companyNameSnapshot,
      if (legalNameSnapshot != null) 'legal_name_snapshot': legalNameSnapshot,
      if (addressSnapshot != null) 'address_snapshot': addressSnapshot,
      if (phoneNumbersSnapshot != null)
        'phone_numbers_snapshot': phoneNumbersSnapshot,
      if (taglineSnapshot != null) 'tagline_snapshot': taglineSnapshot,
      if (signatorySnapshot != null) 'signatory_snapshot': signatorySnapshot,
      if (vatNumberSnapshot != null) 'vat_number_snapshot': vatNumberSnapshot,
      if (tinNumberSnapshot != null) 'tin_number_snapshot': tinNumberSnapshot,
      if (logoPathSnapshot != null) 'logo_path_snapshot': logoPathSnapshot,
      if (validityDays != null) 'validity_days': validityDays,
      if (createdAt != null) 'created_at': createdAt,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (voidedAt != null) 'voided_at': voidedAt,
      if (voidReason != null) 'void_reason': voidReason,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? documentType,
    Value<String>? status,
    Value<String?>? documentNumber,
    Value<int?>? customerId,
    Value<int?>? sourceQuoteId,
    Value<int?>? replacesDocumentId,
    Value<String>? currencyCode,
    Value<int>? vatRateBasisPoints,
    Value<String>? discountKind,
    Value<int>? discountValue,
    Value<String>? notes,
    Value<String>? termsSnapshot,
    Value<String>? customerNameSnapshot,
    Value<String>? customerLocationSnapshot,
    Value<String>? customerPhoneSnapshot,
    Value<String>? companyNameSnapshot,
    Value<String>? legalNameSnapshot,
    Value<String>? addressSnapshot,
    Value<String>? phoneNumbersSnapshot,
    Value<String>? taglineSnapshot,
    Value<String>? signatorySnapshot,
    Value<String?>? vatNumberSnapshot,
    Value<String?>? tinNumberSnapshot,
    Value<String?>? logoPathSnapshot,
    Value<int>? validityDays,
    Value<DateTime>? createdAt,
    Value<DateTime?>? issuedAt,
    Value<DateTime?>? expiresAt,
    Value<DateTime?>? voidedAt,
    Value<String?>? voidReason,
    Value<DateTime>? updatedAt,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      documentType: documentType ?? this.documentType,
      status: status ?? this.status,
      documentNumber: documentNumber ?? this.documentNumber,
      customerId: customerId ?? this.customerId,
      sourceQuoteId: sourceQuoteId ?? this.sourceQuoteId,
      replacesDocumentId: replacesDocumentId ?? this.replacesDocumentId,
      currencyCode: currencyCode ?? this.currencyCode,
      vatRateBasisPoints: vatRateBasisPoints ?? this.vatRateBasisPoints,
      discountKind: discountKind ?? this.discountKind,
      discountValue: discountValue ?? this.discountValue,
      notes: notes ?? this.notes,
      termsSnapshot: termsSnapshot ?? this.termsSnapshot,
      customerNameSnapshot: customerNameSnapshot ?? this.customerNameSnapshot,
      customerLocationSnapshot:
          customerLocationSnapshot ?? this.customerLocationSnapshot,
      customerPhoneSnapshot:
          customerPhoneSnapshot ?? this.customerPhoneSnapshot,
      companyNameSnapshot: companyNameSnapshot ?? this.companyNameSnapshot,
      legalNameSnapshot: legalNameSnapshot ?? this.legalNameSnapshot,
      addressSnapshot: addressSnapshot ?? this.addressSnapshot,
      phoneNumbersSnapshot: phoneNumbersSnapshot ?? this.phoneNumbersSnapshot,
      taglineSnapshot: taglineSnapshot ?? this.taglineSnapshot,
      signatorySnapshot: signatorySnapshot ?? this.signatorySnapshot,
      vatNumberSnapshot: vatNumberSnapshot ?? this.vatNumberSnapshot,
      tinNumberSnapshot: tinNumberSnapshot ?? this.tinNumberSnapshot,
      logoPathSnapshot: logoPathSnapshot ?? this.logoPathSnapshot,
      validityDays: validityDays ?? this.validityDays,
      createdAt: createdAt ?? this.createdAt,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      voidedAt: voidedAt ?? this.voidedAt,
      voidReason: voidReason ?? this.voidReason,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (sourceQuoteId.present) {
      map['source_quote_id'] = Variable<int>(sourceQuoteId.value);
    }
    if (replacesDocumentId.present) {
      map['replaces_document_id'] = Variable<int>(replacesDocumentId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (vatRateBasisPoints.present) {
      map['vat_rate_basis_points'] = Variable<int>(vatRateBasisPoints.value);
    }
    if (discountKind.present) {
      map['discount_kind'] = Variable<String>(discountKind.value);
    }
    if (discountValue.present) {
      map['discount_value'] = Variable<int>(discountValue.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (termsSnapshot.present) {
      map['terms_snapshot'] = Variable<String>(termsSnapshot.value);
    }
    if (customerNameSnapshot.present) {
      map['customer_name_snapshot'] = Variable<String>(
        customerNameSnapshot.value,
      );
    }
    if (customerLocationSnapshot.present) {
      map['customer_location_snapshot'] = Variable<String>(
        customerLocationSnapshot.value,
      );
    }
    if (customerPhoneSnapshot.present) {
      map['customer_phone_snapshot'] = Variable<String>(
        customerPhoneSnapshot.value,
      );
    }
    if (companyNameSnapshot.present) {
      map['company_name_snapshot'] = Variable<String>(
        companyNameSnapshot.value,
      );
    }
    if (legalNameSnapshot.present) {
      map['legal_name_snapshot'] = Variable<String>(legalNameSnapshot.value);
    }
    if (addressSnapshot.present) {
      map['address_snapshot'] = Variable<String>(addressSnapshot.value);
    }
    if (phoneNumbersSnapshot.present) {
      map['phone_numbers_snapshot'] = Variable<String>(
        phoneNumbersSnapshot.value,
      );
    }
    if (taglineSnapshot.present) {
      map['tagline_snapshot'] = Variable<String>(taglineSnapshot.value);
    }
    if (signatorySnapshot.present) {
      map['signatory_snapshot'] = Variable<String>(signatorySnapshot.value);
    }
    if (vatNumberSnapshot.present) {
      map['vat_number_snapshot'] = Variable<String>(vatNumberSnapshot.value);
    }
    if (tinNumberSnapshot.present) {
      map['tin_number_snapshot'] = Variable<String>(tinNumberSnapshot.value);
    }
    if (logoPathSnapshot.present) {
      map['logo_path_snapshot'] = Variable<String>(logoPathSnapshot.value);
    }
    if (validityDays.present) {
      map['validity_days'] = Variable<int>(validityDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (voidedAt.present) {
      map['voided_at'] = Variable<DateTime>(voidedAt.value);
    }
    if (voidReason.present) {
      map['void_reason'] = Variable<String>(voidReason.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('documentType: $documentType, ')
          ..write('status: $status, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('customerId: $customerId, ')
          ..write('sourceQuoteId: $sourceQuoteId, ')
          ..write('replacesDocumentId: $replacesDocumentId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('vatRateBasisPoints: $vatRateBasisPoints, ')
          ..write('discountKind: $discountKind, ')
          ..write('discountValue: $discountValue, ')
          ..write('notes: $notes, ')
          ..write('termsSnapshot: $termsSnapshot, ')
          ..write('customerNameSnapshot: $customerNameSnapshot, ')
          ..write('customerLocationSnapshot: $customerLocationSnapshot, ')
          ..write('customerPhoneSnapshot: $customerPhoneSnapshot, ')
          ..write('companyNameSnapshot: $companyNameSnapshot, ')
          ..write('legalNameSnapshot: $legalNameSnapshot, ')
          ..write('addressSnapshot: $addressSnapshot, ')
          ..write('phoneNumbersSnapshot: $phoneNumbersSnapshot, ')
          ..write('taglineSnapshot: $taglineSnapshot, ')
          ..write('signatorySnapshot: $signatorySnapshot, ')
          ..write('vatNumberSnapshot: $vatNumberSnapshot, ')
          ..write('tinNumberSnapshot: $tinNumberSnapshot, ')
          ..write('logoPathSnapshot: $logoPathSnapshot, ')
          ..write('validityDays: $validityDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('voidedAt: $voidedAt, ')
          ..write('voidReason: $voidReason, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentLinesTable extends DocumentLines
    with TableInfo<$DocumentLinesTable, DocumentLineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<int> documentId = GeneratedColumn<int>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSectionHeaderMeta = const VerificationMeta(
    'isSectionHeader',
  );
  @override
  late final GeneratedColumn<bool> isSectionHeader = GeneratedColumn<bool>(
    'is_section_header',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_section_header" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _unitPriceMinorMeta = const VerificationMeta(
    'unitPriceMinor',
  );
  @override
  late final GeneratedColumn<int> unitPriceMinor = GeneratedColumn<int>(
    'unit_price_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMilliMeta = const VerificationMeta(
    'quantityMilli',
  );
  @override
  late final GeneratedColumn<int> quantityMilli = GeneratedColumn<int>(
    'quantity_milli',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    sortOrder,
    isSectionHeader,
    designation,
    unit,
    unitPriceMinor,
    quantityMilli,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentLineData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_section_header')) {
      context.handle(
        _isSectionHeaderMeta,
        isSectionHeader.isAcceptableOrUnknown(
          data['is_section_header']!,
          _isSectionHeaderMeta,
        ),
      );
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_designationMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('unit_price_minor')) {
      context.handle(
        _unitPriceMinorMeta,
        unitPriceMinor.isAcceptableOrUnknown(
          data['unit_price_minor']!,
          _unitPriceMinorMeta,
        ),
      );
    }
    if (data.containsKey('quantity_milli')) {
      context.handle(
        _quantityMilliMeta,
        quantityMilli.isAcceptableOrUnknown(
          data['quantity_milli']!,
          _quantityMilliMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentLineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentLineData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isSectionHeader: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_section_header'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      unitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_minor'],
      ),
      quantityMilli: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_milli'],
      ),
    );
  }

  @override
  $DocumentLinesTable createAlias(String alias) {
    return $DocumentLinesTable(attachedDatabase, alias);
  }
}

class DocumentLineData extends DataClass
    implements Insertable<DocumentLineData> {
  final int id;
  final int documentId;
  final int sortOrder;
  final bool isSectionHeader;
  final String designation;
  final String unit;
  final int? unitPriceMinor;
  final int? quantityMilli;
  const DocumentLineData({
    required this.id,
    required this.documentId,
    required this.sortOrder,
    required this.isSectionHeader,
    required this.designation,
    required this.unit,
    this.unitPriceMinor,
    this.quantityMilli,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['document_id'] = Variable<int>(documentId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_section_header'] = Variable<bool>(isSectionHeader);
    map['designation'] = Variable<String>(designation);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || unitPriceMinor != null) {
      map['unit_price_minor'] = Variable<int>(unitPriceMinor);
    }
    if (!nullToAbsent || quantityMilli != null) {
      map['quantity_milli'] = Variable<int>(quantityMilli);
    }
    return map;
  }

  DocumentLinesCompanion toCompanion(bool nullToAbsent) {
    return DocumentLinesCompanion(
      id: Value(id),
      documentId: Value(documentId),
      sortOrder: Value(sortOrder),
      isSectionHeader: Value(isSectionHeader),
      designation: Value(designation),
      unit: Value(unit),
      unitPriceMinor: unitPriceMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPriceMinor),
      quantityMilli: quantityMilli == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityMilli),
    );
  }

  factory DocumentLineData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentLineData(
      id: serializer.fromJson<int>(json['id']),
      documentId: serializer.fromJson<int>(json['documentId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isSectionHeader: serializer.fromJson<bool>(json['isSectionHeader']),
      designation: serializer.fromJson<String>(json['designation']),
      unit: serializer.fromJson<String>(json['unit']),
      unitPriceMinor: serializer.fromJson<int?>(json['unitPriceMinor']),
      quantityMilli: serializer.fromJson<int?>(json['quantityMilli']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documentId': serializer.toJson<int>(documentId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isSectionHeader': serializer.toJson<bool>(isSectionHeader),
      'designation': serializer.toJson<String>(designation),
      'unit': serializer.toJson<String>(unit),
      'unitPriceMinor': serializer.toJson<int?>(unitPriceMinor),
      'quantityMilli': serializer.toJson<int?>(quantityMilli),
    };
  }

  DocumentLineData copyWith({
    int? id,
    int? documentId,
    int? sortOrder,
    bool? isSectionHeader,
    String? designation,
    String? unit,
    Value<int?> unitPriceMinor = const Value.absent(),
    Value<int?> quantityMilli = const Value.absent(),
  }) => DocumentLineData(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    sortOrder: sortOrder ?? this.sortOrder,
    isSectionHeader: isSectionHeader ?? this.isSectionHeader,
    designation: designation ?? this.designation,
    unit: unit ?? this.unit,
    unitPriceMinor: unitPriceMinor.present
        ? unitPriceMinor.value
        : this.unitPriceMinor,
    quantityMilli: quantityMilli.present
        ? quantityMilli.value
        : this.quantityMilli,
  );
  DocumentLineData copyWithCompanion(DocumentLinesCompanion data) {
    return DocumentLineData(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isSectionHeader: data.isSectionHeader.present
          ? data.isSectionHeader.value
          : this.isSectionHeader,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      unit: data.unit.present ? data.unit.value : this.unit,
      unitPriceMinor: data.unitPriceMinor.present
          ? data.unitPriceMinor.value
          : this.unitPriceMinor,
      quantityMilli: data.quantityMilli.present
          ? data.quantityMilli.value
          : this.quantityMilli,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentLineData(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSectionHeader: $isSectionHeader, ')
          ..write('designation: $designation, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('quantityMilli: $quantityMilli')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    sortOrder,
    isSectionHeader,
    designation,
    unit,
    unitPriceMinor,
    quantityMilli,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentLineData &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.sortOrder == this.sortOrder &&
          other.isSectionHeader == this.isSectionHeader &&
          other.designation == this.designation &&
          other.unit == this.unit &&
          other.unitPriceMinor == this.unitPriceMinor &&
          other.quantityMilli == this.quantityMilli);
}

class DocumentLinesCompanion extends UpdateCompanion<DocumentLineData> {
  final Value<int> id;
  final Value<int> documentId;
  final Value<int> sortOrder;
  final Value<bool> isSectionHeader;
  final Value<String> designation;
  final Value<String> unit;
  final Value<int?> unitPriceMinor;
  final Value<int?> quantityMilli;
  const DocumentLinesCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSectionHeader = const Value.absent(),
    this.designation = const Value.absent(),
    this.unit = const Value.absent(),
    this.unitPriceMinor = const Value.absent(),
    this.quantityMilli = const Value.absent(),
  });
  DocumentLinesCompanion.insert({
    this.id = const Value.absent(),
    required int documentId,
    required int sortOrder,
    this.isSectionHeader = const Value.absent(),
    required String designation,
    this.unit = const Value.absent(),
    this.unitPriceMinor = const Value.absent(),
    this.quantityMilli = const Value.absent(),
  }) : documentId = Value(documentId),
       sortOrder = Value(sortOrder),
       designation = Value(designation);
  static Insertable<DocumentLineData> custom({
    Expression<int>? id,
    Expression<int>? documentId,
    Expression<int>? sortOrder,
    Expression<bool>? isSectionHeader,
    Expression<String>? designation,
    Expression<String>? unit,
    Expression<int>? unitPriceMinor,
    Expression<int>? quantityMilli,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isSectionHeader != null) 'is_section_header': isSectionHeader,
      if (designation != null) 'designation': designation,
      if (unit != null) 'unit': unit,
      if (unitPriceMinor != null) 'unit_price_minor': unitPriceMinor,
      if (quantityMilli != null) 'quantity_milli': quantityMilli,
    });
  }

  DocumentLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? documentId,
    Value<int>? sortOrder,
    Value<bool>? isSectionHeader,
    Value<String>? designation,
    Value<String>? unit,
    Value<int?>? unitPriceMinor,
    Value<int?>? quantityMilli,
  }) {
    return DocumentLinesCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isSectionHeader: isSectionHeader ?? this.isSectionHeader,
      designation: designation ?? this.designation,
      unit: unit ?? this.unit,
      unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
      quantityMilli: quantityMilli ?? this.quantityMilli,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<int>(documentId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isSectionHeader.present) {
      map['is_section_header'] = Variable<bool>(isSectionHeader.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (unitPriceMinor.present) {
      map['unit_price_minor'] = Variable<int>(unitPriceMinor.value);
    }
    if (quantityMilli.present) {
      map['quantity_milli'] = Variable<int>(quantityMilli.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentLinesCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSectionHeader: $isSectionHeader, ')
          ..write('designation: $designation, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('quantityMilli: $quantityMilli')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryTypeMeta = const VerificationMeta(
    'entryType',
  );
  @override
  late final GeneratedColumn<String> entryType = GeneratedColumn<String>(
    'entry_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('payment'),
  );
  static const VerificationMeta _reversesPaymentIdMeta = const VerificationMeta(
    'reversesPaymentId',
  );
  @override
  late final GeneratedColumn<int> reversesPaymentId = GeneratedColumn<int>(
    'reverses_payment_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES payments (id)',
    ),
  );
  static const VerificationMeta _receiptDocumentIdMeta = const VerificationMeta(
    'receiptDocumentId',
  );
  @override
  late final GeneratedColumn<int> receiptDocumentId = GeneratedColumn<int>(
    'receipt_document_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    currencyCode,
    amountMinor,
    method,
    paidAt,
    entryType,
    reversesPaymentId,
    receiptDocumentId,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('entry_type')) {
      context.handle(
        _entryTypeMeta,
        entryType.isAcceptableOrUnknown(data['entry_type']!, _entryTypeMeta),
      );
    }
    if (data.containsKey('reverses_payment_id')) {
      context.handle(
        _reversesPaymentIdMeta,
        reversesPaymentId.isAcceptableOrUnknown(
          data['reverses_payment_id']!,
          _reversesPaymentIdMeta,
        ),
      );
    }
    if (data.containsKey('receipt_document_id')) {
      context.handle(
        _receiptDocumentIdMeta,
        receiptDocumentId.isAcceptableOrUnknown(
          data['receipt_document_id']!,
          _receiptDocumentIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      entryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_type'],
      )!,
      reversesPaymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reverses_payment_id'],
      ),
      receiptDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receipt_document_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentData extends DataClass implements Insertable<PaymentData> {
  final int id;
  final int invoiceId;
  final String currencyCode;
  final int amountMinor;
  final String method;
  final DateTime paidAt;
  final String entryType;
  final int? reversesPaymentId;
  final int? receiptDocumentId;
  final String note;
  const PaymentData({
    required this.id,
    required this.invoiceId,
    required this.currencyCode,
    required this.amountMinor,
    required this.method,
    required this.paidAt,
    required this.entryType,
    this.reversesPaymentId,
    this.receiptDocumentId,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['method'] = Variable<String>(method);
    map['paid_at'] = Variable<DateTime>(paidAt);
    map['entry_type'] = Variable<String>(entryType);
    if (!nullToAbsent || reversesPaymentId != null) {
      map['reverses_payment_id'] = Variable<int>(reversesPaymentId);
    }
    if (!nullToAbsent || receiptDocumentId != null) {
      map['receipt_document_id'] = Variable<int>(receiptDocumentId);
    }
    map['note'] = Variable<String>(note);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      currencyCode: Value(currencyCode),
      amountMinor: Value(amountMinor),
      method: Value(method),
      paidAt: Value(paidAt),
      entryType: Value(entryType),
      reversesPaymentId: reversesPaymentId == null && nullToAbsent
          ? const Value.absent()
          : Value(reversesPaymentId),
      receiptDocumentId: receiptDocumentId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptDocumentId),
      note: Value(note),
    );
  }

  factory PaymentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentData(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      method: serializer.fromJson<String>(json['method']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      entryType: serializer.fromJson<String>(json['entryType']),
      reversesPaymentId: serializer.fromJson<int?>(json['reversesPaymentId']),
      receiptDocumentId: serializer.fromJson<int?>(json['receiptDocumentId']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'method': serializer.toJson<String>(method),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'entryType': serializer.toJson<String>(entryType),
      'reversesPaymentId': serializer.toJson<int?>(reversesPaymentId),
      'receiptDocumentId': serializer.toJson<int?>(receiptDocumentId),
      'note': serializer.toJson<String>(note),
    };
  }

  PaymentData copyWith({
    int? id,
    int? invoiceId,
    String? currencyCode,
    int? amountMinor,
    String? method,
    DateTime? paidAt,
    String? entryType,
    Value<int?> reversesPaymentId = const Value.absent(),
    Value<int?> receiptDocumentId = const Value.absent(),
    String? note,
  }) => PaymentData(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    currencyCode: currencyCode ?? this.currencyCode,
    amountMinor: amountMinor ?? this.amountMinor,
    method: method ?? this.method,
    paidAt: paidAt ?? this.paidAt,
    entryType: entryType ?? this.entryType,
    reversesPaymentId: reversesPaymentId.present
        ? reversesPaymentId.value
        : this.reversesPaymentId,
    receiptDocumentId: receiptDocumentId.present
        ? receiptDocumentId.value
        : this.receiptDocumentId,
    note: note ?? this.note,
  );
  PaymentData copyWithCompanion(PaymentsCompanion data) {
    return PaymentData(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      method: data.method.present ? data.method.value : this.method,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      entryType: data.entryType.present ? data.entryType.value : this.entryType,
      reversesPaymentId: data.reversesPaymentId.present
          ? data.reversesPaymentId.value
          : this.reversesPaymentId,
      receiptDocumentId: data.receiptDocumentId.present
          ? data.receiptDocumentId.value
          : this.receiptDocumentId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt, ')
          ..write('entryType: $entryType, ')
          ..write('reversesPaymentId: $reversesPaymentId, ')
          ..write('receiptDocumentId: $receiptDocumentId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    currencyCode,
    amountMinor,
    method,
    paidAt,
    entryType,
    reversesPaymentId,
    receiptDocumentId,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.currencyCode == this.currencyCode &&
          other.amountMinor == this.amountMinor &&
          other.method == this.method &&
          other.paidAt == this.paidAt &&
          other.entryType == this.entryType &&
          other.reversesPaymentId == this.reversesPaymentId &&
          other.receiptDocumentId == this.receiptDocumentId &&
          other.note == this.note);
}

class PaymentsCompanion extends UpdateCompanion<PaymentData> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> currencyCode;
  final Value<int> amountMinor;
  final Value<String> method;
  final Value<DateTime> paidAt;
  final Value<String> entryType;
  final Value<int?> reversesPaymentId;
  final Value<int?> receiptDocumentId;
  final Value<String> note;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.method = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.entryType = const Value.absent(),
    this.reversesPaymentId = const Value.absent(),
    this.receiptDocumentId = const Value.absent(),
    this.note = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String currencyCode,
    required int amountMinor,
    required String method,
    required DateTime paidAt,
    this.entryType = const Value.absent(),
    this.reversesPaymentId = const Value.absent(),
    this.receiptDocumentId = const Value.absent(),
    this.note = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       currencyCode = Value(currencyCode),
       amountMinor = Value(amountMinor),
       method = Value(method),
       paidAt = Value(paidAt);
  static Insertable<PaymentData> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? currencyCode,
    Expression<int>? amountMinor,
    Expression<String>? method,
    Expression<DateTime>? paidAt,
    Expression<String>? entryType,
    Expression<int>? reversesPaymentId,
    Expression<int>? receiptDocumentId,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (method != null) 'method': method,
      if (paidAt != null) 'paid_at': paidAt,
      if (entryType != null) 'entry_type': entryType,
      if (reversesPaymentId != null) 'reverses_payment_id': reversesPaymentId,
      if (receiptDocumentId != null) 'receipt_document_id': receiptDocumentId,
      if (note != null) 'note': note,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? currencyCode,
    Value<int>? amountMinor,
    Value<String>? method,
    Value<DateTime>? paidAt,
    Value<String>? entryType,
    Value<int?>? reversesPaymentId,
    Value<int?>? receiptDocumentId,
    Value<String>? note,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      currencyCode: currencyCode ?? this.currencyCode,
      amountMinor: amountMinor ?? this.amountMinor,
      method: method ?? this.method,
      paidAt: paidAt ?? this.paidAt,
      entryType: entryType ?? this.entryType,
      reversesPaymentId: reversesPaymentId ?? this.reversesPaymentId,
      receiptDocumentId: receiptDocumentId ?? this.receiptDocumentId,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (entryType.present) {
      map['entry_type'] = Variable<String>(entryType.value);
    }
    if (reversesPaymentId.present) {
      map['reverses_payment_id'] = Variable<int>(reversesPaymentId.value);
    }
    if (receiptDocumentId.present) {
      map['receipt_document_id'] = Variable<int>(receiptDocumentId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt, ')
          ..write('entryType: $entryType, ')
          ..write('reversesPaymentId: $reversesPaymentId, ')
          ..write('receiptDocumentId: $receiptDocumentId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $TermsTemplatesTable extends TermsTemplates
    with TableInfo<$TermsTemplatesTable, TermsTemplateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    content,
    isDefault,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terms_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<TermsTemplateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TermsTemplateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermsTemplateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TermsTemplatesTable createAlias(String alias) {
    return $TermsTemplatesTable(attachedDatabase, alias);
  }
}

class TermsTemplateData extends DataClass
    implements Insertable<TermsTemplateData> {
  final int id;
  final String name;
  final String content;
  final bool isDefault;
  final DateTime updatedAt;
  const TermsTemplateData({
    required this.id,
    required this.name,
    required this.content,
    required this.isDefault,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['content'] = Variable<String>(content);
    map['is_default'] = Variable<bool>(isDefault);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TermsTemplatesCompanion toCompanion(bool nullToAbsent) {
    return TermsTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      content: Value(content),
      isDefault: Value(isDefault),
      updatedAt: Value(updatedAt),
    );
  }

  factory TermsTemplateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermsTemplateData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String>(json['content']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String>(content),
      'isDefault': serializer.toJson<bool>(isDefault),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TermsTemplateData copyWith({
    int? id,
    String? name,
    String? content,
    bool? isDefault,
    DateTime? updatedAt,
  }) => TermsTemplateData(
    id: id ?? this.id,
    name: name ?? this.name,
    content: content ?? this.content,
    isDefault: isDefault ?? this.isDefault,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TermsTemplateData copyWithCompanion(TermsTemplatesCompanion data) {
    return TermsTemplateData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      content: data.content.present ? data.content.value : this.content,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TermsTemplateData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('isDefault: $isDefault, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, content, isDefault, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsTemplateData &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.isDefault == this.isDefault &&
          other.updatedAt == this.updatedAt);
}

class TermsTemplatesCompanion extends UpdateCompanion<TermsTemplateData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> content;
  final Value<bool> isDefault;
  final Value<DateTime> updatedAt;
  const TermsTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TermsTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String content,
    this.isDefault = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       content = Value(content);
  static Insertable<TermsTemplateData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? content,
    Expression<bool>? isDefault,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (isDefault != null) 'is_default': isDefault,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TermsTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? content,
    Value<bool>? isDefault,
    Value<DateTime>? updatedAt,
  }) {
    return TermsTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      isDefault: isDefault ?? this.isDefault,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('isDefault: $isDefault, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NumberSequencesTable extends NumberSequences
    with TableInfo<$NumberSequencesTable, NumberSequenceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumberSequencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prefixMeta = const VerificationMeta('prefix');
  @override
  late final GeneratedColumn<String> prefix = GeneratedColumn<String>(
    'prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextNumberMeta = const VerificationMeta(
    'nextNumber',
  );
  @override
  late final GeneratedColumn<int> nextNumber = GeneratedColumn<int>(
    'next_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _paddingMeta = const VerificationMeta(
    'padding',
  );
  @override
  late final GeneratedColumn<int> padding = GeneratedColumn<int>(
    'padding',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  @override
  List<GeneratedColumn> get $columns => [
    documentType,
    prefix,
    nextNumber,
    padding,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'number_sequences';
  @override
  VerificationContext validateIntegrity(
    Insertable<NumberSequenceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('prefix')) {
      context.handle(
        _prefixMeta,
        prefix.isAcceptableOrUnknown(data['prefix']!, _prefixMeta),
      );
    } else if (isInserting) {
      context.missing(_prefixMeta);
    }
    if (data.containsKey('next_number')) {
      context.handle(
        _nextNumberMeta,
        nextNumber.isAcceptableOrUnknown(data['next_number']!, _nextNumberMeta),
      );
    }
    if (data.containsKey('padding')) {
      context.handle(
        _paddingMeta,
        padding.isAcceptableOrUnknown(data['padding']!, _paddingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {documentType};
  @override
  NumberSequenceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumberSequenceData(
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      prefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prefix'],
      )!,
      nextNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_number'],
      )!,
      padding: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}padding'],
      )!,
    );
  }

  @override
  $NumberSequencesTable createAlias(String alias) {
    return $NumberSequencesTable(attachedDatabase, alias);
  }
}

class NumberSequenceData extends DataClass
    implements Insertable<NumberSequenceData> {
  final String documentType;
  final String prefix;
  final int nextNumber;
  final int padding;
  const NumberSequenceData({
    required this.documentType,
    required this.prefix,
    required this.nextNumber,
    required this.padding,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['document_type'] = Variable<String>(documentType);
    map['prefix'] = Variable<String>(prefix);
    map['next_number'] = Variable<int>(nextNumber);
    map['padding'] = Variable<int>(padding);
    return map;
  }

  NumberSequencesCompanion toCompanion(bool nullToAbsent) {
    return NumberSequencesCompanion(
      documentType: Value(documentType),
      prefix: Value(prefix),
      nextNumber: Value(nextNumber),
      padding: Value(padding),
    );
  }

  factory NumberSequenceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NumberSequenceData(
      documentType: serializer.fromJson<String>(json['documentType']),
      prefix: serializer.fromJson<String>(json['prefix']),
      nextNumber: serializer.fromJson<int>(json['nextNumber']),
      padding: serializer.fromJson<int>(json['padding']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'documentType': serializer.toJson<String>(documentType),
      'prefix': serializer.toJson<String>(prefix),
      'nextNumber': serializer.toJson<int>(nextNumber),
      'padding': serializer.toJson<int>(padding),
    };
  }

  NumberSequenceData copyWith({
    String? documentType,
    String? prefix,
    int? nextNumber,
    int? padding,
  }) => NumberSequenceData(
    documentType: documentType ?? this.documentType,
    prefix: prefix ?? this.prefix,
    nextNumber: nextNumber ?? this.nextNumber,
    padding: padding ?? this.padding,
  );
  NumberSequenceData copyWithCompanion(NumberSequencesCompanion data) {
    return NumberSequenceData(
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      prefix: data.prefix.present ? data.prefix.value : this.prefix,
      nextNumber: data.nextNumber.present
          ? data.nextNumber.value
          : this.nextNumber,
      padding: data.padding.present ? data.padding.value : this.padding,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NumberSequenceData(')
          ..write('documentType: $documentType, ')
          ..write('prefix: $prefix, ')
          ..write('nextNumber: $nextNumber, ')
          ..write('padding: $padding')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(documentType, prefix, nextNumber, padding);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumberSequenceData &&
          other.documentType == this.documentType &&
          other.prefix == this.prefix &&
          other.nextNumber == this.nextNumber &&
          other.padding == this.padding);
}

class NumberSequencesCompanion extends UpdateCompanion<NumberSequenceData> {
  final Value<String> documentType;
  final Value<String> prefix;
  final Value<int> nextNumber;
  final Value<int> padding;
  final Value<int> rowid;
  const NumberSequencesCompanion({
    this.documentType = const Value.absent(),
    this.prefix = const Value.absent(),
    this.nextNumber = const Value.absent(),
    this.padding = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NumberSequencesCompanion.insert({
    required String documentType,
    required String prefix,
    this.nextNumber = const Value.absent(),
    this.padding = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : documentType = Value(documentType),
       prefix = Value(prefix);
  static Insertable<NumberSequenceData> custom({
    Expression<String>? documentType,
    Expression<String>? prefix,
    Expression<int>? nextNumber,
    Expression<int>? padding,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (documentType != null) 'document_type': documentType,
      if (prefix != null) 'prefix': prefix,
      if (nextNumber != null) 'next_number': nextNumber,
      if (padding != null) 'padding': padding,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NumberSequencesCompanion copyWith({
    Value<String>? documentType,
    Value<String>? prefix,
    Value<int>? nextNumber,
    Value<int>? padding,
    Value<int>? rowid,
  }) {
    return NumberSequencesCompanion(
      documentType: documentType ?? this.documentType,
      prefix: prefix ?? this.prefix,
      nextNumber: nextNumber ?? this.nextNumber,
      padding: padding ?? this.padding,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (prefix.present) {
      map['prefix'] = Variable<String>(prefix.value);
    }
    if (nextNumber.present) {
      map['next_number'] = Variable<int>(nextNumber.value);
    }
    if (padding.present) {
      map['padding'] = Variable<int>(padding.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumberSequencesCompanion(')
          ..write('documentType: $documentType, ')
          ..write('prefix: $prefix, ')
          ..write('nextNumber: $nextNumber, ')
          ..write('padding: $padding, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _beforeSummaryMeta = const VerificationMeta(
    'beforeSummary',
  );
  @override
  late final GeneratedColumn<String> beforeSummary = GeneratedColumn<String>(
    'before_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _afterSummaryMeta = const VerificationMeta(
    'afterSummary',
  );
  @override
  late final GeneratedColumn<String> afterSummary = GeneratedColumn<String>(
    'after_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  @override
  late final GeneratedColumn<String> actor = GeneratedColumn<String>(
    'actor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('owner'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    action,
    occurredAt,
    beforeSummary,
    afterSummary,
    actor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('before_summary')) {
      context.handle(
        _beforeSummaryMeta,
        beforeSummary.isAcceptableOrUnknown(
          data['before_summary']!,
          _beforeSummaryMeta,
        ),
      );
    }
    if (data.containsKey('after_summary')) {
      context.handle(
        _afterSummaryMeta,
        afterSummary.isAcceptableOrUnknown(
          data['after_summary']!,
          _afterSummaryMeta,
        ),
      );
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      beforeSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_summary'],
      ),
      afterSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}after_summary'],
      ),
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLogData extends DataClass implements Insertable<AuditLogData> {
  final int id;
  final String entityType;
  final int entityId;
  final String action;
  final DateTime occurredAt;
  final String? beforeSummary;
  final String? afterSummary;
  final String actor;
  const AuditLogData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.occurredAt,
    this.beforeSummary,
    this.afterSummary,
    required this.actor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    map['action'] = Variable<String>(action);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || beforeSummary != null) {
      map['before_summary'] = Variable<String>(beforeSummary);
    }
    if (!nullToAbsent || afterSummary != null) {
      map['after_summary'] = Variable<String>(afterSummary);
    }
    map['actor'] = Variable<String>(actor);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      action: Value(action),
      occurredAt: Value(occurredAt),
      beforeSummary: beforeSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeSummary),
      afterSummary: afterSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSummary),
      actor: Value(actor),
    );
  }

  factory AuditLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      beforeSummary: serializer.fromJson<String?>(json['beforeSummary']),
      afterSummary: serializer.fromJson<String?>(json['afterSummary']),
      actor: serializer.fromJson<String>(json['actor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
      'action': serializer.toJson<String>(action),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'beforeSummary': serializer.toJson<String?>(beforeSummary),
      'afterSummary': serializer.toJson<String?>(afterSummary),
      'actor': serializer.toJson<String>(actor),
    };
  }

  AuditLogData copyWith({
    int? id,
    String? entityType,
    int? entityId,
    String? action,
    DateTime? occurredAt,
    Value<String?> beforeSummary = const Value.absent(),
    Value<String?> afterSummary = const Value.absent(),
    String? actor,
  }) => AuditLogData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    action: action ?? this.action,
    occurredAt: occurredAt ?? this.occurredAt,
    beforeSummary: beforeSummary.present
        ? beforeSummary.value
        : this.beforeSummary,
    afterSummary: afterSummary.present ? afterSummary.value : this.afterSummary,
    actor: actor ?? this.actor,
  );
  AuditLogData copyWithCompanion(AuditLogsCompanion data) {
    return AuditLogData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      beforeSummary: data.beforeSummary.present
          ? data.beforeSummary.value
          : this.beforeSummary,
      afterSummary: data.afterSummary.present
          ? data.afterSummary.value
          : this.afterSummary,
      actor: data.actor.present ? data.actor.value : this.actor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('beforeSummary: $beforeSummary, ')
          ..write('afterSummary: $afterSummary, ')
          ..write('actor: $actor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    action,
    occurredAt,
    beforeSummary,
    afterSummary,
    actor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.occurredAt == this.occurredAt &&
          other.beforeSummary == this.beforeSummary &&
          other.afterSummary == this.afterSummary &&
          other.actor == this.actor);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLogData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> action;
  final Value<DateTime> occurredAt;
  final Value<String?> beforeSummary;
  final Value<String?> afterSummary;
  final Value<String> actor;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.beforeSummary = const Value.absent(),
    this.afterSummary = const Value.absent(),
    this.actor = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
    required String action,
    this.occurredAt = const Value.absent(),
    this.beforeSummary = const Value.absent(),
    this.afterSummary = const Value.absent(),
    this.actor = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       action = Value(action);
  static Insertable<AuditLogData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? action,
    Expression<DateTime>? occurredAt,
    Expression<String>? beforeSummary,
    Expression<String>? afterSummary,
    Expression<String>? actor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (beforeSummary != null) 'before_summary': beforeSummary,
      if (afterSummary != null) 'after_summary': afterSummary,
      if (actor != null) 'actor': actor,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<int>? entityId,
    Value<String>? action,
    Value<DateTime>? occurredAt,
    Value<String?>? beforeSummary,
    Value<String?>? afterSummary,
    Value<String>? actor,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      occurredAt: occurredAt ?? this.occurredAt,
      beforeSummary: beforeSummary ?? this.beforeSummary,
      afterSummary: afterSummary ?? this.afterSummary,
      actor: actor ?? this.actor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (beforeSummary.present) {
      map['before_summary'] = Variable<String>(beforeSummary.value);
    }
    if (afterSummary.present) {
      map['after_summary'] = Variable<String>(afterSummary.value);
    }
    if (actor.present) {
      map['actor'] = Variable<String>(actor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('beforeSummary: $beforeSummary, ')
          ..write('afterSummary: $afterSummary, ')
          ..write('actor: $actor')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompanyProfilesTable companyProfiles = $CompanyProfilesTable(
    this,
  );
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CatalogItemsTable catalogItems = $CatalogItemsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $DocumentLinesTable documentLines = $DocumentLinesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $TermsTemplatesTable termsTemplates = $TermsTemplatesTable(this);
  late final $NumberSequencesTable numberSequences = $NumberSequencesTable(
    this,
  );
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    companyProfiles,
    customers,
    catalogItems,
    documents,
    documentLines,
    payments,
    termsTemplates,
    numberSequences,
    auditLogs,
  ];
}

typedef $$CompanyProfilesTableCreateCompanionBuilder =
    CompanyProfilesCompanion Function({
      Value<int> id,
      required String companyName,
      Value<String?> legalName,
      Value<String> address,
      Value<String> phoneNumbers,
      Value<String> tagline,
      Value<String> signatory,
      Value<int> vatRateBasisPoints,
      Value<String?> vatNumber,
      Value<String?> tinNumber,
      Value<String> supportedCurrencies,
      Value<String?> logoPath,
      Value<String> quotePrefix,
      Value<String> invoicePrefix,
      Value<String> receiptPrefix,
      Value<int> numberPadding,
      Value<int> defaultValidityDays,
    });
typedef $$CompanyProfilesTableUpdateCompanionBuilder =
    CompanyProfilesCompanion Function({
      Value<int> id,
      Value<String> companyName,
      Value<String?> legalName,
      Value<String> address,
      Value<String> phoneNumbers,
      Value<String> tagline,
      Value<String> signatory,
      Value<int> vatRateBasisPoints,
      Value<String?> vatNumber,
      Value<String?> tinNumber,
      Value<String> supportedCurrencies,
      Value<String?> logoPath,
      Value<String> quotePrefix,
      Value<String> invoicePrefix,
      Value<String> receiptPrefix,
      Value<int> numberPadding,
      Value<int> defaultValidityDays,
    });

class $$CompanyProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyProfilesTable> {
  $$CompanyProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumbers => $composableBuilder(
    column: $table.phoneNumbers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signatory => $composableBuilder(
    column: $table.signatory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatNumber => $composableBuilder(
    column: $table.vatNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tinNumber => $composableBuilder(
    column: $table.tinNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supportedCurrencies => $composableBuilder(
    column: $table.supportedCurrencies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quotePrefix => $composableBuilder(
    column: $table.quotePrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultValidityDays => $composableBuilder(
    column: $table.defaultValidityDays,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanyProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyProfilesTable> {
  $$CompanyProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumbers => $composableBuilder(
    column: $table.phoneNumbers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signatory => $composableBuilder(
    column: $table.signatory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatNumber => $composableBuilder(
    column: $table.vatNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tinNumber => $composableBuilder(
    column: $table.tinNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supportedCurrencies => $composableBuilder(
    column: $table.supportedCurrencies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quotePrefix => $composableBuilder(
    column: $table.quotePrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultValidityDays => $composableBuilder(
    column: $table.defaultValidityDays,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanyProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyProfilesTable> {
  $$CompanyProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get legalName =>
      $composableBuilder(column: $table.legalName, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phoneNumbers => $composableBuilder(
    column: $table.phoneNumbers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get signatory =>
      $composableBuilder(column: $table.signatory, builder: (column) => column);

  GeneratedColumn<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatNumber =>
      $composableBuilder(column: $table.vatNumber, builder: (column) => column);

  GeneratedColumn<String> get tinNumber =>
      $composableBuilder(column: $table.tinNumber, builder: (column) => column);

  GeneratedColumn<String> get supportedCurrencies => $composableBuilder(
    column: $table.supportedCurrencies,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get quotePrefix => $composableBuilder(
    column: $table.quotePrefix,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultValidityDays => $composableBuilder(
    column: $table.defaultValidityDays,
    builder: (column) => column,
  );
}

class $$CompanyProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanyProfilesTable,
          CompanyProfileData,
          $$CompanyProfilesTableFilterComposer,
          $$CompanyProfilesTableOrderingComposer,
          $$CompanyProfilesTableAnnotationComposer,
          $$CompanyProfilesTableCreateCompanionBuilder,
          $$CompanyProfilesTableUpdateCompanionBuilder,
          (
            CompanyProfileData,
            BaseReferences<
              _$AppDatabase,
              $CompanyProfilesTable,
              CompanyProfileData
            >,
          ),
          CompanyProfileData,
          PrefetchHooks Function()
        > {
  $$CompanyProfilesTableTableManager(
    _$AppDatabase db,
    $CompanyProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String?> legalName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> phoneNumbers = const Value.absent(),
                Value<String> tagline = const Value.absent(),
                Value<String> signatory = const Value.absent(),
                Value<int> vatRateBasisPoints = const Value.absent(),
                Value<String?> vatNumber = const Value.absent(),
                Value<String?> tinNumber = const Value.absent(),
                Value<String> supportedCurrencies = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String> quotePrefix = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<String> receiptPrefix = const Value.absent(),
                Value<int> numberPadding = const Value.absent(),
                Value<int> defaultValidityDays = const Value.absent(),
              }) => CompanyProfilesCompanion(
                id: id,
                companyName: companyName,
                legalName: legalName,
                address: address,
                phoneNumbers: phoneNumbers,
                tagline: tagline,
                signatory: signatory,
                vatRateBasisPoints: vatRateBasisPoints,
                vatNumber: vatNumber,
                tinNumber: tinNumber,
                supportedCurrencies: supportedCurrencies,
                logoPath: logoPath,
                quotePrefix: quotePrefix,
                invoicePrefix: invoicePrefix,
                receiptPrefix: receiptPrefix,
                numberPadding: numberPadding,
                defaultValidityDays: defaultValidityDays,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String companyName,
                Value<String?> legalName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> phoneNumbers = const Value.absent(),
                Value<String> tagline = const Value.absent(),
                Value<String> signatory = const Value.absent(),
                Value<int> vatRateBasisPoints = const Value.absent(),
                Value<String?> vatNumber = const Value.absent(),
                Value<String?> tinNumber = const Value.absent(),
                Value<String> supportedCurrencies = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String> quotePrefix = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<String> receiptPrefix = const Value.absent(),
                Value<int> numberPadding = const Value.absent(),
                Value<int> defaultValidityDays = const Value.absent(),
              }) => CompanyProfilesCompanion.insert(
                id: id,
                companyName: companyName,
                legalName: legalName,
                address: address,
                phoneNumbers: phoneNumbers,
                tagline: tagline,
                signatory: signatory,
                vatRateBasisPoints: vatRateBasisPoints,
                vatNumber: vatNumber,
                tinNumber: tinNumber,
                supportedCurrencies: supportedCurrencies,
                logoPath: logoPath,
                quotePrefix: quotePrefix,
                invoicePrefix: invoicePrefix,
                receiptPrefix: receiptPrefix,
                numberPadding: numberPadding,
                defaultValidityDays: defaultValidityDays,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CompanyProfilesTable, CompanyProfileData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CompanyProfilesTable,
                    CompanyProfileData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanyProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanyProfilesTable,
      CompanyProfileData,
      $$CompanyProfilesTableFilterComposer,
      $$CompanyProfilesTableOrderingComposer,
      $$CompanyProfilesTableAnnotationComposer,
      $$CompanyProfilesTableCreateCompanionBuilder,
      $$CompanyProfilesTableUpdateCompanionBuilder,
      (
        CompanyProfileData,
        BaseReferences<
          _$AppDatabase,
          $CompanyProfilesTable,
          CompanyProfileData
        >,
      ),
      CompanyProfileData,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  Value<String> location,
  Value<String> phone,
  Value<String> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> location,
  Value<String> phone,
  Value<String> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, CustomerData> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DocumentsTable, List<DocumentData>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'customers__id__documents__customer_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerData,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (CustomerData, $$CustomersTableReferences),
          CustomerData,
          PrefetchHooks Function({bool documentsRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                location: location,
                phone: phone,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> location = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                location: location,
                phone: phone,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomersTable, CustomerData>(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (documentsRefs) db.documents],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (documentsRefs)
                    await $_getPrefetchedData<
                      CustomerData,
                      $CustomersTable,
                      DocumentData
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._documentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(
                            db,
                            table,
                            p0,
                          ).documentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerData,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (CustomerData, $$CustomersTableReferences),
      CustomerData,
      PrefetchHooks Function({bool documentsRefs})
    >;
typedef $$CatalogItemsTableCreateCompanionBuilder =
    CatalogItemsCompanion Function({
      Value<int> id,
      required String designation,
      Value<String> unit,
      Value<int?> defaultUnitPriceMinor,
      Value<String> defaultPriceCurrencyCode,
      Value<bool> isSection,
      Value<int?> sectionId,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });
typedef $$CatalogItemsTableUpdateCompanionBuilder =
    CatalogItemsCompanion Function({
      Value<int> id,
      Value<String> designation,
      Value<String> unit,
      Value<int?> defaultUnitPriceMinor,
      Value<String> defaultPriceCurrencyCode,
      Value<bool> isSection,
      Value<int?> sectionId,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

final class $$CatalogItemsTableReferences
    extends BaseReferences<_$AppDatabase, $CatalogItemsTable, CatalogItemData> {
  $$CatalogItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CatalogItemsTable _sectionIdTable(_$AppDatabase db) => db.catalogItems
      .createAlias('catalog_items__section_id__catalog_items__id');

  $$CatalogItemsTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<int>('section_id');
    if ($_column == null) return null;
    final manager = $$CatalogItemsTableTableManager(
      $_db,
      $_db.catalogItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CatalogItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CatalogItemsTable> {
  $$CatalogItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultUnitPriceMinor => $composableBuilder(
    column: $table.defaultUnitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultPriceCurrencyCode => $composableBuilder(
    column: $table.defaultPriceCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSection => $composableBuilder(
    column: $table.isSection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CatalogItemsTableFilterComposer get sectionId {
    final $$CatalogItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.catalogItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatalogItemsTableFilterComposer(
            $db: $db,
            $table: $db.catalogItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatalogItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CatalogItemsTable> {
  $$CatalogItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultUnitPriceMinor => $composableBuilder(
    column: $table.defaultUnitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultPriceCurrencyCode => $composableBuilder(
    column: $table.defaultPriceCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSection => $composableBuilder(
    column: $table.isSection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CatalogItemsTableOrderingComposer get sectionId {
    final $$CatalogItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.catalogItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatalogItemsTableOrderingComposer(
            $db: $db,
            $table: $db.catalogItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatalogItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatalogItemsTable> {
  $$CatalogItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get defaultUnitPriceMinor => $composableBuilder(
    column: $table.defaultUnitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultPriceCurrencyCode => $composableBuilder(
    column: $table.defaultPriceCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSection =>
      $composableBuilder(column: $table.isSection, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CatalogItemsTableAnnotationComposer get sectionId {
    final $$CatalogItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.catalogItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatalogItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.catalogItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatalogItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatalogItemsTable,
          CatalogItemData,
          $$CatalogItemsTableFilterComposer,
          $$CatalogItemsTableOrderingComposer,
          $$CatalogItemsTableAnnotationComposer,
          $$CatalogItemsTableCreateCompanionBuilder,
          $$CatalogItemsTableUpdateCompanionBuilder,
          (CatalogItemData, $$CatalogItemsTableReferences),
          CatalogItemData,
          PrefetchHooks Function({bool sectionId})
        > {
  $$CatalogItemsTableTableManager(_$AppDatabase db, $CatalogItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatalogItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatalogItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatalogItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> designation = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int?> defaultUnitPriceMinor = const Value.absent(),
                Value<String> defaultPriceCurrencyCode = const Value.absent(),
                Value<bool> isSection = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CatalogItemsCompanion(
                id: id,
                designation: designation,
                unit: unit,
                defaultUnitPriceMinor: defaultUnitPriceMinor,
                defaultPriceCurrencyCode: defaultPriceCurrencyCode,
                isSection: isSection,
                sectionId: sectionId,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String designation,
                Value<String> unit = const Value.absent(),
                Value<int?> defaultUnitPriceMinor = const Value.absent(),
                Value<String> defaultPriceCurrencyCode = const Value.absent(),
                Value<bool> isSection = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CatalogItemsCompanion.insert(
                id: id,
                designation: designation,
                unit: unit,
                defaultUnitPriceMinor: defaultUnitPriceMinor,
                defaultPriceCurrencyCode: defaultPriceCurrencyCode,
                isSection: isSection,
                sectionId: sectionId,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CatalogItemsTable, CatalogItemData>(table),
                  $$CatalogItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sectionId,
                        referencedTable: $$CatalogItemsTableReferences
                            ._sectionIdTable(db),
                        referencedColumn: $$CatalogItemsTableReferences
                            ._sectionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CatalogItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatalogItemsTable,
      CatalogItemData,
      $$CatalogItemsTableFilterComposer,
      $$CatalogItemsTableOrderingComposer,
      $$CatalogItemsTableAnnotationComposer,
      $$CatalogItemsTableCreateCompanionBuilder,
      $$CatalogItemsTableUpdateCompanionBuilder,
      (CatalogItemData, $$CatalogItemsTableReferences),
      CatalogItemData,
      PrefetchHooks Function({bool sectionId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  required String documentType,
  required String status,
  Value<String?> documentNumber,
  Value<int?> customerId,
  Value<int?> sourceQuoteId,
  Value<int?> replacesDocumentId,
  required String currencyCode,
  Value<int> vatRateBasisPoints,
  Value<String> discountKind,
  Value<int> discountValue,
  Value<String> notes,
  Value<String> termsSnapshot,
  Value<String> customerNameSnapshot,
  Value<String> customerLocationSnapshot,
  Value<String> customerPhoneSnapshot,
  Value<String> companyNameSnapshot,
  Value<String> legalNameSnapshot,
  Value<String> addressSnapshot,
  Value<String> phoneNumbersSnapshot,
  Value<String> taglineSnapshot,
  Value<String> signatorySnapshot,
  Value<String?> vatNumberSnapshot,
  Value<String?> tinNumberSnapshot,
  Value<String?> logoPathSnapshot,
  Value<int> validityDays,
  Value<DateTime> createdAt,
  Value<DateTime?> issuedAt,
  Value<DateTime?> expiresAt,
  Value<DateTime?> voidedAt,
  Value<String?> voidReason,
  Value<DateTime> updatedAt,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<String> documentType,
  Value<String> status,
  Value<String?> documentNumber,
  Value<int?> customerId,
  Value<int?> sourceQuoteId,
  Value<int?> replacesDocumentId,
  Value<String> currencyCode,
  Value<int> vatRateBasisPoints,
  Value<String> discountKind,
  Value<int> discountValue,
  Value<String> notes,
  Value<String> termsSnapshot,
  Value<String> customerNameSnapshot,
  Value<String> customerLocationSnapshot,
  Value<String> customerPhoneSnapshot,
  Value<String> companyNameSnapshot,
  Value<String> legalNameSnapshot,
  Value<String> addressSnapshot,
  Value<String> phoneNumbersSnapshot,
  Value<String> taglineSnapshot,
  Value<String> signatorySnapshot,
  Value<String?> vatNumberSnapshot,
  Value<String?> tinNumberSnapshot,
  Value<String?> logoPathSnapshot,
  Value<int> validityDays,
  Value<DateTime> createdAt,
  Value<DateTime?> issuedAt,
  Value<DateTime?> expiresAt,
  Value<DateTime?> voidedAt,
  Value<String?> voidReason,
  Value<DateTime> updatedAt,
});

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, DocumentData> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('documents__customer_id__customers__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _sourceQuoteIdTable(_$AppDatabase db) =>
      db.documents.createAlias('documents__source_quote_id__documents__id');

  $$DocumentsTableProcessedTableManager? get sourceQuoteId {
    final $_column = $_itemColumn<int>('source_quote_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceQuoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _replacesDocumentIdTable(_$AppDatabase db) => db
      .documents
      .createAlias('documents__replaces_document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get replacesDocumentId {
    final $_column = $_itemColumn<int>('replaces_document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_replacesDocumentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DocumentLinesTable, List<DocumentLineData>>
  _documentLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documentLines,
    aliasName: 'documents__id__document_lines__document_id',
  );

  $$DocumentLinesTableProcessedTableManager get documentLinesRefs {
    final manager = $$DocumentLinesTableTableManager(
      $_db,
      $_db.documentLines,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentData>>
  _invoicePaymentsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'documents__id__payments__invoice_id',
  );

  $$PaymentsTableProcessedTableManager get invoicePayments {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicePaymentsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentData>>
  _paymentReceiptsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'documents__id__payments__receipt_document_id',
  );

  $$PaymentsTableProcessedTableManager get paymentReceipts {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.receiptDocumentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentReceiptsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discountKind => $composableBuilder(
    column: $table.discountKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsSnapshot => $composableBuilder(
    column: $table.termsSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerLocationSnapshot => $composableBuilder(
    column: $table.customerLocationSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerPhoneSnapshot => $composableBuilder(
    column: $table.customerPhoneSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyNameSnapshot => $composableBuilder(
    column: $table.companyNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalNameSnapshot => $composableBuilder(
    column: $table.legalNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressSnapshot => $composableBuilder(
    column: $table.addressSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumbersSnapshot => $composableBuilder(
    column: $table.phoneNumbersSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taglineSnapshot => $composableBuilder(
    column: $table.taglineSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signatorySnapshot => $composableBuilder(
    column: $table.signatorySnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatNumberSnapshot => $composableBuilder(
    column: $table.vatNumberSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tinNumberSnapshot => $composableBuilder(
    column: $table.tinNumberSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPathSnapshot => $composableBuilder(
    column: $table.logoPathSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get validityDays => $composableBuilder(
    column: $table.validityDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get voidedAt => $composableBuilder(
    column: $table.voidedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voidReason => $composableBuilder(
    column: $table.voidReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get sourceQuoteId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceQuoteId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get replacesDocumentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacesDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> documentLinesRefs(
    Expression<bool> Function($$DocumentLinesTableFilterComposer f) f,
  ) {
    final $$DocumentLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentLines,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentLinesTableFilterComposer(
            $db: $db,
            $table: $db.documentLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePayments(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentReceipts(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.receiptDocumentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discountKind => $composableBuilder(
    column: $table.discountKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsSnapshot => $composableBuilder(
    column: $table.termsSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerLocationSnapshot => $composableBuilder(
    column: $table.customerLocationSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerPhoneSnapshot => $composableBuilder(
    column: $table.customerPhoneSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyNameSnapshot => $composableBuilder(
    column: $table.companyNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalNameSnapshot => $composableBuilder(
    column: $table.legalNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressSnapshot => $composableBuilder(
    column: $table.addressSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumbersSnapshot => $composableBuilder(
    column: $table.phoneNumbersSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taglineSnapshot => $composableBuilder(
    column: $table.taglineSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signatorySnapshot => $composableBuilder(
    column: $table.signatorySnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatNumberSnapshot => $composableBuilder(
    column: $table.vatNumberSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tinNumberSnapshot => $composableBuilder(
    column: $table.tinNumberSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPathSnapshot => $composableBuilder(
    column: $table.logoPathSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get validityDays => $composableBuilder(
    column: $table.validityDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get voidedAt => $composableBuilder(
    column: $table.voidedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voidReason => $composableBuilder(
    column: $table.voidReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get sourceQuoteId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceQuoteId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get replacesDocumentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacesDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vatRateBasisPoints => $composableBuilder(
    column: $table.vatRateBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get discountKind => $composableBuilder(
    column: $table.discountKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountValue => $composableBuilder(
    column: $table.discountValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get termsSnapshot => $composableBuilder(
    column: $table.termsSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerLocationSnapshot => $composableBuilder(
    column: $table.customerLocationSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerPhoneSnapshot => $composableBuilder(
    column: $table.customerPhoneSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companyNameSnapshot => $composableBuilder(
    column: $table.companyNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get legalNameSnapshot => $composableBuilder(
    column: $table.legalNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressSnapshot => $composableBuilder(
    column: $table.addressSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumbersSnapshot => $composableBuilder(
    column: $table.phoneNumbersSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taglineSnapshot => $composableBuilder(
    column: $table.taglineSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signatorySnapshot => $composableBuilder(
    column: $table.signatorySnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatNumberSnapshot => $composableBuilder(
    column: $table.vatNumberSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tinNumberSnapshot => $composableBuilder(
    column: $table.tinNumberSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoPathSnapshot => $composableBuilder(
    column: $table.logoPathSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get validityDays => $composableBuilder(
    column: $table.validityDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get voidedAt =>
      $composableBuilder(column: $table.voidedAt, builder: (column) => column);

  GeneratedColumn<String> get voidReason => $composableBuilder(
    column: $table.voidReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get sourceQuoteId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceQuoteId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get replacesDocumentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacesDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> documentLinesRefs<T extends Object>(
    Expression<T> Function($$DocumentLinesTableAnnotationComposer a) f,
  ) {
    final $$DocumentLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentLines,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.documentLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePayments<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentReceipts<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.receiptDocumentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          DocumentData,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (DocumentData, $$DocumentsTableReferences),
          DocumentData,
          PrefetchHooks Function({
            bool customerId,
            bool sourceQuoteId,
            bool replacesDocumentId,
            bool documentLinesRefs,
            bool invoicePayments,
            bool paymentReceipts,
          })
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int?> sourceQuoteId = const Value.absent(),
                Value<int?> replacesDocumentId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> vatRateBasisPoints = const Value.absent(),
                Value<String> discountKind = const Value.absent(),
                Value<int> discountValue = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> termsSnapshot = const Value.absent(),
                Value<String> customerNameSnapshot = const Value.absent(),
                Value<String> customerLocationSnapshot = const Value.absent(),
                Value<String> customerPhoneSnapshot = const Value.absent(),
                Value<String> companyNameSnapshot = const Value.absent(),
                Value<String> legalNameSnapshot = const Value.absent(),
                Value<String> addressSnapshot = const Value.absent(),
                Value<String> phoneNumbersSnapshot = const Value.absent(),
                Value<String> taglineSnapshot = const Value.absent(),
                Value<String> signatorySnapshot = const Value.absent(),
                Value<String?> vatNumberSnapshot = const Value.absent(),
                Value<String?> tinNumberSnapshot = const Value.absent(),
                Value<String?> logoPathSnapshot = const Value.absent(),
                Value<int> validityDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime?> voidedAt = const Value.absent(),
                Value<String?> voidReason = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                documentType: documentType,
                status: status,
                documentNumber: documentNumber,
                customerId: customerId,
                sourceQuoteId: sourceQuoteId,
                replacesDocumentId: replacesDocumentId,
                currencyCode: currencyCode,
                vatRateBasisPoints: vatRateBasisPoints,
                discountKind: discountKind,
                discountValue: discountValue,
                notes: notes,
                termsSnapshot: termsSnapshot,
                customerNameSnapshot: customerNameSnapshot,
                customerLocationSnapshot: customerLocationSnapshot,
                customerPhoneSnapshot: customerPhoneSnapshot,
                companyNameSnapshot: companyNameSnapshot,
                legalNameSnapshot: legalNameSnapshot,
                addressSnapshot: addressSnapshot,
                phoneNumbersSnapshot: phoneNumbersSnapshot,
                taglineSnapshot: taglineSnapshot,
                signatorySnapshot: signatorySnapshot,
                vatNumberSnapshot: vatNumberSnapshot,
                tinNumberSnapshot: tinNumberSnapshot,
                logoPathSnapshot: logoPathSnapshot,
                validityDays: validityDays,
                createdAt: createdAt,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                voidedAt: voidedAt,
                voidReason: voidReason,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String documentType,
                required String status,
                Value<String?> documentNumber = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int?> sourceQuoteId = const Value.absent(),
                Value<int?> replacesDocumentId = const Value.absent(),
                required String currencyCode,
                Value<int> vatRateBasisPoints = const Value.absent(),
                Value<String> discountKind = const Value.absent(),
                Value<int> discountValue = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> termsSnapshot = const Value.absent(),
                Value<String> customerNameSnapshot = const Value.absent(),
                Value<String> customerLocationSnapshot = const Value.absent(),
                Value<String> customerPhoneSnapshot = const Value.absent(),
                Value<String> companyNameSnapshot = const Value.absent(),
                Value<String> legalNameSnapshot = const Value.absent(),
                Value<String> addressSnapshot = const Value.absent(),
                Value<String> phoneNumbersSnapshot = const Value.absent(),
                Value<String> taglineSnapshot = const Value.absent(),
                Value<String> signatorySnapshot = const Value.absent(),
                Value<String?> vatNumberSnapshot = const Value.absent(),
                Value<String?> tinNumberSnapshot = const Value.absent(),
                Value<String?> logoPathSnapshot = const Value.absent(),
                Value<int> validityDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime?> voidedAt = const Value.absent(),
                Value<String?> voidReason = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                documentType: documentType,
                status: status,
                documentNumber: documentNumber,
                customerId: customerId,
                sourceQuoteId: sourceQuoteId,
                replacesDocumentId: replacesDocumentId,
                currencyCode: currencyCode,
                vatRateBasisPoints: vatRateBasisPoints,
                discountKind: discountKind,
                discountValue: discountValue,
                notes: notes,
                termsSnapshot: termsSnapshot,
                customerNameSnapshot: customerNameSnapshot,
                customerLocationSnapshot: customerLocationSnapshot,
                customerPhoneSnapshot: customerPhoneSnapshot,
                companyNameSnapshot: companyNameSnapshot,
                legalNameSnapshot: legalNameSnapshot,
                addressSnapshot: addressSnapshot,
                phoneNumbersSnapshot: phoneNumbersSnapshot,
                taglineSnapshot: taglineSnapshot,
                signatorySnapshot: signatorySnapshot,
                vatNumberSnapshot: vatNumberSnapshot,
                tinNumberSnapshot: tinNumberSnapshot,
                logoPathSnapshot: logoPathSnapshot,
                validityDays: validityDays,
                createdAt: createdAt,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                voidedAt: voidedAt,
                voidReason: voidReason,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, DocumentData>(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                sourceQuoteId = false,
                replacesDocumentId = false,
                documentLinesRefs = false,
                invoicePayments = false,
                paymentReceipts = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (documentLinesRefs) db.documentLines,
                    if (invoicePayments) db.payments,
                    if (paymentReceipts) db.payments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (customerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$DocumentsTableReferences
                                ._customerIdTable(db),
                            referencedColumn: $$DocumentsTableReferences
                                ._customerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (sourceQuoteId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.sourceQuoteId,
                            referencedTable: $$DocumentsTableReferences
                                ._sourceQuoteIdTable(db),
                            referencedColumn: $$DocumentsTableReferences
                                ._sourceQuoteIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (replacesDocumentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.replacesDocumentId,
                            referencedTable: $$DocumentsTableReferences
                                ._replacesDocumentIdTable(db),
                            referencedColumn: $$DocumentsTableReferences
                                ._replacesDocumentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentLinesRefs)
                        await $_getPrefetchedData<
                          DocumentData,
                          $DocumentsTable,
                          DocumentLineData
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._documentLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicePayments)
                        await $_getPrefetchedData<
                          DocumentData,
                          $DocumentsTable,
                          PaymentData
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._invoicePaymentsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicePayments,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentReceipts)
                        await $_getPrefetchedData<
                          DocumentData,
                          $DocumentsTable,
                          PaymentData
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._paymentReceiptsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentReceipts,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.receiptDocumentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      DocumentData,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (DocumentData, $$DocumentsTableReferences),
      DocumentData,
      PrefetchHooks Function({
        bool customerId,
        bool sourceQuoteId,
        bool replacesDocumentId,
        bool documentLinesRefs,
        bool invoicePayments,
        bool paymentReceipts,
      })
    >;
typedef $$DocumentLinesTableCreateCompanionBuilder =
    DocumentLinesCompanion Function({
      Value<int> id,
      required int documentId,
      required int sortOrder,
      Value<bool> isSectionHeader,
      required String designation,
      Value<String> unit,
      Value<int?> unitPriceMinor,
      Value<int?> quantityMilli,
    });
typedef $$DocumentLinesTableUpdateCompanionBuilder =
    DocumentLinesCompanion Function({
      Value<int> id,
      Value<int> documentId,
      Value<int> sortOrder,
      Value<bool> isSectionHeader,
      Value<String> designation,
      Value<String> unit,
      Value<int?> unitPriceMinor,
      Value<int?> quantityMilli,
    });

final class $$DocumentLinesTableReferences
    extends
        BaseReferences<_$AppDatabase, $DocumentLinesTable, DocumentLineData> {
  $$DocumentLinesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('document_lines__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<int>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentLinesTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentLinesTable> {
  $$DocumentLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSectionHeader => $composableBuilder(
    column: $table.isSectionHeader,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentLinesTable> {
  $$DocumentLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSectionHeader => $composableBuilder(
    column: $table.isSectionHeader,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentLinesTable> {
  $$DocumentLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSectionHeader => $composableBuilder(
    column: $table.isSectionHeader,
    builder: (column) => column,
  );

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => column,
  );

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentLinesTable,
          DocumentLineData,
          $$DocumentLinesTableFilterComposer,
          $$DocumentLinesTableOrderingComposer,
          $$DocumentLinesTableAnnotationComposer,
          $$DocumentLinesTableCreateCompanionBuilder,
          $$DocumentLinesTableUpdateCompanionBuilder,
          (DocumentLineData, $$DocumentLinesTableReferences),
          DocumentLineData,
          PrefetchHooks Function({bool documentId})
        > {
  $$DocumentLinesTableTableManager(_$AppDatabase db, $DocumentLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> documentId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSectionHeader = const Value.absent(),
                Value<String> designation = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int?> unitPriceMinor = const Value.absent(),
                Value<int?> quantityMilli = const Value.absent(),
              }) => DocumentLinesCompanion(
                id: id,
                documentId: documentId,
                sortOrder: sortOrder,
                isSectionHeader: isSectionHeader,
                designation: designation,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                quantityMilli: quantityMilli,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int documentId,
                required int sortOrder,
                Value<bool> isSectionHeader = const Value.absent(),
                required String designation,
                Value<String> unit = const Value.absent(),
                Value<int?> unitPriceMinor = const Value.absent(),
                Value<int?> quantityMilli = const Value.absent(),
              }) => DocumentLinesCompanion.insert(
                id: id,
                documentId: documentId,
                sortOrder: sortOrder,
                isSectionHeader: isSectionHeader,
                designation: designation,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                quantityMilli: quantityMilli,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentLinesTable, DocumentLineData>(table),
                  $$DocumentLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.documentId,
                        referencedTable: $$DocumentLinesTableReferences
                            ._documentIdTable(db),
                        referencedColumn: $$DocumentLinesTableReferences
                            ._documentIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentLinesTable,
      DocumentLineData,
      $$DocumentLinesTableFilterComposer,
      $$DocumentLinesTableOrderingComposer,
      $$DocumentLinesTableAnnotationComposer,
      $$DocumentLinesTableCreateCompanionBuilder,
      $$DocumentLinesTableUpdateCompanionBuilder,
      (DocumentLineData, $$DocumentLinesTableReferences),
      DocumentLineData,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int invoiceId,
  required String currencyCode,
  required int amountMinor,
  required String method,
  required DateTime paidAt,
  Value<String> entryType,
  Value<int?> reversesPaymentId,
  Value<int?> receiptDocumentId,
  Value<String> note,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> invoiceId,
  Value<String> currencyCode,
  Value<int> amountMinor,
  Value<String> method,
  Value<DateTime> paidAt,
  Value<String> entryType,
  Value<int?> reversesPaymentId,
  Value<int?> receiptDocumentId,
  Value<String> note,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, PaymentData> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DocumentsTable _invoiceIdTable(_$AppDatabase db) =>
      db.documents.createAlias('payments__invoice_id__documents__id');

  $$DocumentsTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PaymentsTable _reversesPaymentIdTable(_$AppDatabase db) =>
      db.payments.createAlias('payments__reverses_payment_id__payments__id');

  $$PaymentsTableProcessedTableManager? get reversesPaymentId {
    final $_column = $_itemColumn<int>('reverses_payment_id');
    if ($_column == null) return null;
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reversesPaymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _receiptDocumentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('payments__receipt_document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get receiptDocumentId {
    final $_column = $_itemColumn<int>('receipt_document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receiptDocumentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get invoiceId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentsTableFilterComposer get reversesPaymentId {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reversesPaymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get receiptDocumentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get invoiceId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentsTableOrderingComposer get reversesPaymentId {
    final $$PaymentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reversesPaymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableOrderingComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get receiptDocumentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get entryType =>
      $composableBuilder(column: $table.entryType, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get invoiceId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentsTableAnnotationComposer get reversesPaymentId {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reversesPaymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get receiptDocumentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptDocumentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentData,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (PaymentData, $$PaymentsTableReferences),
          PaymentData,
          PrefetchHooks Function({
            bool invoiceId,
            bool reversesPaymentId,
            bool receiptDocumentId,
          })
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<String> entryType = const Value.absent(),
                Value<int?> reversesPaymentId = const Value.absent(),
                Value<int?> receiptDocumentId = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                method: method,
                paidAt: paidAt,
                entryType: entryType,
                reversesPaymentId: reversesPaymentId,
                receiptDocumentId: receiptDocumentId,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String currencyCode,
                required int amountMinor,
                required String method,
                required DateTime paidAt,
                Value<String> entryType = const Value.absent(),
                Value<int?> reversesPaymentId = const Value.absent(),
                Value<int?> receiptDocumentId = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                method: method,
                paidAt: paidAt,
                entryType: entryType,
                reversesPaymentId: reversesPaymentId,
                receiptDocumentId: receiptDocumentId,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentsTable, PaymentData>(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoiceId = false,
                reversesPaymentId = false,
                receiptDocumentId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (invoiceId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.invoiceId,
                            referencedTable: $$PaymentsTableReferences
                                ._invoiceIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._invoiceIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (reversesPaymentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.reversesPaymentId,
                            referencedTable: $$PaymentsTableReferences
                                ._reversesPaymentIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._reversesPaymentIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (receiptDocumentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.receiptDocumentId,
                            referencedTable: $$PaymentsTableReferences
                                ._receiptDocumentIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._receiptDocumentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentData,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentData, $$PaymentsTableReferences),
      PaymentData,
      PrefetchHooks Function({
        bool invoiceId,
        bool reversesPaymentId,
        bool receiptDocumentId,
      })
    >;
typedef $$TermsTemplatesTableCreateCompanionBuilder =
    TermsTemplatesCompanion Function({
      Value<int> id,
      required String name,
      required String content,
      Value<bool> isDefault,
      Value<DateTime> updatedAt,
    });
typedef $$TermsTemplatesTableUpdateCompanionBuilder =
    TermsTemplatesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> content,
      Value<bool> isDefault,
      Value<DateTime> updatedAt,
    });

class $$TermsTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TermsTemplatesTable> {
  $$TermsTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TermsTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TermsTemplatesTable> {
  $$TermsTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TermsTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TermsTemplatesTable> {
  $$TermsTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TermsTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TermsTemplatesTable,
          TermsTemplateData,
          $$TermsTemplatesTableFilterComposer,
          $$TermsTemplatesTableOrderingComposer,
          $$TermsTemplatesTableAnnotationComposer,
          $$TermsTemplatesTableCreateCompanionBuilder,
          $$TermsTemplatesTableUpdateCompanionBuilder,
          (
            TermsTemplateData,
            BaseReferences<
              _$AppDatabase,
              $TermsTemplatesTable,
              TermsTemplateData
            >,
          ),
          TermsTemplateData,
          PrefetchHooks Function()
        > {
  $$TermsTemplatesTableTableManager(
    _$AppDatabase db,
    $TermsTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TermsTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TermsTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TermsTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TermsTemplatesCompanion(
                id: id,
                name: name,
                content: content,
                isDefault: isDefault,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String content,
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TermsTemplatesCompanion.insert(
                id: id,
                name: name,
                content: content,
                isDefault: isDefault,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TermsTemplatesTable, TermsTemplateData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TermsTemplatesTable,
                    TermsTemplateData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TermsTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TermsTemplatesTable,
      TermsTemplateData,
      $$TermsTemplatesTableFilterComposer,
      $$TermsTemplatesTableOrderingComposer,
      $$TermsTemplatesTableAnnotationComposer,
      $$TermsTemplatesTableCreateCompanionBuilder,
      $$TermsTemplatesTableUpdateCompanionBuilder,
      (
        TermsTemplateData,
        BaseReferences<_$AppDatabase, $TermsTemplatesTable, TermsTemplateData>,
      ),
      TermsTemplateData,
      PrefetchHooks Function()
    >;
typedef $$NumberSequencesTableCreateCompanionBuilder =
    NumberSequencesCompanion Function({
      required String documentType,
      required String prefix,
      Value<int> nextNumber,
      Value<int> padding,
      Value<int> rowid,
    });
typedef $$NumberSequencesTableUpdateCompanionBuilder =
    NumberSequencesCompanion Function({
      Value<String> documentType,
      Value<String> prefix,
      Value<int> nextNumber,
      Value<int> padding,
      Value<int> rowid,
    });

class $$NumberSequencesTableFilterComposer
    extends Composer<_$AppDatabase, $NumberSequencesTable> {
  $$NumberSequencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextNumber => $composableBuilder(
    column: $table.nextNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get padding => $composableBuilder(
    column: $table.padding,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NumberSequencesTableOrderingComposer
    extends Composer<_$AppDatabase, $NumberSequencesTable> {
  $$NumberSequencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextNumber => $composableBuilder(
    column: $table.nextNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get padding => $composableBuilder(
    column: $table.padding,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NumberSequencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NumberSequencesTable> {
  $$NumberSequencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prefix =>
      $composableBuilder(column: $table.prefix, builder: (column) => column);

  GeneratedColumn<int> get nextNumber => $composableBuilder(
    column: $table.nextNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get padding =>
      $composableBuilder(column: $table.padding, builder: (column) => column);
}

class $$NumberSequencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NumberSequencesTable,
          NumberSequenceData,
          $$NumberSequencesTableFilterComposer,
          $$NumberSequencesTableOrderingComposer,
          $$NumberSequencesTableAnnotationComposer,
          $$NumberSequencesTableCreateCompanionBuilder,
          $$NumberSequencesTableUpdateCompanionBuilder,
          (
            NumberSequenceData,
            BaseReferences<
              _$AppDatabase,
              $NumberSequencesTable,
              NumberSequenceData
            >,
          ),
          NumberSequenceData,
          PrefetchHooks Function()
        > {
  $$NumberSequencesTableTableManager(
    _$AppDatabase db,
    $NumberSequencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NumberSequencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NumberSequencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NumberSequencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> documentType = const Value.absent(),
                Value<String> prefix = const Value.absent(),
                Value<int> nextNumber = const Value.absent(),
                Value<int> padding = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumberSequencesCompanion(
                documentType: documentType,
                prefix: prefix,
                nextNumber: nextNumber,
                padding: padding,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String documentType,
                required String prefix,
                Value<int> nextNumber = const Value.absent(),
                Value<int> padding = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumberSequencesCompanion.insert(
                documentType: documentType,
                prefix: prefix,
                nextNumber: nextNumber,
                padding: padding,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NumberSequencesTable, NumberSequenceData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NumberSequencesTable,
                    NumberSequenceData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NumberSequencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NumberSequencesTable,
      NumberSequenceData,
      $$NumberSequencesTableFilterComposer,
      $$NumberSequencesTableOrderingComposer,
      $$NumberSequencesTableAnnotationComposer,
      $$NumberSequencesTableCreateCompanionBuilder,
      $$NumberSequencesTableUpdateCompanionBuilder,
      (
        NumberSequenceData,
        BaseReferences<
          _$AppDatabase,
          $NumberSequencesTable,
          NumberSequenceData
        >,
      ),
      NumberSequenceData,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required String entityType,
  required int entityId,
  required String action,
  Value<DateTime> occurredAt,
  Value<String?> beforeSummary,
  Value<String?> afterSummary,
  Value<String> actor,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<int> entityId,
  Value<String> action,
  Value<DateTime> occurredAt,
  Value<String?> beforeSummary,
  Value<String?> afterSummary,
  Value<String> actor,
});

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeSummary => $composableBuilder(
    column: $table.beforeSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get afterSummary => $composableBuilder(
    column: $table.afterSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeSummary => $composableBuilder(
    column: $table.beforeSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get afterSummary => $composableBuilder(
    column: $table.afterSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beforeSummary => $composableBuilder(
    column: $table.beforeSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get afterSummary => $composableBuilder(
    column: $table.afterSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actor =>
      $composableBuilder(column: $table.actor, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLogData,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (
            AuditLogData,
            BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogData>,
          ),
          AuditLogData,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> beforeSummary = const Value.absent(),
                Value<String?> afterSummary = const Value.absent(),
                Value<String> actor = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                occurredAt: occurredAt,
                beforeSummary: beforeSummary,
                afterSummary: afterSummary,
                actor: actor,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required int entityId,
                required String action,
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> beforeSummary = const Value.absent(),
                Value<String?> afterSummary = const Value.absent(),
                Value<String> actor = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                occurredAt: occurredAt,
                beforeSummary: beforeSummary,
                afterSummary: afterSummary,
                actor: actor,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTable, AuditLogData>(table),
                  BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLogData,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (
        AuditLogData,
        BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLogData>,
      ),
      AuditLogData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompanyProfilesTableTableManager get companyProfiles =>
      $$CompanyProfilesTableTableManager(_db, _db.companyProfiles);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$CatalogItemsTableTableManager get catalogItems =>
      $$CatalogItemsTableTableManager(_db, _db.catalogItems);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$DocumentLinesTableTableManager get documentLines =>
      $$DocumentLinesTableTableManager(_db, _db.documentLines);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$TermsTemplatesTableTableManager get termsTemplates =>
      $$TermsTemplatesTableTableManager(_db, _db.termsTemplates);
  $$NumberSequencesTableTableManager get numberSequences =>
      $$NumberSequencesTableTableManager(_db, _db.numberSequences);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
}
