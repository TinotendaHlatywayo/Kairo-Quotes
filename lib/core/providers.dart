import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_database.dart';
import '../data/catalog_repository.dart';
import '../data/customer_repository.dart';
import '../data/settings_repository.dart';
import '../data/quote_repository.dart';
import '../data/invoice_repository.dart';
import '../data/records_repository.dart';
import '../data/analytics_repository.dart';
import '../data/backup_service.dart';
import '../domain/analytics_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(appDatabaseProvider));
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository(ref.watch(appDatabaseProvider));
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.watch(appDatabaseProvider));
});

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  return QuoteRepository(ref.watch(appDatabaseProvider));
});

final invoiceRepositoryProvider = Provider<InvoiceRepository>(
  (ref) => InvoiceRepository(ref.watch(appDatabaseProvider)),
);

final recordsRepositoryProvider = Provider<RecordsRepository>(
  (ref) => RecordsRepository(ref.watch(appDatabaseProvider)),
);

final analyticsServiceProvider = Provider<AnalyticsService>(
  (ref) => const AnalyticsService(),
);

final analyticsRepositoryProvider = Provider<AnalyticsRepository>(
  (ref) => AnalyticsRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(analyticsServiceProvider),
  ),
);

final companyProfileProvider = StreamProvider<CompanyProfileData?>((ref) {
  return ref.watch(settingsRepositoryProvider).watchCompanyProfile();
});

final defaultTermsProvider = FutureProvider<TermsTemplateData?>((ref) {
  return ref.watch(settingsRepositoryProvider).getDefaultTerms();
});
