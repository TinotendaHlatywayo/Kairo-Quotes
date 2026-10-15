import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_util;
import 'package:path_provider/path_provider.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/default_business_data.dart';
import '../../data/settings_repository.dart';
import '../../domain/money.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({
    required this.profile,
    required this.terms,
    super.key,
  });

  final CompanyProfileData? profile;
  final TermsTemplateData? terms;

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _companyName;
  late final TextEditingController _legalName;
  late final TextEditingController _address;
  late final TextEditingController _phones;
  late final TextEditingController _tagline;
  late final TextEditingController _signatory;
  late final TextEditingController _vatRate;
  late final TextEditingController _vatNumber;
  late final TextEditingController _tinNumber;
  late final TextEditingController _quotePrefix;
  late final TextEditingController _invoicePrefix;
  late final TextEditingController _receiptPrefix;
  late final TextEditingController _terms;
  late String? _logoPath;
  late String? _signatureImagePath;
  late Set<String> _currencies;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    _companyName = TextEditingController(text: profile?.companyName ?? '');
    _legalName = TextEditingController(text: profile?.legalName ?? '');
    _address = TextEditingController(text: profile?.address ?? '');
    _phones = TextEditingController(text: profile?.phoneNumbers ?? '');
    _tagline = TextEditingController(text: profile?.tagline ?? '');
    _signatory = TextEditingController(text: profile?.signatory ?? '');
    _vatRate = TextEditingController(
      text: _formatPercent(profile?.vatRateBasisPoints ?? 1500),
    );
    _vatNumber = TextEditingController(text: profile?.vatNumber ?? '');
    _tinNumber = TextEditingController(text: profile?.tinNumber ?? '');
    _quotePrefix = TextEditingController(text: profile?.quotePrefix ?? 'QT-');
    _invoicePrefix = TextEditingController(text: profile?.invoicePrefix ?? 'INV-');
    _receiptPrefix = TextEditingController(text: profile?.receiptPrefix ?? 'RC-');
    _terms = TextEditingController(
      text: widget.terms?.content ?? defaultTerms.join('\n'),
    );
    _logoPath = profile?.logoPath;
    _signatureImagePath = profile?.signatureImagePath;
    _currencies = profile?.supportedCurrencies
            .split(',')
            .map((code) => code.trim())
            .where((code) => code.isNotEmpty)
            .toSet() ??
        {'USD', 'ZiG'};
  }

  @override
  void dispose() {
    for (final controller in [
      _companyName,
      _legalName,
      _address,
      _phones,
      _tagline,
      _signatory,
      _vatRate,
      _vatNumber,
      _tinNumber,
      _quotePrefix,
      _invoicePrefix,
      _receiptPrefix,
      _terms,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstRun = widget.profile == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(firstRun ? 'Set up Kairo Quotes' : 'Company settings'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (firstRun) ...[
                Text(
                  'Set up your company details to start preparing documents.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
              ],
              _sectionTitle(context, 'Company details'),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: _saving ? null : _chooseLogo,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: Text(_logoPath == null ? 'Add company logo' : 'Change logo'),
                ),
              ),
              if (_logoPath != null && File(_logoPath!).existsSync()) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_logoPath!),
                    height: 96,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: _saving ? null : _chooseSignatureImage,
                  icon: const Icon(Icons.draw_outlined),
                  label: Text(_signatureImagePath == null
                      ? 'Add signature image'
                      : 'Change signature image'),
                ),
              ),
              if (_signatureImagePath != null && File(_signatureImagePath!).existsSync()) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_signatureImagePath!),
                    height: 72,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              _field(_companyName, 'Company name', required: true),
              _field(_legalName, 'Legal name (optional)'),
              _field(_address, 'Address', maxLines: 2),
              _field(
                _phones,
                'Phone numbers',
                hint: 'For example: 0772 123 456 or +263 772 123 456',
              ),
              _field(_tagline, 'Document tagline'),
              _field(_signatory, 'Signatory name'),
              _field(_vatNumber, 'VAT number (optional)'),
              _field(_tinNumber, 'TIN / BP number (optional)'),
              const SizedBox(height: 12),
              _sectionTitle(context, 'VAT and currency'),
              _field(
                _vatRate,
                'VAT rate (%)',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  try {
                    parsePercentToBasisPoints(value ?? '');
                    return null;
                  } on FormatException catch (error) {
                    return error.message.toString();
                  }
                },
              ),
              Text(
                'Verify the current VAT rate and invoicing requirements with ZIMRA.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text('Supported currencies', style: Theme.of(context).textTheme.titleSmall),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('USD'),
                value: _currencies.contains('USD'),
                onChanged: _saving ? null : (checked) => _toggleCurrency('USD', checked),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('ZiG'),
                value: _currencies.contains('ZiG'),
                onChanged: _saving ? null : (checked) => _toggleCurrency('ZiG', checked),
              ),
              _sectionTitle(context, 'Document numbering'),
              _field(_quotePrefix, 'Quotation prefix', required: true),
              _field(_invoicePrefix, 'Invoice prefix', required: true),
              _field(_receiptPrefix, 'Receipt prefix', required: true),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _sectionTitle(context, 'Default terms')),
                  TextButton.icon(
                    onPressed: _saving
                        ? null
                        : () => _terms.text = defaultTerms.join('\n'),
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset'),
                  ),
                ],
              ),
              TextFormField(
                controller: _terms,
                minLines: 7,
                maxLines: 12,
                decoration: const InputDecoration(
                  labelText: 'One term per line',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(firstRun ? 'Save and continue' : 'Save settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _field(
    TextEditingController controller,
    String label, {
    String? hint,
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, hintText: hint),
        validator: validator ??
            (value) => required && (value == null || value.trim().isEmpty)
                ? 'Required'
                : null,
      ),
    );
  }

  void _toggleCurrency(String code, bool? checked) {
    setState(() {
      if (checked ?? false) {
        _currencies.add(code);
      } else {
        _currencies.remove(code);
      }
    });
  }

  Future<void> _chooseSignatureImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 400,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;

    final supportDirectory = await getApplicationSupportDirectory();
    final extension = path_util.extension(picked.path).toLowerCase();
    final destination = path_util.join(
      supportDirectory.path,
      'company_signature${extension.isEmpty ? '.png' : extension}',
    );
    await File(picked.path).copy(destination);
    if (mounted) setState(() => _signatureImagePath = destination);
  }

  Future<void> _chooseLogo() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;

    final supportDirectory = await getApplicationSupportDirectory();
    final extension = path_util.extension(picked.path).toLowerCase();
    final destination = path_util.join(
      supportDirectory.path,
      'company_logo${extension.isEmpty ? '.jpg' : extension}',
    );
    await File(picked.path).copy(destination);
    if (mounted) setState(() => _logoPath = destination);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_currencies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one currency.')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final vatBasisPoints = parsePercentToBasisPoints(_vatRate.text);
      final draft = CompanyProfileDraft(
        companyName: _companyName.text,
        legalName: _legalName.text,
        address: _address.text,
        phoneNumbers: _phones.text,
        tagline: _tagline.text,
        signatory: _signatory.text,
        vatRateBasisPoints: vatBasisPoints,
        vatNumber: _vatNumber.text,
        tinNumber: _tinNumber.text,
        supportedCurrencies: _currencies.toList(),
        logoPath: _logoPath,
        signatureImagePath: _signatureImagePath,
        quotePrefix: _quotePrefix.text,
        invoicePrefix: _invoicePrefix.text,
        receiptPrefix: _receiptPrefix.text,
      );
      await ref.read(settingsRepositoryProvider).save(
        profile: draft,
        defaultTermsLines: _terms.text.split('\n'),
      );
      ref.invalidate(defaultTermsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Company settings saved.')),
      );
      if (widget.profile != null) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save settings: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  static String _formatPercent(int basisPoints) {
    final whole = basisPoints ~/ 100;
    final fraction = (basisPoints % 100).toString().padLeft(2, '0');
    return '$whole.$fraction';
  }
}
