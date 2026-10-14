import 'package:flutter/material.dart';

void main() {
  runApp(const EmQuotesApp());
}

class EmQuotesApp extends StatelessWidget {
  const EmQuotesApp({super.key});

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
    return MaterialApp(
      title: 'EM Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EM Quotes')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.water_drop,
                size: 64,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              Text(
                'EM Quotes is running',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: EmQuotesApp.navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Offline quotations, invoices and receipts',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
