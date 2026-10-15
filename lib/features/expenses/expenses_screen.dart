import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/expense_repository.dart';
import '../../domain/money.dart';
import '../../domain/payment_methods.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  String _currencyFilter = 'all';
  int? _categoryFilter;

  @override
  Widget build(BuildContext context) {
    final expenseRepo = ref.watch(expenseRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses & Costs'),
        actions: [
          IconButton(
            tooltip: 'Manage Categories',
            icon: const Icon(Icons.category_outlined),
            onPressed: () => _showCategoriesDialog(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showExpenseDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add expense'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder<List<ExpenseCategoryData>>(
                    stream: expenseRepo.watchCategories(includeArchived: true),
                    builder: (context, snapshot) {
                      final categories = snapshot.data ?? [];
                      return DropdownButtonFormField<int?>(
                        initialValue: _categoryFilter,
                        decoration: const InputDecoration(labelText: 'Category'),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('All categories'),
                          ),
                          ...categories.map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ),
                          ),
                        ],
                        onChanged: (v) => setState(() => _categoryFilter = v),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _currencyFilter,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All currencies')),
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'ZiG', child: Text('ZiG')),
                    ],
                    onChanged: (v) => setState(() => _currencyFilter = v ?? 'all'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ExpenseData>>(
              stream: expenseRepo.watchExpenses(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var expenses = snapshot.data!;
                if (_currencyFilter != 'all') {
                  expenses = expenses.where((e) => e.currencyCode == _currencyFilter).toList();
                }
                if (_categoryFilter != null) {
                  expenses = expenses.where((e) => e.categoryId == _categoryFilter).toList();
                }
                if (expenses.isEmpty) {
                  return const Center(child: Text('No expenses recorded.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                  itemCount: expenses.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exp = expenses[index];
                    final isReversed = exp.status == 'Reversed';
                    return ListTile(
                      leading: Icon(
                        isReversed ? Icons.history_toggle_off : Icons.receipt_long,
                        color: isReversed ? Colors.grey : Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        '${MoneyFormatter.format(exp.amountMinor, exp.currencyCode)} · ${exp.description}',
                        style: TextStyle(
                          decoration: isReversed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Text(
                        'Date: ${_date(exp.date)} · Method: ${exp.paymentMethod}${exp.linkedInvoiceId != null ? ' · Linked to Invoice #${exp.linkedInvoiceId}' : ' · Overhead'}\nStatus: ${exp.status}',
                      ),
                      isThreeLine: true,
                      trailing: exp.status == 'Active'
                          ? IconButton(
                              tooltip: 'Correct expense',
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _showExpenseDialog(context, existing: exp),
                            )
                          : null,
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

  Future<void> _showExpenseDialog(BuildContext context, {ExpenseData? existing}) async {
    final expenseRepo = ref.read(expenseRepositoryProvider);
    final categories = await expenseRepo.getCategories();
    if (!mounted) return;
    if (categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        constSnackBar('Please create an expense category first.'),
      );
      return;
    }

    final amountController = TextEditingController(
      text: existing == null ? '' : '${existing.amountMinor ~/ 100}.${(existing.amountMinor % 100).toString().padLeft(2, '0')}',
    );
    final descController = TextEditingController(text: existing?.description ?? '');
    final supplierController = TextEditingController(text: existing?.supplier ?? '');
    int categoryId = existing?.categoryId ?? categories.first.id;
    String currencyCode = existing?.currencyCode ?? 'USD';
    String paymentMethod = existing?.paymentMethod ?? paymentMethodOptions.first;
    int? linkedInvoiceId = existing?.linkedInvoiceId;
    String? receiptPhotoPath = existing?.receiptPhotoPath;

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialog) => AlertDialog(
          title: Text(existing == null ? 'Record Expense' : 'Correct Expense'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  initialValue: categoryId,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                      .toList(),
                  onChanged: (v) => setDialog(() => categoryId = v ?? categoryId),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: 'Amount'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: currencyCode,
                        decoration: const InputDecoration(labelText: 'Currency'),
                        items: const [
                          DropdownMenuItem(value: 'USD', child: Text('USD')),
                          DropdownMenuItem(value: 'ZiG', child: Text('ZiG')),
                        ],
                        onChanged: (v) => setDialog(() => currencyCode = v ?? 'USD'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description / Purpose'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: supplierController,
                  decoration: const InputDecoration(labelText: 'Supplier (optional)'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: paymentMethod,
                  decoration: const InputDecoration(labelText: 'Payment Method'),
                  items: paymentMethodOptions
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setDialog(() => paymentMethod = v ?? paymentMethod),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1600,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      setDialog(() => receiptPhotoPath = image.path);
                    }
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: Text(receiptPhotoPath == null ? 'Attach Receipt Photo' : 'Photo Attached'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  final amountMinor = _parseMinor(amountController.text);
                  final draft = ExpenseDraft(
                    date: DateTime.now(),
                    amountMinor: amountMinor,
                    currencyCode: currencyCode,
                    categoryId: categoryId,
                    description: descController.text,
                    supplier: supplierController.text,
                    paymentMethod: paymentMethod,
                    linkedInvoiceId: linkedInvoiceId,
                    receiptPhotoPath: receiptPhotoPath,
                  );
                  if (existing == null) {
                    await expenseRepo.addExpense(draft);
                  } else {
                    await expenseRepo.correctExpense(existing.id, draft);
                  }
                  if (context.mounted) Navigator.pop(context);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$e')),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    amountController.dispose();
    descController.dispose();
    supplierController.dispose();
  }

  Future<void> _showCategoriesDialog(BuildContext context) async {
    final expenseRepo = ref.read(expenseRepositoryProvider);
    final nameController = TextEditingController();
    bool isOverhead = true;

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialog) => AlertDialog(
          title: const Text('Expense Categories'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<List<ExpenseCategoryData>>(
                  stream: expenseRepo.watchCategories(includeArchived: true),
                  builder: (context, snapshot) {
                    final categories = snapshot.data ?? [];
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          return CheckboxListTile(
                            title: Text(cat.name),
                            subtitle: Text(cat.isOverhead ? 'Overhead' : 'Job Cost'),
                            value: !cat.isArchived,
                            onChanged: (active) async {
                              await expenseRepo.archiveCategory(cat.id, archived: !(active ?? true));
                              setDialog(() {});
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'New category name'),
                ),
                SwitchListTile(
                  title: const Text('Is Overhead Category'),
                  value: isOverhead,
                  onChanged: (v) => setDialog(() => isOverhead = v),
                ),
                FilledButton(
                  onPressed: () async {
                    if (nameController.text.trim().isNotEmpty) {
                      await expenseRepo.saveCategory(
                        name: nameController.text.trim(),
                        isOverhead: isOverhead,
                      );
                      nameController.clear();
                      setDialog(() {});
                    }
                  },
                  child: const Text('Add Category'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
    nameController.dispose();
  }

  static String _date(DateTime d) => '${d.day}/${d.month}/${d.year}';

  static int _parseMinor(String input) {
    final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(input.trim());
    if (match == null) {
      throw const FormatException('Enter a valid amount with up to two decimals.');
    }
    return int.parse(match.group(1)!) * 100 +
        int.parse((match.group(2) ?? '').padRight(2, '0'));
  }

  static SnackBar constSnackBar(String message) => SnackBar(content: Text(message));
}
