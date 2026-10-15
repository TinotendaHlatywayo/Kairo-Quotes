import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import 'app_database.dart';

const _backupMagic = 'KAIRO_QUOTES_BACKUP';
const _backupFormatVersion = 2;
const _appVersion = '1.0.0+1';
const _pbkdf2Iterations = 310000;
const _maxAutomaticBackups = 5;
const _backupInterval = Duration(days: 7);

class BackupManifest {
  const BackupManifest({
    required this.appVersion,
    required this.schemaVersion,
    required this.createdAt,
    required this.recordCounts,
    required this.checksum,
    required this.encrypted,
    required this.receiptPhotoCount,
    required this.receiptPhotoChecksums,
  });

  final String appVersion;
  final int schemaVersion;
  final DateTime createdAt;
  final Map<String, int> recordCounts;
  final String checksum;
  final bool encrypted;
  final int receiptPhotoCount;
  final Map<int, String> receiptPhotoChecksums;

  factory BackupManifest.fromJson(Map<String, dynamic> json) {
    final counts = json['recordCounts'];
    final photoChecksums = json['receiptPhotoChecksums'];
    final photoCount = json['receiptPhotoCount'] ?? 0;
    if (json['appVersion'] is! String ||
        json['schemaVersion'] is! int ||
        json['createdAt'] is! String ||
        json['checksumSha256'] is! String ||
        json['encrypted'] is! bool ||
        counts is! Map<String, dynamic> ||
        photoCount is! int || photoCount < 0 ||
        (photoChecksums != null && photoChecksums is! Map<String, dynamic>)) {
      throw const FormatException('The backup manifest is incomplete.');
    }
    final recordCounts = <String, int>{};
    for (final entry in counts.entries) {
      if (entry.value is! int || (entry.value as int) < 0) {
        throw const FormatException('The backup record counts are invalid.');
      }
      recordCounts[entry.key] = entry.value as int;
    }
    final parsedChecksums = <int, String>{};
    if (photoChecksums is Map<String, dynamic>) {
      for (final entry in photoChecksums.entries) {
        final id = int.tryParse(entry.key);
        if (id == null || id <= 0 || entry.value is! String ||
            (entry.value as String).length != 64) {
          throw const FormatException('The receipt photo checksums are invalid.');
        }
        parsedChecksums[id] = entry.value as String;
      }
    }
    if (parsedChecksums.length != photoCount) {
      throw const FormatException('The receipt photo count does not match its checksums.');
    }
    final createdAt = DateTime.tryParse(json['createdAt'] as String);
    if (createdAt == null || (json['checksumSha256'] as String).length != 64) {
      throw const FormatException('The backup manifest is invalid.');
    }
    return BackupManifest(
      appVersion: json['appVersion'] as String,
      schemaVersion: json['schemaVersion'] as int,
      createdAt: createdAt,
      recordCounts: recordCounts,
      checksum: json['checksumSha256'] as String,
      encrypted: json['encrypted'] as bool,
      receiptPhotoCount: photoCount,
      receiptPhotoChecksums: parsedChecksums,
    );
  }
}

class ValidatedBackup {
  const ValidatedBackup({
    required this.manifest,
    required this.databaseFile,
    required this.logoBytes,
    required this.logoName,
    this.receiptPhotos = const [],
  });

  final BackupManifest manifest;
  final File databaseFile;
  final Uint8List? logoBytes;
  final String? logoName;
  final List<BackupReceiptPhoto> receiptPhotos;

  Future<void> dispose() async {
    final directory = databaseFile.parent;
    if (await directory.exists()) await directory.delete(recursive: true);
  }
}

class BackupReceiptPhoto {
  const BackupReceiptPhoto({
    required this.expenseId,
    required this.fileName,
    required this.bytes,
  });

  final int expenseId;
  final String fileName;
  final Uint8List bytes;
}

class BackupService {
  BackupService(
    this.database, {
    this.backupDirectoryOverride,
    this.databaseFileOverride,
  });

  final AppDatabase database;
  final Directory? backupDirectoryOverride;
  final File? databaseFileOverride;

  static const _tableNames = <String>[
    'company_profile',
    'expense_categories',
    'expenses',
    'customers',
    'catalog_items',
    'documents',
    'document_lines',
    'payments',
    'terms_templates',
    'number_sequences',
    'audit_logs',
  ];

  Future<Directory> get backupDirectory async {
    if (backupDirectoryOverride case final directory?) return directory;
    final support = await getApplicationSupportDirectory();
    return Directory(p.join(support.path, 'kairo_quotes', 'backups'));
  }

  Future<File> get databaseFile async =>
      databaseFileOverride ?? await AppDatabase.defaultDatabaseFile();

  Future<Map<String, int>> _recordCounts() async {
    final counts = <String, int>{};
    for (final table in _tableNames) {
      final row = await database
          .customSelect('SELECT COUNT(*) AS amount FROM "$table"')
          .getSingle();
      counts[table] = row.read<int>('amount');
    }
    return counts;
  }

  Future<Uint8List> createBackup({String? password}) async {
    if (password != null && password.length < 8) {
      throw ArgumentError(
        'Backup passwords must contain at least 8 characters.',
      );
    }
    final counts = await _recordCounts();
    final logo = await _readLogo();
    final receiptPhotos = await _collectReceiptPhotos();
    final snapshot = await _createDatabaseSnapshot();
    try {
      final payload = <String, dynamic>{
        'databaseBase64': base64Encode(await snapshot.readAsBytes()),
        'logoBase64': logo?.$1 == null ? null : base64Encode(logo!.$1),
        'logoName': logo?.$2,
        'receiptPhotos': receiptPhotos
            .map((photo) => {
                  'expenseId': photo.expenseId,
                  'fileName': photo.fileName,
                  'bytesBase64': base64Encode(photo.bytes),
                })
            .toList(growable: false),
      };
      final payloadBytes = utf8.encode(jsonEncode(payload));
      final checksum = _hex((await Sha256().hash(payloadBytes)).bytes);
      final manifest = <String, dynamic>{
        'appVersion': _appVersion,
        'schemaVersion': database.schemaVersion,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'recordCounts': counts,
        'checksumSha256': checksum,
        'encrypted': password != null,
        'receiptPhotoCount': receiptPhotos.length,
        'receiptPhotoChecksums': {
          for (final photo in receiptPhotos)
            '${photo.expenseId}': _hex((await Sha256().hash(photo.bytes)).bytes),
        },
      };
      Map<String, dynamic> archive;
      if (password == null) {
        archive = {
          'magic': _backupMagic,
          'formatVersion': _backupFormatVersion,
          'manifest': manifest,
          'payload': payload,
        };
      } else {
        final salt = _randomBytes(16);
        final algorithm = AesGcm.with256bits();
        final nonce = _randomBytes(algorithm.nonceLength);
        final key = await _deriveKey(password, salt);
        final encrypted = await algorithm.encrypt(
          payloadBytes,
          secretKey: key,
          nonce: nonce,
        );
        archive = {
          'magic': _backupMagic,
          'formatVersion': _backupFormatVersion,
          'manifest': manifest,
          'encryption': {
            'algorithm': 'AES-256-GCM',
            'kdf': 'PBKDF2-HMAC-SHA256',
            'iterations': _pbkdf2Iterations,
            'salt': base64Encode(salt),
            'nonce': base64Encode(encrypted.nonce),
            'mac': base64Encode(encrypted.mac.bytes),
          },
          'ciphertext': base64Encode(encrypted.cipherText),
        };
      }
      return Uint8List.fromList(utf8.encode(jsonEncode(archive)));
    } finally {
      if (await snapshot.exists()) await snapshot.delete();
    }
  }

  Future<ValidatedBackup> validateBackup(
    List<int> bytes, {
    String? password,
  }) async {
    late final Map<String, dynamic> archive;
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('This is not a Kairo Quotes backup.');
      }
      archive = decoded;
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('The backup file is unreadable or corrupt.');
    }
    if (archive['magic'] != _backupMagic ||
        archive['formatVersion'] != _backupFormatVersion) {
      throw const FormatException('This backup format is not supported.');
    }
    final manifestJson = archive['manifest'];
    if (manifestJson is! Map<String, dynamic>) {
      throw const FormatException('The backup manifest is missing.');
    }
    final manifest = BackupManifest.fromJson(manifestJson);
    if (manifest.schemaVersion > database.schemaVersion) {
      throw FormatException(
        'This backup uses database schema ${manifest.schemaVersion}; '
        'this app supports schema ${database.schemaVersion}. Update Kairo Quotes first.',
      );
    }
    if (manifest.schemaVersion < 1) {
      throw const FormatException('The backup database version is invalid.');
    }
    late final List<int> payloadBytes;
    if (manifest.encrypted) {
      if (password == null || password.isEmpty) {
        throw const BackupPasswordRequiredException();
      }
      final encryption = archive['encryption'];
      if (encryption is! Map<String, dynamic> ||
          encryption['algorithm'] != 'AES-256-GCM' ||
          encryption['kdf'] != 'PBKDF2-HMAC-SHA256' ||
          encryption['iterations'] != _pbkdf2Iterations) {
        throw const FormatException(
          'The backup encryption settings are invalid.',
        );
      }
      try {
        final salt = base64Decode(encryption['salt'] as String);
        final nonce = base64Decode(encryption['nonce'] as String);
        final mac = base64Decode(encryption['mac'] as String);
        final ciphertext = base64Decode(archive['ciphertext'] as String);
        final algorithm = AesGcm.with256bits();
        final key = await _deriveKey(password, salt);
        payloadBytes = await algorithm.decrypt(
          SecretBox(ciphertext, nonce: nonce, mac: Mac(mac)),
          secretKey: key,
        );
      } on SecretBoxAuthenticationError {
        throw const FormatException(
          'The password is incorrect or the backup was changed.',
        );
      } catch (error) {
        if (error is FormatException) rethrow;
        throw const FormatException(
          'The password is incorrect or the backup is corrupt.',
        );
      }
    } else {
      final payload = archive['payload'];
      if (payload is! Map<String, dynamic>) {
        throw const FormatException('The backup data is missing.');
      }
      payloadBytes = utf8.encode(jsonEncode(payload));
    }
    if (_hex((await Sha256().hash(payloadBytes)).bytes) != manifest.checksum) {
      throw const FormatException(
        'The backup checksum does not match. The file may be corrupt.',
      );
    }

    late final Map<String, dynamic> payload;
    try {
      final decoded = jsonDecode(utf8.decode(payloadBytes));
      if (decoded is! Map<String, dynamic> ||
          decoded['databaseBase64'] is! String) {
        throw const FormatException('The backup database is missing.');
      }
      payload = decoded;
    } catch (_) {
      throw const FormatException('The backup contents are corrupt.');
    }
    final directory = await Directory.systemTemp.createTemp('kairo_restore_');
    final dbFile = File(p.join(directory.path, 'restore.sqlite'));
    try {
      final dbBytes = base64Decode(payload['databaseBase64'] as String);
      if (dbBytes.length < 100 ||
          utf8.decode(dbBytes.sublist(0, 16), allowMalformed: true) !=
              'SQLite format 3\u0000') {
        throw const FormatException(
          'The backup does not contain a valid SQLite database.',
        );
      }
      final databaseVersion = ByteData.sublistView(Uint8List.fromList(dbBytes))
          .getUint32(60, Endian.big);
      if (databaseVersion != manifest.schemaVersion) {
        throw const FormatException(
          'The manifest version does not match the database file.',
        );
      }
      await dbFile.writeAsBytes(dbBytes, flush: true);
      final native = sqlite.sqlite3.open(
        dbFile.path,
        mode: sqlite.OpenMode.readOnly,
      );
      try {
        final integrity = native
            .select('PRAGMA integrity_check')
            .first
            .values
            .first;
        if (integrity != 'ok') {
          throw const FormatException(
            'The backup database failed its integrity check.',
          );
        }
        if (manifest.schemaVersion == database.schemaVersion) {
          for (final entry in manifest.recordCounts.entries) {
            if (!_tableNames.contains(entry.key)) {
              throw const FormatException(
                'The backup lists an unknown data table.',
              );
            }
            final actual =
                native
                        .select('SELECT COUNT(*) FROM "${entry.key}"')
                        .first
                        .values
                        .first
                    as int;
            if (actual != entry.value) {
              throw const FormatException(
                'Backup record counts do not match its database.',
              );
            }
          }
        }
      } finally {
        native.close();
      }
      Uint8List? logoBytes;
      if (payload['logoBase64'] != null) {
        if (payload['logoBase64'] is! String) {
          throw const FormatException('The company logo data is invalid.');
        }
        logoBytes = Uint8List.fromList(
          base64Decode(payload['logoBase64'] as String),
        );
      }
      return ValidatedBackup(
        manifest: manifest,
        databaseFile: dbFile,
        logoBytes: logoBytes,
        logoName: payload['logoName'] is String
            ? payload['logoName'] as String
            : null,
      );
    } catch (_) {
      await directory.delete(recursive: true);
      rethrow;
    }
  }

  Future<void> restoreBackup(ValidatedBackup backup) async {
    final safety = await saveAutomaticBackup(force: true);
    final target = await databaseFile;
    await target.parent.create(recursive: true);
    final replacement = File('${target.path}.restore');
    final rollback = File('${target.path}.rollback');
    if (await replacement.exists()) await replacement.delete();
    await backup.databaseFile.copy(replacement.path);
    String? restoredLogoPath;
    if (backup.logoBytes != null) {
      final support = await getApplicationSupportDirectory();
      final extension = p.extension(backup.logoName ?? '').toLowerCase();
      final logo = File(
        p.join(
          support.path,
          'company_logo_restored${_safeExtension(extension)}',
        ),
      );
      await logo.parent.create(recursive: true);
      await logo.writeAsBytes(backup.logoBytes!, flush: true);
      restoredLogoPath = logo.path;
    }

    await database.close();
    try {
      for (final suffix in ['-wal', '-shm']) {
        final sidecar = File('${target.path}$suffix');
        if (await sidecar.exists()) await sidecar.delete();
      }
      if (await rollback.exists()) await rollback.delete();
      if (await target.exists()) await target.rename(rollback.path);
      await replacement.rename(target.path);
      if (restoredLogoPath != null) {
        final restoredDatabase = AppDatabase(databaseFile: target);
        try {
          final profile = await (restoredDatabase.select(
            restoredDatabase.companyProfiles,
          )..where((row) => row.id.equals(1))).getSingleOrNull();
          if (profile != null) {
            await (restoredDatabase.update(
              restoredDatabase.companyProfiles,
            )..where((row) => row.id.equals(profile.id))).write(
              CompanyProfilesCompanion(logoPath: Value(restoredLogoPath)),
            );
          }
        } finally {
          await restoredDatabase.close();
        }
      }
      if (await rollback.exists()) await rollback.delete();
      await backup.dispose();
      // Safety backup is intentionally retained alongside scheduled backups.
      if (!await safety.exists()) {
        throw FileSystemException('The safety backup could not be retained.');
      }
    } catch (_) {
      if (await target.exists()) await target.delete();
      if (await rollback.exists()) await rollback.rename(target.path);
      rethrow;
    }
  }

  Future<DateTime?> latestAutomaticBackup() async {
    final directory = await backupDirectory;
    if (!await directory.exists()) return null;
    final files = await directory
        .list()
        .where(
          (entity) =>
              entity is File && p.basename(entity.path).startsWith('auto_'),
        )
        .cast<File>()
        .toList();
    if (files.isEmpty) return null;
    files.sort((a, b) => b.path.compareTo(a.path));
    return files.first.lastModified();
  }

  Future<bool> backupReminderDue({DateTime? now}) async {
    final latest = await latestAutomaticBackup();
    return latest == null ||
        (now ?? DateTime.now()).difference(latest) >= _backupInterval;
  }

  Future<File> saveAutomaticBackup({bool force = false}) async {
    final directory = await backupDirectory;
    await directory.create(recursive: true);
    if (!force) {
      final latest = await latestAutomaticBackup();
      if (latest != null &&
          DateTime.now().difference(latest) < _backupInterval) {
        final files = await directory
            .list()
            .where(
              (entity) =>
                  entity is File && p.basename(entity.path).startsWith('auto_'),
            )
            .cast<File>()
            .toList();
        files.sort((a, b) => b.path.compareTo(a.path));
        return files.first;
      }
    }
    final timestamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      ':',
      '-',
    );
    final file = File(p.join(directory.path, 'auto_$timestamp.kqbk'));
    await file.writeAsBytes(await createBackup(), flush: true);
    final files = await directory
        .list()
        .where(
          (entity) =>
              entity is File && p.basename(entity.path).startsWith('auto_'),
        )
        .cast<File>()
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    for (final old in files.skip(_maxAutomaticBackups)) {
      await old.delete();
    }
    return file;
  }

  Future<File> _createDatabaseSnapshot() async {
    final directory = await backupDirectory;
    await directory.create(recursive: true);
    final temp = File(
      p.join(
        directory.path,
        '.snapshot_${DateTime.now().microsecondsSinceEpoch}_${Random.secure().nextInt(1 << 32)}.sqlite',
      ),
    );
    final quotedPath = temp.path.replaceAll("'", "''");
    await database.customStatement("VACUUM INTO '$quotedPath'");
    return temp;
  }

  Future<(Uint8List, String)?> _readLogo() async {
    final profile = await (database.select(
      database.companyProfiles,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    final logoPath = profile?.logoPath;
    if (logoPath == null) return null;
    final file = File(logoPath);
    if (!await file.exists()) return null;
    return (await file.readAsBytes(), p.basename(logoPath));
  }

  Future<List<_ReceiptPhotoInfo>> _collectReceiptPhotos() async {
    final expenses = await (database.select(database.expenses)
          ..where((row) => row.receiptPhotoPath.isNotNull()))
        .get();
    final photos = <_ReceiptPhotoInfo>[];
    for (final exp in expenses) {
      if (exp.receiptPhotoPath case final path?) {
        final file = File(path);
        if (await file.exists()) {
          photos.add(
            _ReceiptPhotoInfo(
              exp.id,
              p.basename(file.path),
              await file.readAsBytes(),
            ),
          );
        }
      }
    }
    return photos;
  }
}

class _ReceiptPhotoInfo {
  const _ReceiptPhotoInfo(this.expenseId, this.fileName, this.bytes);
  final int expenseId;
  final String fileName;
  final Uint8List bytes;
}

class BackupPasswordRequiredException implements Exception {
  const BackupPasswordRequiredException();
}

Future<SecretKey> _deriveKey(String password, List<int> salt) =>
    Pbkdf2.hmacSha256(
      iterations: _pbkdf2Iterations,
      bits: 256,
    ).deriveKey(secretKey: SecretKey(utf8.encode(password)), nonce: salt);

List<int> _randomBytes(int count) {
  final random = Random.secure();
  return List<int>.generate(count, (_) => random.nextInt(256));
}

String _hex(List<int> bytes) =>
    bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

String _safeExtension(String extension) =>
    RegExp(r'^\.[a-z0-9]{1,8}$').hasMatch(extension) ? extension : '.img';
