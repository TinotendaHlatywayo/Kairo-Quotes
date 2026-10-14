import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/app_database.dart';
import '../../data/catalog_repository.dart';
import '../../domain/money.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  bool _showArchived = false;

  Future<void> _addSection() async {
    final designation = await showDialog<String>(
      context: context,
      builder: (context) =>
          const _TextEntryDialog(title: 'Add section', label: 'Section name'),
    );
    if (designation == null || !mounted) return;
    await _run(() async {
      await ref.read(catalogRepositoryProvider).addSection(designation);
    });
  }

  Future<void> _editSection(CatalogItemData section) async {
    final designation = await showDialog<String>(
      context: context,
      builder: (context) => _TextEntryDialog(
        title: 'Edit section',
        label: 'Section name',
        initialValue: section.designation,
      ),
    );
    if (designation == null || !mounted) return;
    await _run(() async {
      await ref
          .read(catalogRepositoryProvider)
          .saveSection(designation, id: section.id);
    });
  }

  Future<void> _editItem(
    List<CatalogItemData> rows, [
    CatalogItemData? item,
  ]) async {
    final sections = rows.where((row) => row.isSection).toList(growable: false);
    await showDialog<void>(
      context: context,
      builder: (context) => CatalogItemFormDialog(
        item: item,
        sections: sections,
        onSave: (draft) =>
            ref.read(catalogRepositoryProvider).saveItem(draft, id: item?.id),
      ),
    );
  }

  Future<void> _setArchived(CatalogItemData item, bool archived) async {
    await _run(
      () => ref
          .read(catalogRepositoryProvider)
          .setArchived(item.id, archived: archived),
    );
  }

  Future<void> _move(
    List<CatalogItemData> rows,
    CatalogItemData item,
    int direction,
  ) async {
    final siblings = rows
        .where(
          (row) =>
              row.isSection == item.isSection &&
              row.sectionId == item.sectionId,
        )
        .toList();
    siblings.sort((a, b) {
      final byOrder = a.sortOrder.compareTo(b.sortOrder);
      return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
    });
    final index = siblings.indexWhere((row) => row.id == item.id);
    if (index < 0) return;
    await _run(
      () => ref
          .read(catalogRepositoryProvider)
          .reorder(item.id, newIndex: index + direction),
    );
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update catalog: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(catalogRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            tooltip: _showArchived ? 'Hide archived' : 'Show archived',
            onPressed: () => setState(() => _showArchived = !_showArchived),
            icon: Icon(
              _showArchived ? Icons.inventory_2 : Icons.inventory_2_outlined,
            ),
          ),
          PopupMenuButton<String>(
            tooltip: 'Add catalog entry',
            icon: const Icon(Icons.add),
            onSelected: (value) {
              if (value == 'section') _addSection();
              if (value == 'item') {
                repository
                    .watchItems(includeArchived: _showArchived)
                    .first
                    .then((rows) {
                      if (mounted) _editItem(rows);
                    });
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'section', child: Text('Add section')),
              PopupMenuItem(value: 'item', child: Text('Add item')),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<CatalogItemData>>(
        stream: repository.watchItems(includeArchived: _showArchived),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _CatalogMessage(
              icon: Icons.error_outline,
              title: 'Catalog could not be loaded',
              detail: '${snapshot.error}',
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final rows = snapshot.data!;
          if (rows.isEmpty) {
            return _CatalogMessage(
              icon: Icons.inventory_2_outlined,
              title: 'No catalog items yet',
              detail:
                  'Add sections and services to make them easy to reuse later.',
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: _buildCatalogRows(rows),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => repository
            .watchItems(includeArchived: _showArchived)
            .first
            .then((rows) {
              if (mounted) _editItem(rows);
            }),
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
      ),
    );
  }

  List<Widget> _buildCatalogRows(List<CatalogItemData> rows) {
    final sections = rows.where((row) => row.isSection).toList();
    final children = <int?, List<CatalogItemData>>{};
    for (final row in rows.where((row) => !row.isSection)) {
      children.putIfAbsent(row.sectionId, () => []).add(row);
    }
    final output = <Widget>[];
    for (final section in sections) {
      output.add(_sectionCard(section, rows, children[section.id] ?? const []));
    }
    final ungrouped = children[null] ?? const <CatalogItemData>[];
    if (ungrouped.isNotEmpty) {
      if (sections.isNotEmpty) {
        output.add(
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 4),
            child: Text(
              'OTHER ITEMS',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
      output.addAll(ungrouped.map((item) => _itemCard(item, rows)));
    }
    return output;
  }

  Widget _sectionCard(
    CatalogItemData section,
    List<CatalogItemData> allRows,
    List<CatalogItemData> children,
  ) {
    final siblingIndex = allRows.where((row) => row.isSection).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final index = siblingIndex.indexWhere((row) => row.id == section.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.primaryContainer,
            title: Text(
              section.designation,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '${children.length} ${children.length == 1 ? 'item' : 'items'}${section.isArchived ? ' · Archived' : ''}',
            ),
            leading: const Icon(Icons.folder_outlined),
            trailing: _entryActions(
              isArchived: section.isArchived,
              onEdit: () => _editSection(section),
              onArchive: () => _setArchived(section, !section.isArchived),
              onMoveUp: index == 0 ? null : () => _move(allRows, section, -1),
              onMoveDown: index == siblingIndex.length - 1
                  ? null
                  : () => _move(allRows, section, 1),
            ),
          ),
          for (final child in children)
            _itemCard(child, allRows, indented: true),
          if (children.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(72, 12, 16, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('No items in this section yet.'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _itemCard(
    CatalogItemData item,
    List<CatalogItemData> allRows, {
    bool indented = false,
  }) {
    final siblings =
        allRows
            .where((row) => !row.isSection && row.sectionId == item.sectionId)
            .toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final index = siblings.indexWhere((row) => row.id == item.id);
    final price = item.defaultUnitPriceMinor == null
        ? 'Price not set'
        : MoneyFormatter.format(
            item.defaultUnitPriceMinor!,
            item.defaultPriceCurrencyCode,
          );
    return ListTile(
      contentPadding: EdgeInsets.only(left: indented ? 68 : 16, right: 8),
      leading: Icon(
        item.isArchived ? Icons.inventory_2_outlined : Icons.build_outlined,
      ),
      title: Text(item.designation),
      subtitle: Text(
        [
          if (item.unit.isNotEmpty) 'Unit: ${item.unit}',
          price,
          if (item.isArchived) 'Archived',
        ].join(' · '),
      ),
      trailing: _entryActions(
        isArchived: item.isArchived,
        onEdit: () => _editItem(allRows, item),
        onArchive: () => _setArchived(item, !item.isArchived),
        onMoveUp: index == 0 ? null : () => _move(allRows, item, -1),
        onMoveDown: index == siblings.length - 1
            ? null
            : () => _move(allRows, item, 1),
      ),
      onTap: () => _editItem(allRows, item),
    );
  }

  Widget _entryActions({
    required bool isArchived,
    required VoidCallback onEdit,
    required VoidCallback onArchive,
    required VoidCallback? onMoveUp,
    required VoidCallback? onMoveDown,
  }) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        tooltip: 'Move up',
        visualDensity: VisualDensity.compact,
        onPressed: onMoveUp,
        icon: const Icon(Icons.arrow_upward),
      ),
      IconButton(
        tooltip: 'Move down',
        visualDensity: VisualDensity.compact,
        onPressed: onMoveDown,
        icon: const Icon(Icons.arrow_downward),
      ),
      PopupMenuButton<String>(
        tooltip: 'Catalog actions',
        onSelected: (value) {
          if (value == 'edit') onEdit();
          if (value == 'archive') onArchive();
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(
            value: 'archive',
            child: Text(isArchived ? 'Restore' : 'Archive'),
          ),
        ],
      ),
    ],
  );
}

class CatalogItemFormDialog extends StatefulWidget {
  const CatalogItemFormDialog({
    required this.sections,
    required this.onSave,
    this.item,
    super.key,
  });

  final List<CatalogItemData> sections;
  final CatalogItemData? item;
  final Future<int> Function(CatalogDraft draft) onSave;

  @override
  State<CatalogItemFormDialog> createState() => _CatalogItemFormDialogState();
}

class _CatalogItemFormDialogState extends State<CatalogItemFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _designation = TextEditingController(
    text: widget.item?.designation ?? '',
  );
  late final _unit = TextEditingController(text: widget.item?.unit ?? '');
  late final _price = TextEditingController(
    text: widget.item?.defaultUnitPriceMinor == null
        ? ''
        : _formatMinor(widget.item!.defaultUnitPriceMinor!),
  );
  late int? _sectionId = widget.item?.sectionId;
  late String _currency = widget.item?.defaultPriceCurrencyCode ?? 'USD';
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _designation.dispose();
    _unit.dispose();
    _price.dispose();
    super.dispose();
  }

  String _formatMinor(int minor) =>
      '${minor ~/ 100}.${(minor % 100).toString().padLeft(2, '0')}';

  int? _parseMinor(String value) {
    final input = value.trim().replaceAll(',', '.');
    if (input.isEmpty) return null;
    final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(input);
    if (match == null) {
      throw const FormatException(
        'Enter a non-negative amount with up to two decimals.',
      );
    }
    final whole = int.parse(match.group(1)!);
    final cents = int.parse((match.group(2) ?? '').padRight(2, '0'));
    return whole * 100 + cents;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(
        CatalogDraft(
          designation: _designation.text,
          unit: _unit.text,
          defaultUnitPriceMinor: _parseMinor(_price.text),
          defaultPriceCurrencyCode: _currency,
          sectionId: _sectionId,
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
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.item == null ? 'Add catalog item' : 'Edit catalog item'),
    content: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _designation,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Item or service'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a description.'
                  : null,
            ),
            TextFormField(
              controller: _unit,
              decoration: const InputDecoration(
                labelText: 'Unit (optional)',
                hintText: 'e.g. metre, item, service',
              ),
            ),
            DropdownButtonFormField<int?>(
              initialValue:
                  widget.sections.any((section) => section.id == _sectionId)
                  ? _sectionId
                  : null,
              decoration: const InputDecoration(labelText: 'Section'),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('No section'),
                ),
                for (final section in widget.sections)
                  DropdownMenuItem<int?>(
                    value: section.id,
                    child: Text(section.designation),
                  ),
              ],
              onChanged: _saving
                  ? null
                  : (value) => setState(() => _sectionId = value),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _price,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Default price',
                      hintText: 'Leave blank if variable',
                    ),
                    validator: (value) {
                      try {
                        _parseMinor(value ?? '');
                        return null;
                      } on FormatException catch (error) {
                        return error.message;
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _currency,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'ZiG', child: Text('ZiG')),
                    ],
                    onChanged: _saving
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _currency = value);
                            }
                          },
                  ),
                ),
              ],
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
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

class _TextEntryDialog extends StatefulWidget {
  const _TextEntryDialog({
    required this.title,
    required this.label,
    this.initialValue,
  });

  final String title;
  final String label;
  final String? initialValue;

  @override
  State<_TextEntryDialog> createState() => _TextEntryDialogState();
}

class _TextEntryDialogState extends State<_TextEntryDialog> {
  late final _controller = TextEditingController(
    text: widget.initialValue ?? '',
  );
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _controller,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(labelText: widget.label, errorText: _error),
      onSubmitted: (_) => _submit(),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Save')),
    ],
  );

  void _submit() {
    if (_controller.text.trim().isEmpty) {
      setState(() => _error = 'Enter a name.');
      return;
    }
    Navigator.of(context).pop(_controller.text.trim());
  }
}

class _CatalogMessage extends StatelessWidget {
  const _CatalogMessage({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(detail, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
