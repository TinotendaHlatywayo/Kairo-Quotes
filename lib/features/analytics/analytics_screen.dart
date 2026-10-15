import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../domain/analytics_service.dart';
import '../../domain/money.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  late Future<AnalyticsReport> _report;
  String? _currency;

  @override
  void initState() {
    super.initState();
    _report = ref.read(analyticsRepositoryProvider).loadReport();
  }

  void _refresh() => setState(
    () => _report = ref.read(analyticsRepositoryProvider).loadReport(),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Analytics'),
      actions: [
        IconButton(
          tooltip: 'Refresh analytics',
          onPressed: _refresh,
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: FutureBuilder<AnalyticsReport>(
      future: _report,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Analytics could not be loaded: ${snapshot.error}'),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final report = snapshot.data!;
        if (report.currencies.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No issued quotations, invoices, or payments to summarize yet.',
              ),
            ),
          );
        }
        final codes = report.currencies.keys.toList()..sort();
        final selected = codes.contains(_currency) ? _currency! : codes.first;
        final data = report.currencies[selected]!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              initialValue: selected,
              decoration: const InputDecoration(labelText: 'Currency'),
              items: codes
                  .map(
                    (code) => DropdownMenuItem(value: code, child: Text(code)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _currency = value),
            ),
            const SizedBox(height: 12),
            Text(
              'Financial summary · $selected',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _metric(
                  'Quoted',
                  data.quotedMinor,
                  selected,
                  Icons.request_quote_outlined,
                ),
                _metric(
                  'Invoiced',
                  data.invoicedMinor,
                  selected,
                  Icons.receipt_long_outlined,
                ),
                _metric(
                  'Collected',
                  data.collectedMinor,
                  selected,
                  Icons.payments_outlined,
                ),
                _metric(
                  'Outstanding',
                  data.outstandingMinor,
                  selected,
                  Icons.account_balance_wallet_outlined,
                ),
              ],
            ),
            Card(
              margin: const EdgeInsets.only(top: 8),
              child: ListTile(
                leading: const Icon(Icons.compare_arrows),
                title: const Text('Accepted quote conversion'),
                subtitle: Text(
                  '${report.convertedQuoteCount} converted from ${report.acceptedQuoteCount} accepted quotations',
                ),
                trailing: Text(
                  _percent(report.quoteConversionBasisPoints),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Collections by month · $selected',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(
              margin: const EdgeInsets.only(top: 8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
                child: SizedBox(
                  height: 220,
                  child: _revenueChart(context, data),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _rankingSection(
              context,
              'Top customers · $selected',
              data.topCustomers,
              selected,
            ),
            _rankingSection(
              context,
              'Best-selling services · $selected',
              data.bestSellingServices,
              selected,
            ),
            Card(
              margin: const EdgeInsets.only(top: 12),
              child: ListTile(
                leading: const Icon(Icons.discount_outlined),
                title: const Text('Average invoice discount'),
                subtitle: Text(
                  '${data.discountedInvoiceCount} active invoices included',
                ),
                trailing: Text(
                  _percent(data.averageDiscountBasisPoints),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const Card(
              margin: EdgeInsets.only(top: 8),
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Markup not available'),
                subtitle: Text(
                  'Service costs are not recorded, so markup cannot be calculated reliably.',
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    ),
  );

  Widget _metric(String label, int amount, String currency, IconData icon) =>
      Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  MoneyFormatter.format(amount, currency),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _revenueChart(BuildContext context, CurrencyAnalytics data) {
    final values = data.monthlyRevenue.map((e) => e.amountMinor).toList();
    var maximum = values.fold<int>(0, (m, v) => v > m ? v : m);
    var minimum = values.fold<int>(0, (m, v) => v < m ? v : m);
    if (maximum == minimum) {
      maximum += 100;
      minimum -= 100;
    }
    final pad = ((maximum - minimum) / 10).ceil();
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: (minimum - pad).toDouble(),
        maxY: (maximum + pad).toDouble(),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              interval: ((maximum - minimum) / 3)
                  .clamp(1, double.infinity)
                  .toDouble(),
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: Text(
                  _axisMoney(value.round(), data.currencyCode),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.round();
                if (index < 0 ||
                    index >= data.monthlyRevenue.length ||
                    (value - index).abs() > .1) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    _month(data.monthlyRevenue[index].month),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots
                .map(
                  (spot) => LineTooltipItem(
                    MoneyFormatter.format(spot.y.round(), data.currencyCode),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < values.length; i++)
                FlSpot(i.toDouble(), values[i].toDouble()),
            ],
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).colorScheme.primary
                  .withValues(alpha: .12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankingSection(
    BuildContext context,
    String title,
    List<AnalyticsRanking> items,
    String currency,
  ) => Card(
    margin: const EdgeInsets.only(top: 12),
    child: ExpansionTile(
      title: Text(title),
      subtitle: Text('${items.length} shown'),
      initiallyExpanded: true,
      children: items.isEmpty
          ? [const ListTile(title: Text('No activity yet'))]
          : [
              for (var i = 0; i < items.length; i++)
                ListTile(
                  leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
                  title: Text(items[i].label),
                  trailing: Text(
                    MoneyFormatter.format(items[i].amountMinor, currency),
                  ),
                ),
            ],
    ),
  );

  static String _axisMoney(int minor, String currency) {
    final value = MoneyFormatter.format(minor, currency);
    return value.length > 9 ? '${value.substring(0, 5)}…' : value;
  }

  static String _percent(int basisPoints) =>
      '${basisPoints ~/ 100}.${(basisPoints % 100).toString().padLeft(2, '0')}%';
  static String _month(int month) => const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][month - 1];
}
