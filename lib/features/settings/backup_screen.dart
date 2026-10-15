import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/backup_service.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _busy = false;
  String? _message;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup and restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Export one backup file containing your company settings, logo, customers, quotations, invoices, receipts and payment history.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Backup password (optional)',
              helperText: 'Use at least 8 characters. Keep it safe; it cannot be recovered.',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirmPassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm backup password',
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _exportBackup,
            icon: const Icon(Icons.file_download_outlined),
            label: const Text('Create and save backup file'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _busy ? null : _restoreBackup,
            icon: const Icon(Icons.settings_backup_restore_outlined),
            label: const Text('Restore from backup file'),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Automatic local backups',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kairo Quotes keeps the 5 newest automatic safety backups on this phone. They are stored in app-private storage and are removed if the app is uninstalled.',
                  ),
                ],
              ),
            ),
          ),
          if (_busy) ...[
            const SizedBox(height: 20),
            const Center(child: CircularProgressIndicator()),
          ],
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }

  Future<void> _exportBackup() async {
    final password = _password.text;
    if (password.isNotEmpty && password != _confirmPassword.text) {
      _showMessage('The backup passwords do not match.');
      return;
    }
    setState(() => _busy = true);
    try {
      final bytes = await ref
          .read(backupServiceProvider)
          .createBackup(password: password.isEmpty ? null : password);
      final path = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Kairo Quotes backup',
        fileName: 'kairo_quotes_backup.kqbk',
        type: FileType.custom,
        allowedExtensions: const ['kqbk'],
        bytes: Uint8List.fromList(bytes),
      );
      if (path != null) _showMessage('Backup file saved successfully.');
    } catch (error) {
      _showMessage('Could not create the backup: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restoreBackup() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['kqbk'],
      withData: true,
    );
    if (picked == null || picked.files.isEmpty || !mounted) return;
    final Uint8List? bytes = picked.files.first.bytes;
    if (bytes == null) {
      _showMessage('The selected backup file could not be read.');
      return;
    }

    final service = ref.read(backupServiceProvider);
    ValidatedBackup validated;
    try {
      validated = await service.validateBackup(bytes);
    } on BackupPasswordRequiredException {
      final password = await _askForRestorePassword();
      if (password == null || !mounted) return;
      try {
        validated = await service.validateBackup(bytes, password: password);
      } catch (error) {
        _showMessage('Could not validate backup: $error');
        return;
      }
    } catch (error) {
      _showMessage('Could not validate backup: $error');
      return;
    }

    final confirmed = await _confirmRestore(validated.manifest);
    if (!confirmed || !mounted) {
      await validated.dispose();
      return;
    }
    setState(() => _busy = true);
    try {
      await service.restoreBackup(validated);
      ref.invalidate(appDatabaseProvider);
      ref.invalidate(companyProfileProvider);
      ref.invalidate(defaultTermsProvider);
      if (mounted) {
        setState(
          () => _message =
              'Restore completed. Your saved records have been replaced.',
        );
      }
    } catch (error) {
      _showMessage(
        'Restore failed. Your previous database was retained where possible: $error',
      );
    } finally {
      if (mounted) setState(() => _busy = false);
      await validated.dispose();
    }
  }

  Future<String?> _askForRestorePassword() async {
    final controller = TextEditingController();
    try {
      return await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Backup password'),
          content: TextField(
            controller: controller,
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Password used for this backup',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<bool> _confirmRestore(BackupManifest manifest) async {
    final controller = TextEditingController();
    try {
      return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Replace all saved data?'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Backup created ${manifest.createdAt.toLocal()}. App version ${manifest.appVersion}.',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    manifest.recordCounts.entries
                        .map((entry) => '${entry.key}: ${entry.value}')
                        .join('\n'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'WARNING: Restoring replaces every current customer, quotation, invoice, receipt, payment, company setting and other saved record with the contents of this backup. This cannot be undone from the app. A safety backup of the current data will be saved on this phone first.',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    onChanged: (_) => setDialogState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Type REPLACE to continue',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: controller.text == 'REPLACE'
                    ? () => Navigator.pop(context, true)
                    : null,
                child: const Text('Replace data'),
              ),
            ],
          ),
        ),
      ).then((value) => value ?? false);
    } finally {
      controller.dispose();
    }
  }

  void _showMessage(String message) {
    if (mounted) setState(() => _message = message);
  }
}
