#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <quotation.pdf> [output-prefix]" >&2
  exit 2
fi

pdf_file="$1"
output_prefix="${2:-${pdf_file%.pdf}}"
if [[ ! -f "$pdf_file" ]]; then
  echo "PDF not found: $pdf_file" >&2
  exit 1
fi
if ! command -v pdfinfo >/dev/null || ! command -v pdftoppm >/dev/null; then
  echo "Install Poppler tools (pdfinfo and pdftoppm) to render the PDF." >&2
  exit 1
fi

pdfinfo "$pdf_file"
pdftoppm -png -r 140 "$pdf_file" "$output_prefix"
echo "Rendered pages as ${output_prefix}-1.png, ${output_prefix}-2.png, ..."
