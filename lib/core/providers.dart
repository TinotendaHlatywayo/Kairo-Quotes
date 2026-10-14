import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_database.dart';
import '../data/catalog_repository.dart';
import '../data/customer_repository.dart';
import '../data/settings_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
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

final companyProfileProvider = StreamProvider<CompanyProfileData?>((ref) {
  return ref.watch(settingsRepositoryProvider).watchCompanyProfile();
});

final defaultTermsProvider = FutureProvider<TermsTemplateData?>((ref) {
  return ref.watch(settingsRepositoryProvider).getDefaultTerms();
});
