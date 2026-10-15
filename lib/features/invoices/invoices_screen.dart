import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../domain/money.dart';
import '../../domain/payment_methods.dart';
import '../quotes/quote_pdf.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});
  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
  String search = '';
  String status = 'all';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Invoices')),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search invoices',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (v) => setState(() => search = v),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            initialValue: status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All statuses')),
              DropdownMenuItem(value: 'issued', child: Text('Outstanding')),
              DropdownMenuItem(
                value: 'partially_paid',
                child: Text('Partially paid'),
              ),
              DropdownMenuItem(value: 'paid', child: Text('Paid')),
              DropdownMenuItem(value: 'void', child: Text('Void')),
            ],
            onChanged: (v) => setState(() => status = v ?? 'all'),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<DocumentData>>(
            stream: ref
                .watch(invoiceRepositoryProvider)
                .watchInvoices(search: search, status: status),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: Text('Could not load invoices: ${snap.error}'),
                );
              }
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No invoices yet. Accept a quotation to create one.',
                  ),
                );
              }
              return ListView.separated(
                itemCount: snap.data!.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final invoice = snap.data![i];
                  return ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: Text(invoice.documentNumber ?? 'Invoice'),
                    subtitle: Text(
                      '${invoice.customerNameSnapshot}\n${invoice.status.replaceAll('_', ' ').toUpperCase()} · ${invoice.currencyCode}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            InvoiceDetailScreen(invoiceId: invoice.id),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

class InvoiceDetailScreen extends ConsumerStatefulWidget {
  const InvoiceDetailScreen({required this.invoiceId, super.key});
  final int invoiceId;
  @override
  ConsumerState<InvoiceDetailScreen> createState() =>
      _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends ConsumerState<InvoiceDetailScreen> {
  late Future<(DocumentData, List<DocumentLineData>, List<PaymentData>)> load;
  @override
  void initState() {
    super.initState();
    load = _load();
  }

  Future<(DocumentData, List<DocumentLineData>, List<PaymentData>)>
  _load() async {
    final repo = ref.read(invoiceRepositoryProvider);
    final invoice = await repo.getInvoice(widget.invoiceId);
    if (invoice == null) throw StateError('Invoice not found.');
    return (
      invoice,
      await repo.getLines(widget.invoiceId),
      await repo.getPayments(widget.invoiceId),
    );
  }

  void refresh() => setState(() => load = _load());
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Invoice details')),
    body:
        FutureBuilder<
          (DocumentData, List<DocumentLineData>, List<PaymentData>)
        >(
          future: load,
          builder: (context, snap) {
            if (snap.hasError) return Center(child: Text('${snap.error}'));
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final (invoice, lines, payments) = snap.data!;
            final repo = ref.read(invoiceRepositoryProvider);
            final total = repo.calculateTotal(invoice, lines);
            final received = payments.fold<int>(
              0,
              (s, p) =>
                  s +
                  (p.entryType == 'payment' ? p.amountMinor : -p.amountMinor),
            );
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.documentNumber ?? 'Invoice',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(invoice.customerNameSnapshot),
                        Text(invoice.status.replaceAll('_', ' ').toUpperCase()),
                        const Divider(),
                        _row('Invoice total', invoice.currencyCode, total),
                        _row('Paid', invoice.currencyCode, received),
                        _row('Balance', invoice.currencyCode, total - received),
                        if (invoice.status == 'void')
                          Text('Void reason: ${invoice.voidReason ?? ''}'),
                      ],
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pdf(invoice, lines),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Preview invoice PDF'),
                ),
                if (invoice.status != 'void' && received < total)
                  FilledButton.icon(
                    onPressed: () async {
                      if (await _paymentDialog(context, invoice)) refresh();
                    },
                    icon: const Icon(Icons.payments_outlined),
                    label: const Text('Record payment'),
                  ),
                if (invoice.status != 'void' && received == 0)
                  OutlinedButton.icon(
                    onPressed: () async {
                      final reason = await _reasonDialog(
                        context,
                        'Void invoice',
                        'Reason',
                      );
                      if (reason == null) return;
                      try {
                        await repo.voidInvoice(invoice.id, reason);
                        refresh();
                      } catch (e) {
                        _message('$e');
                      }
                    },
                    icon: const Icon(Icons.block),
                    label: const Text('Void invoice'),
                  ),
                if (invoice.status == 'void')
                  OutlinedButton.icon(
                    onPressed: () async {
                      try {
                        final navigator = Navigator.of(context);
                        final replacement = await repo.replaceVoidedInvoice(
                          invoice.id,
                        );
                        if (!mounted) return;
                        navigator.pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                InvoiceDetailScreen(invoiceId: replacement),
                          ),
                        );
                      } catch (e) {
                        _message('$e');
                      }
                    },
                    icon: const Icon(Icons.copy_outlined),
                    label: const Text('Create replacement invoice'),
                  ),
                const SizedBox(height: 10),
                Text(
                  'Payment history',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (payments.isEmpty)
                  const ListTile(title: Text('No payments recorded')),
                for (final p in payments) _paymentTile(p, invoice),
              ],
            );
          },
        ),
  );

  Widget _row(String label, String currency, int amount) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label), Text(MoneyFormatter.format(amount, currency))],
    ),
  );
  Widget _paymentTile(PaymentData payment, DocumentData invoice) => Card(
    child: ListTile(
      leading: Icon(
        payment.entryType == 'reversal'
            ? Icons.undo
            : Icons.check_circle_outline,
      ),
      title: Text(
        '${payment.entryType == 'reversal' ? 'Reversal' : 'Payment'} · ${MoneyFormatter.format(payment.amountMinor, payment.currencyCode)}',
      ),
      subtitle: Text(
        '${payment.method} · ${payment.paidAt.day}/${payment.paidAt.month}/${payment.paidAt.year}${payment.note.isEmpty ? '' : '\n${payment.note}'}',
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (v) {
          if (v == 'receipt') _receipt(payment);
          if (v == 'reverse') _reverse(payment);
        },
        itemBuilder: (_) => [
          const PopupMenuItem(
            value: 'receipt',
            child: Text('Preview receipt PDF'),
          ),
          if (payment.entryType == 'payment')
            const PopupMenuItem(
              value: 'reverse',
              child: Text('Reverse payment'),
            ),
        ],
      ),
    ),
  );

  Future<bool> _paymentDialog(
    BuildContext context,
    DocumentData invoice,
  ) async {
    final amount = TextEditingController();
    final note = TextEditingController();
    const methods = paymentMethodOptions;
    String method = methods.first;
    DateTime date = DateTime.now();
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, set) => AlertDialog(
          title: const Text('Record payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount (${invoice.currencyCode})',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: method,
                decoration: const InputDecoration(labelText: 'Method'),
                items: methods
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => set(() => method = v ?? methods.first),
              ),
              TextButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                    initialDate: date,
                  );
                  if (picked != null) set(() => date = picked);
                },
                icon: const Icon(Icons.calendar_today),
                label: Text('Date: ${date.day}/${date.month}/${date.year}'),
              ),
              TextField(
                controller: note,
                decoration: const InputDecoration(labelText: 'Note (optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (yes != true) return false;
    try {
      final amountMinor = parseMoneyToMinor(amount.text, invoice.currencyCode);
      if (amountMinor <= 0) throw const FormatException();
      await ref
          .read(invoiceRepositoryProvider)
          .recordPayment(
            invoice.id,
            amountMinor: amountMinor,
            method: method,
            paidAt: date,
            note: note.text,
          );
      _message('Payment recorded and receipt numbered.');
      return true;
    } catch (e) {
      _message(e is FormatException ? 'Enter a valid amount.' : '$e');
      return false;
    }
  }

  Future<void> _reverse(PaymentData payment) async {
    final reason = await _reasonDialog(
      context,
      'Reverse payment',
      'Reason for reversal',
    );
    if (reason == null) return;
    try {
      await ref
          .read(invoiceRepositoryProvider)
          .reversePayment(payment.id, reason: reason);
      refresh();
      _message('Reversal recorded with a receipt.');
    } catch (e) {
      _message('$e');
    }
  }

  Future<String?> _reasonDialog(
    BuildContext context,
    String title,
    String label,
  ) async {
    final c = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: c,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, c.text.trim()),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _pdf(DocumentData invoice, List<DocumentLineData> lines) async {
    try {
      final bytes = await QuotePdf.build(
        invoice,
        lines,
        title: 'INVOICE',
        numberLabel: 'Invoice',
        sectionTitle: 'INVOICE DETAILS',
        showValidity: false,
      );
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Invoice PDF')),
            body: PdfPreview(
              build: (_) async => bytes,
              canChangePageFormat: false,
              pdfFileName: '${invoice.documentNumber}.pdf',
            ),
          ),
        ),
      );
    } catch (e) {
      _message('$e');
    }
  }

  Future<void> _receipt(PaymentData p) async {
    try {
      final repo = ref.read(invoiceRepositoryProvider);
      final d = await repo.getInvoice(widget.invoiceId);
      final receipt =
          await (ref
                  .read(appDatabaseProvider)
                  .select(ref.read(appDatabaseProvider).documents)
                ..where((x) => x.id.equals(p.receiptDocumentId ?? -1)))
              .getSingle();
      final lines = await repo.getLines(receipt.id);
      final reversal = receipt.notes == 'PAYMENT REVERSAL';
      final bytes = await QuotePdf.build(
        receipt,
        lines,
        title: reversal ? 'PAYMENT REVERSAL' : 'PAYMENT RECEIPT',
        numberLabel: 'Receipt',
        sectionTitle: 'RECEIPT DETAILS',
        showValidity: false,
      );
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('${d?.documentNumber ?? ''} receipt')),
            body: PdfPreview(
              build: (_) async => bytes,
              canChangePageFormat: false,
              pdfFileName: '${receipt.documentNumber}.pdf',
            ),
          ),
        ),
      );
    } catch (e) {
      _message('$e');
    }
  }

  void _message(String value) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }
}

class ReceiptDetailScreen extends ConsumerWidget {
  const ReceiptDetailScreen({required this.receiptId, super.key});
  final int receiptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Receipt details')),
      body: FutureBuilder<(DocumentData, List<DocumentLineData>)>(
        future: () async {
          final receipt = await (db.select(
            db.documents,
          )..where((d) => d.id.equals(receiptId))).getSingleOrNull();
          if (receipt == null || receipt.documentType != 'receipt') {
            throw StateError('Receipt not found.');
          }
          final lines = await ref
              .read(invoiceRepositoryProvider)
              .getLines(receiptId);
          return (receipt, lines);
        }(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final (receipt, lines) = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                receipt.documentNumber ?? 'Receipt',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(receipt.customerNameSnapshot),
              Text(receipt.termsSnapshot),
              ...lines.map(
                (line) => ListTile(
                  title: Text(line.designation),
                  subtitle: Text(
                    MoneyFormatter.format(
                      line.unitPriceMinor ?? 0,
                      receipt.currencyCode,
                    ),
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: () async {
                  final title = receipt.notes == 'PAYMENT REVERSAL'
                      ? 'PAYMENT REVERSAL'
                      : 'PAYMENT RECEIPT';
                  final bytes = await QuotePdf.build(
                    receipt,
                    lines,
                    title: title,
                    numberLabel: 'Receipt',
                    sectionTitle: 'RECEIPT DETAILS',
                    showValidity: false,
                  );
                  if (!context.mounted) return;
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: const Text('Receipt PDF')),
                        body: PdfPreview(
                          build: (_) async => bytes,
                          canChangePageFormat: false,
                          pdfFileName: '${receipt.documentNumber}.pdf',
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Preview receipt PDF'),
              ),
            ],
          );
        },
      ),
    );
  }
}
