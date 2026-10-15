import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/records_repository.dart';
import '../../domain/money.dart';
import '../invoices/invoices_screen.dart';
import '../quotes/quotes_screen.dart';

class CustomerHistoryScreen extends ConsumerStatefulWidget {
  const CustomerHistoryScreen({required this.customerId, super.key});
  final int customerId;
  @override
  ConsumerState<CustomerHistoryScreen> createState() =>
      _CustomerHistoryScreenState();
}

class _CustomerHistoryScreenState extends ConsumerState<CustomerHistoryScreen> {
  late Future<CustomerHistoryData> _history;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => _history = ref
      .read(recordsRepositoryProvider)
      .getCustomerHistory(widget.customerId);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Customer history'),
      actions: [
        IconButton(
          tooltip: 'Refresh',
          onPressed: () => setState(_load),
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: FutureBuilder<CustomerHistoryData>(
      future: _history,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Customer history could not be loaded: ${snapshot.error}',
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final history = snapshot.data!;
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
                      history.customer.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (history.customer.location.isNotEmpty)
                      Text(history.customer.location),
                    if (history.customer.phone.isNotEmpty)
                      Text(history.customer.phone),
                    const Divider(),
                    Text(
                      'OUTSTANDING BALANCE',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    if (history.outstandingByCurrency.isEmpty)
                      const Text('No outstanding invoices'),
                    for (final entry in history.outstandingByCurrency.entries)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(entry.key),
                        trailing: Text(
                          MoneyFormatter.format(entry.value, entry.key),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            _section(
              context,
              'Quotations',
              history.quotations.length,
              history.quotations.map((d) => _documentTile(d, context)).toList(),
            ),
            _section(
              context,
              'Invoices',
              history.invoices.length,
              history.invoices.map((d) => _documentTile(d, context)).toList(),
            ),
            _section(context, 'Payments', history.payments.length, [
              for (final entry in history.payments)
                ListTile(
                  leading: Icon(
                    entry.payment.entryType == 'reversal'
                        ? Icons.undo
                        : Icons.payments_outlined,
                  ),
                  title: Text(
                    '${entry.payment.entryType == 'reversal' ? 'Reversal' : 'Payment'} · ${MoneyFormatter.format(entry.payment.amountMinor, entry.payment.currencyCode)}',
                  ),
                  subtitle: Text(
                    '${entry.invoiceNumber ?? 'Invoice'} · ${entry.payment.method} · ${_date(entry.payment.paidAt)}${entry.receiptNumber == null ? '' : ' · ${entry.receiptNumber}'}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: entry.payment.receiptDocumentId == null
                      ? null
                      : () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ReceiptDetailScreen(
                              receiptId: entry.payment.receiptDocumentId!,
                            ),
                          ),
                        ),
                ),
            ]),
          ],
        );
      },
    ),
  );

  Widget _documentTile(DocumentData doc, BuildContext context) => ListTile(
    leading: Icon(
      doc.documentType == 'invoice'
          ? Icons.receipt_long_outlined
          : Icons.request_quote_outlined,
    ),
    title: Text(doc.documentNumber ?? 'Draft quotation'),
    subtitle: Text(
      '${doc.status.replaceAll('_', ' ').toUpperCase()} · ${doc.currencyCode} · ${_date(doc.issuedAt ?? doc.createdAt)}',
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => doc.documentType == 'invoice'
            ? InvoiceDetailScreen(invoiceId: doc.id)
            : QuoteEditorScreen(quoteId: doc.id),
      ),
    ),
  );

  Widget _section(
    BuildContext context,
    String title,
    int count,
    List<Widget> children,
  ) => Card(
    margin: const EdgeInsets.only(top: 12),
    child: ExpansionTile(
      title: Text(title),
      subtitle: Text('$count records'),
      initiallyExpanded: true,
      children: children.isEmpty
          ? [const ListTile(title: Text('No records yet'))]
          : children,
    ),
  );

  static String _date(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
