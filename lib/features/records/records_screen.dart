import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/records_repository.dart';
import '../invoices/invoices_screen.dart';
import '../quotes/quotes_screen.dart';

class RecordsScreen extends ConsumerStatefulWidget {
  const RecordsScreen({this.initialCustomerId, super.key});
  final int? initialCustomerId;
  @override
  ConsumerState<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends ConsumerState<RecordsScreen> {
  late final Future<List<CustomerData>> _customers;
  late int? _customerId = widget.initialCustomerId;
  String _search = '';
  String _type = 'all';
  String _status = 'all';
  DateTime? _from;
  DateTime? _through;

  @override
  void initState() {
    super.initState();
    _customers = ref
        .read(customerRepositoryProvider)
        .watchCustomers(includeArchived: true)
        .first;
  }

  Future<void> _pickDates() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _from == null || _through == null
          ? null
          : DateTimeRange(start: _from!, end: _through!),
    );
    if (range != null) {
      setState(() {
        _from = range.start;
        _through = range.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = DocumentFilters(
      search: _search,
      customerId: _customerId,
      documentType: _type,
      status: _status,
      from: _from,
      through: _through,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search number or customer',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          FutureBuilder<List<CustomerData>>(
            future: _customers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox(height: 8);
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: DropdownButtonFormField<int?>(
                  initialValue: _customerId,
                  decoration: const InputDecoration(labelText: 'Customer'),
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('All customers'),
                    ),
                    ...snapshot.data!.map(
                      (c) => DropdownMenuItem<int?>(
                        value: c.id,
                        child: Text(c.name),
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(() => _customerId = value),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All types')),
                      DropdownMenuItem(
                        value: 'quotation',
                        child: Text('Quotes'),
                      ),
                      DropdownMenuItem(
                        value: 'invoice',
                        child: Text('Invoices'),
                      ),
                      DropdownMenuItem(
                        value: 'receipt',
                        child: Text('Receipts'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _type = value ?? 'all'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(
                        value: 'all',
                        child: Text('All statuses'),
                      ),
                      DropdownMenuItem(value: 'draft', child: Text('Draft')),
                      DropdownMenuItem(value: 'sent', child: Text('Sent')),
                      DropdownMenuItem(
                        value: 'accepted',
                        child: Text('Accepted'),
                      ),
                      DropdownMenuItem(
                        value: 'rejected',
                        child: Text('Rejected'),
                      ),
                      DropdownMenuItem(
                        value: 'expired',
                        child: Text('Expired'),
                      ),
                      DropdownMenuItem(value: 'issued', child: Text('Issued')),
                      DropdownMenuItem(
                        value: 'partially_paid',
                        child: Text('Partially paid'),
                      ),
                      DropdownMenuItem(value: 'paid', child: Text('Paid')),
                      DropdownMenuItem(value: 'void', child: Text('Void')),
                    ],
                    onChanged: (value) =>
                        setState(() => _status = value ?? 'all'),
                  ),
                ),
                IconButton(
                  tooltip: 'Date range',
                  onPressed: _pickDates,
                  icon: const Icon(Icons.date_range),
                ),
              ],
            ),
          ),
          if (_from != null || _through != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${_date(_from)} – ${_date(_through)}'),
                IconButton(
                  tooltip: 'Clear date range',
                  onPressed: () => setState(() {
                    _from = null;
                    _through = null;
                  }),
                  icon: const Icon(Icons.filter_alt_off),
                ),
              ],
            ),
          Expanded(
            child: StreamBuilder<List<DocumentData>>(
              stream: ref
                  .watch(recordsRepositoryProvider)
                  .watchDocuments(filters),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Documents could not be loaded: ${snapshot.error}',
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No documents match these filters.'),
                  );
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final document = snapshot.data![index];
                    final typeLabel = switch (document.documentType) {
                      'quotation' => 'QUOTE',
                      'invoice' => 'INVOICE',
                      _ => 'RECEIPT',
                    };
                    return ListTile(
                      leading: Icon(switch (document.documentType) {
                        'quotation' => Icons.request_quote_outlined,
                        'invoice' => Icons.receipt_long_outlined,
                        _ => Icons.payments_outlined,
                      }),
                      title: Text(document.documentNumber ?? 'Draft quotation'),
                      subtitle: Text(
                        '${document.customerNameSnapshot}\n$typeLabel · ${document.status.replaceAll('_', ' ').toUpperCase()} · ${document.currencyCode} · ${_date(document.issuedAt ?? document.createdAt)}',
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openDocument(document),
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

  void _openDocument(DocumentData document) {
    final Widget screen = switch (document.documentType) {
      'quotation' => QuoteEditorScreen(quoteId: document.id),
      'invoice' => InvoiceDetailScreen(invoiceId: document.id),
      _ => ReceiptDetailScreen(receiptId: document.id),
    };
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  static String _date(DateTime? value) =>
      value == null ? 'Any date' : '${value.day}/${value.month}/${value.year}';
}
