import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/quote_repository.dart';
import '../../domain/money.dart';
import '../../domain/pricing_engine.dart';
import '../customers/customers_screen.dart';
import 'quote_pdf.dart';

class QuotesScreen extends ConsumerWidget {
  const QuotesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(quoteRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Quotations')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const QuoteEditorScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('New quote'),
      ),
      body: StreamBuilder<List<DocumentData>>(
        stream: repository.watchQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load quotations: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final quotes = snapshot.data!;
          if (quotes.isEmpty) {
            return const Center(
              child: Text('No quotations yet. Create one to get started.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: quotes.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final q = quotes[index];
              return ListTile(
                leading: Icon(
                  q.status == 'issued' ? Icons.description : Icons.edit_note,
                ),
                title: Text(q.documentNumber ?? 'Draft quotation'),
                subtitle: Text(
                  '${q.customerNameSnapshot}\n${q.status.toUpperCase()} · ${_date(q.createdAt)}',
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => QuoteEditorScreen(quoteId: q.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static String _date(DateTime d) => '${d.day}/${d.month}/${d.year}';
}

class QuoteEditorScreen extends ConsumerStatefulWidget {
  const QuoteEditorScreen({this.quoteId, super.key});
  final int? quoteId;
  @override
  ConsumerState<QuoteEditorScreen> createState() => _QuoteEditorScreenState();
}

class _QuoteEditorScreenState extends ConsumerState<QuoteEditorScreen> {
  late Future<void> _load;
  List<CustomerData> _customers = [];
  List<String> _currencies = ['USD', 'ZiG'];
  int? _customerId;
  String _currency = 'USD';
  int _vat = 1500;
  String _discountKind = 'none';
  int _discountValue = 0;
  int _validity = 30;
  String _terms = '';
  bool _saveTerms = false;
  bool _locked = false;
  int? _id;
  DocumentData? _quote;
  String? _error;
  final List<_QuoteLine> _lines = [];
  List<int?>? _undoPrices;

  bool get _editable => !_locked;
  @override
  void initState() {
    super.initState();
    _id = widget.quoteId;
    _load = _initialize();
  }

  @override
  void dispose() {
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  Future<void> _initialize() async {
    final customers = await ref
        .read(customerRepositoryProvider)
        .watchCustomers(includeArchived: widget.quoteId != null)
        .first;
    final profile = await ref
        .read(settingsRepositoryProvider)
        .watchCompanyProfile()
        .first;
    final terms = await ref.read(settingsRepositoryProvider).getDefaultTerms();
    _customers = customers;
    if (profile != null) {
      _currencies = profile.supportedCurrencies
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (_currencies.isEmpty) _currencies = ['USD'];
      _currency = _currencies.first;
      _vat = profile.vatRateBasisPoints;
      _validity = profile.defaultValidityDays;
    }
    _terms = terms?.content ?? '';
    if (_id == null) return;
    _quote = await ref.read(quoteRepositoryProvider).getQuote(_id!);
    if (_quote == null) throw StateError('Quotation no longer exists.');
    final quote = _quote!;
    _locked = quote.status != 'draft';
    _customerId = quote.customerId;
    _currency = quote.currencyCode;
    if (!_currencies.contains(_currency)) _currencies.add(_currency);
    _vat = quote.vatRateBasisPoints;
    _discountKind = quote.discountKind;
    _discountValue = quote.discountValue;
    _validity = quote.validityDays;
    _terms = quote.termsSnapshot;
    final savedLines = await ref.read(quoteRepositoryProvider).getLines(_id!);
    for (final line in savedLines) {
      _lines.add(
        _QuoteLine(
          line.designation,
          unit: line.unit,
          priceMinor: line.unitPriceMinor,
          quantityMilli: line.quantityMilli,
          section: line.isSectionHeader,
        ),
      );
    }
  }

  QuoteDraft _draft() => QuoteDraft(
    customerId: _customerId ?? 0,
    currencyCode: _currency,
    vatRateBasisPoints: _vat,
    discountKind: _discountKind,
    discountValue: _discountValue,
    validityDays: _validity,
    terms: _terms,
    saveTermsAsDefault: _saveTerms,
    lines: _lines.map((line) => line.toDraft()).toList(),
  );

  Future<void> _save({bool issue = false}) async {
    FocusScope.of(context).unfocus();
    try {
      final repository = ref.read(quoteRepositoryProvider);
      _id = issue
          ? await repository.saveAndIssue(_draft(), id: _id)
          : await repository.saveDraft(_draft(), id: _id);
      if (issue) _quote = await repository.getQuote(_id!);
      setState(() {
        _locked = issue;
        _error = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(issue ? 'Quotation issued.' : 'Draft saved.')),
        );
      }
    } catch (error) {
      setState(() => _error = '$error');
    }
  }

  Future<void> _addCustomer() async {
    final repository = ref.read(customerRepositoryProvider);
    await showDialog<void>(
      context: context,
      builder: (_) => CustomerFormDialog(
        onSave: (draft) async {
          final id = await repository.save(draft);
          if (mounted) {
            setState(() {
              _customerId = id;
            });
          }
          return id;
        },
      ),
    );
    _customers = await repository.watchCustomers(includeArchived: true).first;
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _addCatalog() async {
    final items = await ref.read(catalogRepositoryProvider).watchItems().first;
    if (!mounted) return;
    final selected = await showDialog<CatalogItemData>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Add from catalog'),
        children: [
          for (final item in items)
            ListTile(
              leading: Icon(
                item.isSection
                    ? Icons.view_agenda_outlined
                    : Icons.inventory_2_outlined,
              ),
              title: Text(item.designation),
              subtitle: item.isSection
                  ? null
                  : Text(
                      item.defaultUnitPriceMinor == null
                          ? item.unit
                          : '${item.unit} · ${item.defaultPriceCurrencyCode} ${item.defaultUnitPriceMinor} minor',
                    ),
              onTap: () => Navigator.pop(context, item),
            ),
        ],
      ),
    );
    if (selected == null || !mounted) return;
    setState(
      () => _lines.add(
        _QuoteLine(
          selected.designation,
          unit: selected.unit,
          priceMinor: selected.defaultPriceCurrencyCode == _currency
              ? selected.defaultUnitPriceMinor
              : null,
          quantityMilli: selected.isSection ? null : 1000,
          section: selected.isSection,
        ),
      ),
    );
    if (!selected.isSection &&
        selected.defaultUnitPriceMinor != null &&
        selected.defaultPriceCurrencyCode != _currency) {
      _message(
        'Catalog price is in ${selected.defaultPriceCurrencyCode}; enter a $_currency price.',
      );
    }
  }

  Future<void> _addCustom({bool section = false}) async {
    final designation = TextEditingController();
    final unit = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(section ? 'Add section heading' : 'Add custom item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: designation,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            if (!section)
              TextField(
                controller: unit,
                decoration: const InputDecoration(labelText: 'Unit (optional)'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (accepted == true && designation.text.trim().isNotEmpty && mounted) {
      setState(
        () => _lines.add(
          _QuoteLine(
            designation.text.trim(),
            unit: unit.text.trim(),
            section: section,
            quantityMilli: section ? null : 1000,
          ),
        ),
      );
    }
    designation.dispose();
    unit.dispose();
  }

  Future<void> _adjustPrices() async {
    final input = TextEditingController(text: '0');
    var round = false;
    final result = await showDialog<(int, bool)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialog) => AlertDialog(
          title: const Text('Adjust all unit prices'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: input,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Percent (+ or −)',
                  suffixText: '%',
                ),
              ),
              CheckboxListTile(
                value: round,
                onChanged: (v) => setDialog(() => round = v ?? false),
                title: const Text('Round to whole currency unit'),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                try {
                  final signed = input.text.trim().replaceAll(',', '.');
                  final m = RegExp(r'^([+-]?)(\d{1,3})(?:\.(\d{1,2}))?$')
                      .firstMatch(signed);
                  if (m == null) {
                    throw const FormatException(
                      'Enter a percentage, for example 5 or -2.5.',
                    );
                  }
                  final value =
                      int.parse(m.group(2)!) * 100 +
                      int.parse((m.group(3) ?? '').padRight(2, '0'));
                  Navigator.pop(context, (
                    (m.group(1) == '-' ? -1 : 1) * value,
                    round,
                  ));
                } catch (e) {
                  _message('$e');
                }
              },
              child: const Text('Preview'),
            ),
          ],
        ),
      ),
    );
    input.dispose();
    if (result == null || !mounted) return;
    try {
      const engine = PricingEngine();
      final preview = engine.previewPriceAdjustment(
        unitPricesMinor: _lines
            .map((l) => l.section ? null : l.priceMinor)
            .toList(),
        sectionHeaders: _lines.map((l) => l.section).toList(),
        adjustmentBasisPoints: result.$1,
        roundToWholeCurrencyUnit: result.$2,
      );
      final changes = <String>[];
      for (var i = 0; i < _lines.length; i++) {
        if (!_lines[i].section) {
          changes.add(
            '${_lines[i].designation.text}: ${MoneyFormatter.format(preview.originalUnitPricesMinor[i]!, _currency)} → ${MoneyFormatter.format(preview.adjustedUnitPricesMinor[i]!, _currency)}',
          );
        }
      }
      final apply = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Price preview'),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: changes
                    .map(
                      (s) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(s),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Apply'),
            ),
          ],
        ),
      );
      if (apply == true) {
        setState(() {
          _undoPrices = _lines.map((l) => l.priceMinor).toList();
          for (var i = 0; i < _lines.length; i++) {
            if (!_lines[i].section) {
              _lines[i].setPrice(preview.adjustedUnitPricesMinor[i]);
            }
          }
        });
      }
    } catch (e) {
      _message('$e');
    }
  }

  void _message(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> _openPdf({required bool share}) async {
    if (_id == null) {
      _message('Save the draft before previewing it.');
      return;
    }
    try {
      final quote = await ref.read(quoteRepositoryProvider).getQuote(_id!);
      if (quote == null) throw StateError('Quotation not found.');
      final lines = await ref.read(quoteRepositoryProvider).getLines(_id!);
      final bytes = await QuotePdf.build(quote, lines);
      if (share) {
        await Printing.sharePdf(
          bytes: bytes,
          filename: '${quote.documentNumber ?? 'quotation-draft'}.pdf',
        );
        return;
      }
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('PDF preview')),
            body: PdfPreview(
              build: (_) async => bytes,
              allowPrinting: true,
              allowSharing: true,
              canChangePageFormat: false,
              pdfFileName: '${quote.documentNumber ?? 'quotation-draft'}.pdf',
            ),
          ),
        ),
      );
    } catch (error) {
      _message('Could not create PDF: $error');
    }
  }

  Future<void> _duplicate() async {
    try {
      final id = await ref.read(quoteRepositoryProvider).duplicate(_id!);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => QuoteEditorScreen(quoteId: id),
          ),
        );
      }
    } catch (e) {
      _message('Could not duplicate quote: $e');
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
    future: _load,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Scaffold(
          appBar: AppBar(title: const Text('Quotation')),
          body: Center(child: Text('${snapshot.error}')),
        );
      }
      if (snapshot.connectionState != ConnectionState.done) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      PricingResult? totals;
      try {
        totals = const PricingEngine().calculate(
          lines: _lines.map((l) => l.toPricing()).toList(),
          vatRateBasisPoints: _vat,
          discount: switch (_discountKind) {
            'percent' => Discount.percent(_discountValue),
            'fixed' => Discount.fixed(_discountValue),
            _ => const Discount.none(),
          },
        );
      } catch (_) {}
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _quote?.documentNumber ?? (_locked ? 'Quotation' : 'New quotation'),
          ),
          actions: [
            if (_id != null)
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'preview') _openPdf(share: false);
                  if (v == 'share') _openPdf(share: true);
                  if (v == 'duplicate') _duplicate();
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'preview',
                    child: Text('Preview PDF'),
                  ),
                  const PopupMenuItem(value: 'share', child: Text('Share PDF')),
                  const PopupMenuItem(
                    value: 'duplicate',
                    child: Text('Duplicate as draft'),
                  ),
                ],
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            if (_locked)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text('Issued quotation is locked'),
                  subtitle: Text('Duplicate it to create an editable draft.'),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _customerId,
                    decoration: const InputDecoration(labelText: 'Customer'),
                    items: _customers
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: _editable
                        ? (v) => setState(() => _customerId = v)
                        : null,
                  ),
                ),
                IconButton(
                  tooltip: 'Add customer',
                  onPressed: _editable ? _addCustomer : null,
                  icon: const Icon(Icons.person_add_alt_1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _currency,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: _currencies
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: _editable
                        ? (v) => setState(() => _currency = v!)
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    key: ValueKey('vat-$_vat'),
                    initialValue: (_vat / 100).toStringAsFixed(2),
                    enabled: _editable,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'VAT %'),
                    onChanged: (v) {
                      try {
                        setState(() => _vat = parsePercentToBasisPoints(v));
                      } catch (_) {}
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _discountKind,
                    decoration: const InputDecoration(labelText: 'Discount'),
                    items: const [
                      DropdownMenuItem(value: 'none', child: Text('None')),
                      DropdownMenuItem(
                        value: 'percent',
                        child: Text('Percent'),
                      ),
                      DropdownMenuItem(
                        value: 'fixed',
                        child: Text('Fixed amount'),
                      ),
                    ],
                    onChanged: _editable
                        ? (v) => setState(() {
                            _discountKind = v!;
                            _discountValue = 0;
                          })
                        : null,
                  ),
                ),
                if (_discountKind != 'none') const SizedBox(width: 10),
                if (_discountKind != 'none')
                  Expanded(
                    child: TextFormField(
                      key: ValueKey('discount-$_discountKind-$_discountValue'),
                      initialValue: _discountKind == 'percent'
                          ? (_discountValue / 100).toStringAsFixed(2)
                          : _discountValue == 0
                          ? ''
                          : (_discountValue / 100).toStringAsFixed(2),
                      enabled: _editable,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: _discountKind == 'percent'
                            ? 'Discount %'
                            : 'Amount',
                      ),
                      onChanged: (v) {
                        try {
                          setState(
                            () => _discountValue = _discountKind == 'percent'
                                ? parsePercentToBasisPoints(v)
                                : _parseMinor(v),
                          );
                        } catch (_) {}
                      },
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              key: ValueKey('validity-$_validity'),
              initialValue: '$_validity',
              enabled: _editable,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Validity (days)'),
              onChanged: (v) {
                final n = int.tryParse(v);
                if (n != null) setState(() => _validity = n);
              },
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (_editable)
                  IconButton(
                    tooltip: 'Adjust prices',
                    onPressed: _lines.isEmpty ? null : _adjustPrices,
                    icon: const Icon(Icons.price_change_outlined),
                  ),
                if (_undoPrices != null && _editable)
                  TextButton(
                    onPressed: () => setState(() {
                      for (var i = 0; i < _lines.length; i++) {
                        _lines[i].setPrice(_undoPrices![i]);
                      }
                      _undoPrices = null;
                    }),
                    child: const Text('Undo'),
                  ),
                if (_editable)
                  PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'catalog') _addCatalog();
                      if (v == 'custom') _addCustom();
                      if (v == 'section') _addCustom(section: true);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'catalog',
                        child: Text('From catalog'),
                      ),
                      PopupMenuItem(
                        value: 'custom',
                        child: Text('Custom item'),
                      ),
                      PopupMenuItem(
                        value: 'section',
                        child: Text('Section heading'),
                      ),
                    ],
                    icon: const Icon(Icons.add_circle_outline),
                  ),
              ],
            ),
            if (_lines.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Add catalog items, custom work, or section headings.',
                  ),
                ),
              ),
            for (var i = 0; i < _lines.length; i++) _lineCard(i),
            if (totals != null)
              Card(
                margin: const EdgeInsets.only(top: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      _moneyRow('Subtotal', totals.subtotalMinor),
                      if (totals.discountMinor > 0)
                        _moneyRow('Discount', -totals.discountMinor),
                      _moneyRow('VAT', totals.vatMinor),
                      const Divider(),
                      _moneyRow('Total', totals.grandTotalMinor, bold: true),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 14),
            TextFormField(
              initialValue: _terms,
              enabled: _editable,
              minLines: 3,
              maxLines: 9,
              decoration: const InputDecoration(
                labelText: 'Terms and conditions',
              ),
              onChanged: (v) => _terms = v,
            ),
            if (_editable)
              CheckboxListTile(
                value: _saveTerms,
                onChanged: (v) => setState(() => _saveTerms = v ?? false),
                title: const Text('Save these terms as default'),
                contentPadding: EdgeInsets.zero,
              ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_id != null)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: OutlinedButton.icon(
                  onPressed: () => _openPdf(share: false),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Preview PDF'),
                ),
              ),
            if (_editable)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: OutlinedButton(
                  onPressed: () => _save(),
                  child: const Text('Save draft'),
                ),
              ),
            if (_editable)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FilledButton.icon(
                  onPressed: () => _save(issue: true),
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('Issue quotation'),
                ),
              ),
            if (_locked)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FilledButton.icon(
                  onPressed: () => _openPdf(share: true),
                  icon: const Icon(Icons.share),
                  label: const Text('Share quotation PDF'),
                ),
              ),
          ],
        ),
      );
    },
  );

  Widget _lineCard(int index) {
    final line = _lines[index];
    if (line.section) {
      return Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: ListTile(
          title: Text(
            line.designation.text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: _editable
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() {
                    _lines.removeAt(index).dispose();
                  }),
                )
              : null,
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: line.designation,
                    enabled: _editable,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ),
                if (_editable)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _lines.removeAt(index).dispose();
                    }),
                  ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: line.unit,
                    enabled: _editable,
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: line.price,
                    enabled: _editable,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Unit price ($_currency)',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: line.quantity,
                    enabled: _editable,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(_rowTotal(line)),
            ),
          ],
        ),
      ),
    );
  }

  String _rowTotal(_QuoteLine line) {
    try {
      final result = const PricingEngine().calculate(
        lines: [line.toPricing()],
        vatRateBasisPoints: 0,
      );
      return MoneyFormatter.format(result.subtotalMinor, _currency);
    } catch (_) {
      return 'Enter price and quantity';
    }
  }

  Widget _moneyRow(String label, int value, {bool bold = false}) {
    final textStyle = bold
        ? const TextStyle(fontWeight: FontWeight.bold)
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(MoneyFormatter.format(value, _currency), style: textStyle),
        ],
      ),
    );
  }

  static int _parseMinor(String input) {
    final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(input.trim());
    if (match == null) {
      throw const FormatException('Enter an amount with up to two decimals.');
    }
    return int.parse(match.group(1)!) * 100 +
        int.parse((match.group(2) ?? '').padRight(2, '0'));
  }
}

class _QuoteLine {
  _QuoteLine(
    String designation, {
    String unit = '',
    int? priceMinor,
    int? quantityMilli,
    this.section = false,
  }) : designation = TextEditingController(text: designation),
       unit = TextEditingController(text: unit),
       price = TextEditingController(
         text: priceMinor == null
             ? ''
             : '${priceMinor ~/ 100}.${(priceMinor % 100).toString().padLeft(2, '0')}',
       ),
       quantity = TextEditingController(
         text: quantityMilli == null ? '' : Quantity(quantityMilli).format(),
       );
  final TextEditingController designation, unit, price, quantity;
  final bool section;
  int? get priceMinor => int.tryParse(price.text.split('.').first) == null
      ? null
      : _QuoteEditorScreenState._parseMinor(price.text);
  int? get quantityMilli {
    try {
      return Quantity.parse(quantity.text).milliUnits;
    } catch (_) {
      return null;
    }
  }

  void setPrice(int? value) {
    price.text = value == null
        ? ''
        : '${value ~/ 100}.${(value % 100).toString().padLeft(2, '0')}';
  }

  PricingLine toPricing() => PricingLine(
    isSectionHeader: section,
    unitPriceMinor: section ? null : priceMinor,
    quantityMilli: section ? null : quantityMilli,
  );
  QuoteLineDraft toDraft() => QuoteLineDraft(
    designation: designation.text,
    unit: unit.text,
    unitPriceMinor: section ? null : priceMinor,
    quantityMilli: section ? null : quantityMilli,
    isSectionHeader: section,
  );
  void dispose() {
    designation.dispose();
    unit.dispose();
    price.dispose();
    quantity.dispose();
  }
}
