import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/backup_service.dart';

void main() {
  late Directory temporaryDirectory;
  late File databaseFile;
  late Directory backupDirectory;
  late AppDatabase database;
  late BackupService service;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'kairo_backup_test_',
    );
    databaseFile = File('${temporaryDirectory.path}/kairo_quotes.sqlite');
    backupDirectory = Directory('${temporaryDirectory.path}/backups');
    database = AppDatabase(databaseFile: databaseFile);
    await database
        .into(database.companyProfiles)
        .insert(CompanyProfilesCompanion.insert(companyName: 'Test company'));
    service = BackupService(
      database,
      databaseFileOverride: databaseFile,
      backupDirectoryOverride: backupDirectory,
    );
  });

  tearDown(() async {
    await database.close();
    if (await temporaryDirectory.exists()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test(
    'creates and validates an unencrypted backup with record counts',
    () async {
      final bytes = await service.createBackup();
      final validated = await service.validateBackup(bytes);

      expect(validated.manifest.encrypted, isFalse);
      expect(validated.manifest.schemaVersion, database.schemaVersion);
      expect(validated.manifest.recordCounts['company_profile'], 1);
      expect(await validated.databaseFile.exists(), isTrue);
    },
  );

  test('encrypts backups and rejects a wrong password', () async {
    final bytes = await service.createBackup(password: 'correct horse battery');
    final validated = await service.validateBackup(
      bytes,
      password: 'correct horse battery',
    );
    expect(validated.manifest.encrypted, isTrue);

    await expectLater(
      service.validateBackup(bytes, password: 'incorrect password'),
      throwsA(isA<FormatException>()),
    );
  });

  test('rejects changed backup data before any restore', () async {
    final bytes = await service.createBackup();
    final archive = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    final payload = archive['payload'] as Map<String, dynamic>;
    payload['databaseBase64'] = '${payload['databaseBase64']}AA';

    await expectLater(
      service.validateBackup(utf8.encode(jsonEncode(archive))),
      throwsA(isA<FormatException>()),
    );
    expect(await databaseFile.exists(), isTrue);
  });

  test(
    'saves a safety backup and replaces the database only when requested',
    () async {
      final bytes = await service.createBackup();
      final validated = await service.validateBackup(bytes);
      await database
          .into(database.customers)
          .insert(CustomersCompanion.insert(name: 'Current only'));

      await service.restoreBackup(validated);
      final restored = AppDatabase(databaseFile: databaseFile);
      try {
        final company = await restored
            .select(restored.companyProfiles)
            .getSingle();
        final customers = await restored.select(restored.customers).get();
        expect(company.companyName, 'Test company');
        expect(customers, isEmpty);
        expect(backupDirectory.listSync().whereType<File>().length, 1);
      } finally {
        await restored.close();
      }
    },
  );
}
