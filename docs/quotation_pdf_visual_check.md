# Quotation PDF visual check

1. Build and install the app using the Android instructions in `README.md`.
2. Create a quote with a customer, a section row, at least two catalog/free-text rows, terms, and a long description. Save it, issue it, then open **Preview PDF**.
3. Check the header, navy title bar, blue tagline band, customer/quote boxes, dark table header, grey section row, right-aligned totals, terms, signatory, and page number. Add enough rows to force at least two pages and confirm the table header repeats and totals/terms/signature stay together.
4. To compare against the original, place the supplied image at `reference/quotation_template.jpeg` and a PDF export beside it. Render the PDF pages with `scripts/render_quote_pdf.sh exported_quote.pdf`. Open the resulting PNG and the reference image side by side at the same zoom. Compare block order, margins, colours, type scale, and relative widths; do not compare customer-specific content.

The repository currently does not contain `reference/quotation_template.jpeg`, so an exact visual comparison has not yet been possible. The PDF generation test verifies a real PDF is produced; Android's native preview/share/print surface needs a manual device check.
