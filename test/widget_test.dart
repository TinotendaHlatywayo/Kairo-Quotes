import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/main.dart';

void main() {
  testWidgets('shows the EM Quotes home screen', (tester) async {
    await tester.pumpWidget(const EmQuotesApp());

    expect(find.text('EM Quotes'), findsOneWidget);
    expect(find.text('EM Quotes is running'), findsOneWidget);
    expect(
      find.text('Offline quotations, invoices and receipts'),
      findsOneWidget,
    );
  });
}
