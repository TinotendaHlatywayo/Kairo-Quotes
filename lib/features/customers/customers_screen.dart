import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/customer_repository.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  String _search = '';
  bool _showArchived = false;

  Future<void> _editCustomer([CustomerData? customer]) async {
    final repository = ref.read(customerRepositoryProvider);
    await showDialog<void>(
      context: context,
      builder: (context) => CustomerFormDialog(
        customer: customer,
        onSave: (draft) => repository.save(draft, id: customer?.id),
      ),
    );
  }

  Future<void> _setArchived(CustomerData customer, bool archived) async {
    try {
      await ref
          .read(customerRepositoryProvider)
          .setArchived(customer.id, archived: archived);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update customer: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(customerRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            tooltip: _showArchived ? 'Hide archived' : 'Show archived',
            onPressed: () => setState(() => _showArchived = !_showArchived),
            icon: Icon(
              _showArchived ? Icons.inventory_2 : Icons.inventory_2_outlined,
            ),
          ),
          IconButton(
            tooltip: 'Add customer',
            onPressed: () => _editCustomer(),
            icon: const Icon(Icons.person_add_alt_1),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search customers',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<CustomerData>>(
              stream: repository.watchCustomers(
                search: _search,
                includeArchived: _showArchived,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _MessageState(
                    icon: Icons.error_outline,
                    message: 'Customers could not be loaded.',
                    details: '${snapshot.error}',
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final customers = snapshot.data!;
                if (customers.isEmpty) {
                  return _MessageState(
                    icon: _search.isEmpty
                        ? Icons.people_outline
                        : Icons.search_off,
                    message: _search.isEmpty
                        ? 'No customers yet'
                        : 'No matching customers',
                    details: _search.isEmpty
                        ? 'Add a customer to keep their contact details ready for a quotation.'
                        : 'Try a name, location, phone number or note.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: customers.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final details = [
                      if (customer.location.isNotEmpty) customer.location,
                      if (customer.phone.isNotEmpty) customer.phone,
                    ].join(' · ');
                    return Card(
                      child: ListTile(
                        minVerticalPadding: 12,
                        leading: CircleAvatar(
                          child: Text(
                            customer.name.characters.first.toUpperCase(),
                          ),
                        ),
                        title: Text(customer.name),
                        subtitle: Text(
                          [
                            if (details.isNotEmpty) details,
                            if (customer.notes.isNotEmpty) customer.notes,
                            if (customer.isArchived) 'Archived',
                          ].join('\n'),
                        ),
                        isThreeLine: customer.notes.isNotEmpty,
                        trailing: PopupMenuButton<String>(
                          tooltip: 'Customer actions',
                          onSelected: (action) {
                            if (action == 'edit') {
                              _editCustomer(customer);
                            }
                            if (action == 'archive') {
                              _setArchived(customer, true);
                            }
                            if (action == 'restore') {
                              _setArchived(customer, false);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            PopupMenuItem(
                              value: customer.isArchived
                                  ? 'restore'
                                  : 'archive',
                              child: Text(
                                customer.isArchived ? 'Restore' : 'Archive',
                              ),
                            ),
                          ],
                        ),
                        onTap: () => _editCustomer(customer),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _editCustomer(),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add customer'),
      ),
    );
  }
}

class CustomerFormDialog extends StatefulWidget {
  const CustomerFormDialog({required this.onSave, this.customer, super.key});

  final CustomerData? customer;
  final Future<int> Function(CustomerDraft draft) onSave;

  @override
  State<CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends State<CustomerFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.customer?.name ?? '');
  late final _location = TextEditingController(
    text: widget.customer?.location ?? '',
  );
  late final _phone = TextEditingController(text: widget.customer?.phone ?? '');
  late final _notes = TextEditingController(text: widget.customer?.notes ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    _phone.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(
        CustomerDraft(
          name: _name.text,
          location: _location.text,
          phone: _phone.text,
          notes: _notes.text,
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) setState(() => _error = '$error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer == null ? 'Add customer' : 'Edit customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _name,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a customer name.'
                    : null,
              ),
              TextFormField(
                controller: _location,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _notes,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.message,
    required this.details,
  });

  final IconData icon;
  final String message;
  final String details;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(details, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
