import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers.dart';
import 'data/app_database.dart';
import 'features/catalog/catalog_screen.dart';
import 'features/customers/customers_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/quotes/quotes_screen.dart';

void main() {
  runApp(const ProviderScope(child: KairoQuotesApp()));
}

class KairoQuotesApp extends StatelessWidget {
  const KairoQuotesApp({super.key});

  static const navy = Color(0xFF102D52);
  static const blue = Color(0xFF3B82B8);

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: navy,
      brightness: Brightness.light,
      primary: navy,
      secondary: blue,
      surface: const Color(0xFFF8FAFC),
    );
    final baseTextTheme = ThemeData.light().textTheme;
    return MaterialApp(
      title: 'Kairo Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'EMBody',
        textTheme: baseTextTheme
            .apply(fontFamily: 'EMBody')
            .copyWith(
              headlineSmall: baseTextTheme.headlineSmall?.copyWith(
                fontFamily: 'EMDisplay',
                fontWeight: FontWeight.w700,
              ),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(48, 52)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const StartupGate(),
    );
  }
}

class StartupGate extends ConsumerWidget {
  const StartupGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(companyProfileProvider);
    return profile.when(
      data: (savedProfile) {
        if (savedProfile != null) return HomeScreen(profile: savedProfile);
        return ref
            .watch(defaultTermsProvider)
            .when(
              data: (terms) => SettingsScreen(profile: null, terms: terms),
              loading: _loadingScreen,
              error: (error, stack) => _errorScreen(ref, error),
            );
      },
      loading: _loadingScreen,
      error: (error, stack) => _errorScreen(ref, error),
    );
  }

  static Widget _loadingScreen() =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));

  static Widget _errorScreen(WidgetRef ref, Object error) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Kairo Quotes could not open its local database.'),
            const SizedBox(height: 8),
            Text('$error', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref.invalidate(companyProfileProvider);
                ref.invalidate(defaultTermsProvider);
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    ),
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.profile, super.key});

  final CompanyProfileData profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kairo Quotes'),
        actions: [
          IconButton(
            tooltip: 'Company settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              final terms = ref.read(defaultTermsProvider).asData?.value;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) =>
                      SettingsScreen(profile: profile, terms: terms),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (profile.logoPath != null &&
                    File(profile.logoPath!).existsSync())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Image.file(
                      File(profile.logoPath!),
                      height: 96,
                      fit: BoxFit.contain,
                    ),
                  )
                else
                  Icon(
                    Icons.water_drop,
                    size: 64,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                const SizedBox(height: 16),
                Text(
                  'Kairo Quotes is running',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(color: KairoQuotesApp.navy),
                ),
                const SizedBox(height: 8),
                Text(
                  profile.companyName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Offline quotations, invoices and receipts',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const QuotesScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.request_quote_outlined),
                    label: const Text('Quotations'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const CustomersScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.people_outline),
                    label: const Text('Customers'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const CatalogScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.inventory_2_outlined),
                    label: const Text('Catalog'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
