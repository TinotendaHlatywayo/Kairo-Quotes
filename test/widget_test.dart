import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/core/providers.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/main.dart';

void main() {
  testWidgets('shows Kairo Quotes first-run company setup', (tester) async {
    final database = AppDatabase(executor: NativeDatabase.memory());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWith((ref) {
            ref.onDispose(database.close);
            return database;
          }),
        ],
        child: const KairoQuotesApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Set up Kairo Quotes'), findsOneWidget);
    expect(find.text('Company name'), findsOneWidget);
    await tester.dragUntilVisible(
      find.text('VAT rate (%)'),
      find.byType(ListView),
      const Offset(0, -400),
    );
    expect(find.text('VAT rate (%)'), findsOneWidget);
    expect(
      find.text('Verify the current VAT rate and invoicing requirements with ZIMRA.'),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
