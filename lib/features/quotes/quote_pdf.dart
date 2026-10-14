import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/app_database.dart';
import '../../domain/money.dart';
import '../../domain/pricing_engine.dart';

class QuotePdf {
  static Future<Uint8List> build(
    DocumentData quote,
    List<DocumentLineData> lines,
  ) async {
    final pdf = pw.Document();
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/EMBody-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/EMDisplay-Bold.ttf'),
    );
    final lineInputs = lines
        .map(
          (l) => PricingLine(
            isSectionHeader: l.isSectionHeader,
            unitPriceMinor: l.unitPriceMinor,
            quantityMilli: l.quantityMilli,
          ),
        )
        .toList();
    final total = const PricingEngine().calculate(
      lines: lineInputs,
      vatRateBasisPoints: quote.vatRateBasisPoints,
      discount: switch (quote.discountKind) {
        'percent' => Discount.percent(quote.discountValue),
        'fixed' => Discount.fixed(quote.discountValue),
        _ => const Discount.none(),
      },
    );
    String money(int value) => MoneyFormatter.format(value, quote.currencyCode);
    final logoFile = quote.logoPathSnapshot;
    final logo = logoFile != null && File(logoFile).existsSync()
        ? pw.MemoryImage(await File(logoFile).readAsBytes())
        : null;
    final navy = PdfColor.fromInt(0xFF102D52);
    final pale = PdfColor.fromInt(0xFFEAF2F8);
    final issued = quote.issuedAt;
    final expiry = quote.expiresAt;
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(34, 30, 34, 34),
        theme: pw.ThemeData.withFont(base: regular, bold: bold),
        footer: (context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Kairo Quotes  •  ${quote.companyNameSnapshot}',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
            ),
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
            ),
          ],
        ),
        build: (context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (logo != null)
                pw.Container(
                  width: 54,
                  height: 54,
                  margin: const pw.EdgeInsets.only(right: 12),
                  child: pw.Image(logo, fit: pw.BoxFit.contain),
                ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      quote.companyNameSnapshot,
                      style: pw.TextStyle(
                        font: bold,
                        fontSize: 19,
                        color: navy,
                      ),
                    ),
                    if (quote.legalNameSnapshot.isNotEmpty)
                      pw.Text(
                        quote.legalNameSnapshot,
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                  ],
                ),
              ),
              pw.SizedBox(width: 12),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    if (quote.addressSnapshot.isNotEmpty)
                      pw.Text(
                        quote.addressSnapshot,
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    if (quote.phoneNumbersSnapshot.isNotEmpty)
                      pw.Text(
                        quote.phoneNumbersSnapshot,
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    if ((quote.vatNumberSnapshot ?? '').isNotEmpty)
                      pw.Text(
                        'VAT: ${quote.vatNumberSnapshot}',
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    if ((quote.tinNumberSnapshot ?? '').isNotEmpty)
                      pw.Text(
                        'TIN: ${quote.tinNumberSnapshot}',
                        textAlign: pw.TextAlign.right,
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (quote.taglineSnapshot.isNotEmpty)
            pw.Container(
              width: double.infinity,
              color: pale,
              padding: const pw.EdgeInsets.all(7),
              margin: const pw.EdgeInsets.only(top: 9),
              child: pw.Text(
                quote.taglineSnapshot,
                style: pw.TextStyle(font: bold, color: navy, fontSize: 10),
              ),
            ),
          pw.Container(
            width: double.infinity,
            margin: const pw.EdgeInsets.only(top: 10, bottom: 10),
            padding: const pw.EdgeInsets.symmetric(vertical: 8),
            color: navy,
            child: pw.Center(
              child: pw.Text(
                'QUOTATION FOR BOREHOLE DRILLING',
                style: pw.TextStyle(
                  font: bold,
                  fontSize: 14,
                  color: PdfColors.white,
                ),
              ),
            ),
          ),
          pw.Row(
            children: [
              _box(
                'QUOTATION DETAILS',
                [
                  'Quote: ${quote.documentNumber ?? 'DRAFT'}',
                  if (issued != null) 'Date: ${_date(issued)}',
                  if (expiry != null) 'Valid until: ${_date(expiry)}',
                  'Currency: ${quote.currencyCode}',
                ].join('\n'),
                pale,
                navy,
              ),
              pw.SizedBox(width: 10),
              _box(
                'CUSTOMER',
                [
                  quote.customerNameSnapshot,
                  quote.customerLocationSnapshot,
                  quote.customerPhoneSnapshot,
                ].where((s) => s.isNotEmpty).join('\n'),
                pale,
                navy,
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Table(
            columnWidths: {
              0: const pw.FixedColumnWidth(29),
              1: const pw.FlexColumnWidth(4),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(1),
              4: const pw.FlexColumnWidth(1.8),
            },
            border: pw.TableBorder.all(color: PdfColors.grey400, width: .5),
            children: [
              pw.TableRow(
                repeat: true,
                decoration: pw.BoxDecoration(color: navy),
                children:
                    ['S.No', 'DESIGNATION', 'UNIT PRICE', 'QTY', 'TOTAL PRICE']
                        .map(
                          (s) => pw.Padding(
                            padding: const pw.EdgeInsets.all(6),
                            child: pw.Text(
                              s,
                              style: pw.TextStyle(
                                font: bold,
                                fontSize: 8,
                                color: PdfColors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
              for (var i = 0; i < lines.length; i++)
                pw.TableRow(
                  decoration: lines[i].isSectionHeader
                      ? pw.BoxDecoration(color: PdfColors.grey300)
                      : null,
                  children: lines[i].isSectionHeader
                      ? [
                          pw.SizedBox(),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              lines[i].designation,
                              style: pw.TextStyle(font: bold, fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(),
                          pw.SizedBox(),
                          pw.SizedBox(),
                        ]
                      : [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              '${i + 1}',
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              lines[i].designation,
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              money(lines[i].unitPriceMinor ?? 0),
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              Quantity(lines[i].quantityMilli ?? 0).format(),
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              money(total.lineTotalsMinor[i]),
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Inseparable(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _totalRow('Subtotal', money(total.subtotalMinor)),
                if (total.discountMinor > 0)
                  _totalRow('Discount', '−${money(total.discountMinor)}'),
                if (quote.vatRateBasisPoints > 0)
                  _totalRow(
                    'VAT (${_percent(quote.vatRateBasisPoints)}%)',
                    money(total.vatMinor),
                  ),
                pw.Container(
                  color: pale,
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'TOTAL',
                        style: pw.TextStyle(
                          font: bold,
                          color: navy,
                          fontSize: 12,
                        ),
                      ),
                      pw.Text(
                        money(total.grandTotalMinor),
                        style: pw.TextStyle(
                          font: bold,
                          color: navy,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (quote.termsSnapshot.trim().isNotEmpty) ...[
                  pw.SizedBox(height: 12),
                  pw.Text(
                    'TERMS AND CONDITIONS',
                    style: pw.TextStyle(font: bold, color: navy, fontSize: 10),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    quote.termsSnapshot,
                    style: const pw.TextStyle(fontSize: 8),
                  ),
                ],
                if (quote.signatorySnapshot.isNotEmpty) ...[
                  pw.SizedBox(height: 22),
                  pw.Text(
                    quote.signatorySnapshot,
                    style: pw.TextStyle(font: bold, fontSize: 9),
                  ),
                  if (quote.legalNameSnapshot.isNotEmpty)
                    pw.Text(
                      quote.legalNameSnapshot,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  pw.Text(
                    'Authorized signatory',
                    style: const pw.TextStyle(fontSize: 8),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    return pdf.save();
  }

  static pw.Widget _box(
    String title,
    String value,
    PdfColor fill,
    PdfColor ink,
  ) => pw.Expanded(
    child: pw.Container(
      color: fill,
      padding: const pw.EdgeInsets.all(8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: ink,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 8, lineSpacing: 2),
          ),
        ],
      ),
    ),
  );
  static pw.Widget _totalRow(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 9)),
      ],
    ),
  );
  static String _date(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  static String _percent(int bp) =>
      '${bp ~/ 100}.${(bp % 100).toString().padLeft(2, '0')}';
}
