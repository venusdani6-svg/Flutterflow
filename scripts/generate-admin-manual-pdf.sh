#!/usr/bin/env bash
# Generate ADMIN_MANUAL.pdf from docs/ADMIN_MANUAL.md
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/docs/ADMIN_MANUAL.md"
OUT="$ROOT/docs/ADMIN_MANUAL.pdf"

if [[ ! -f "$SRC" ]]; then
  echo "Missing $SRC"
  exit 1
fi

echo "==> Generating PDF: $OUT"

if command -v pandoc >/dev/null 2>&1; then
  pandoc "$SRC" -o "$OUT" \
    --pdf-engine=xelatex \
    -V documentclass=ltjarticle \
    -V geometry:margin=2cm \
    2>/dev/null || pandoc "$SRC" -o "$OUT" -V geometry:margin=2cm
  echo "Done (pandoc): $OUT"
  exit 0
fi

# Fallback: md-to-pdf via npx
cd "$ROOT"
npx --yes md-to-pdf "$SRC" --dest "$OUT" 2>/dev/null && {
  echo "Done (md-to-pdf): $OUT"
  exit 0
}

# Fallback: pre-built HTML + Chrome headless
HTML="$ROOT/docs/ADMIN_MANUAL.html"
if [[ -f "$HTML" ]] && command -v google-chrome >/dev/null 2>&1; then
  google-chrome --headless --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$OUT" "file://$HTML" 2>/dev/null
  echo "Done (chrome + ADMIN_MANUAL.html): $OUT"
  exit 0
fi

echo ""
echo "Could not generate PDF automatically."
echo "Option A: google-chrome --headless --print-to-pdf=docs/ADMIN_MANUAL.pdf docs/ADMIN_MANUAL.html"
echo "Option B: Open docs/ADMIN_MANUAL.md in Word/Google Docs → Export PDF"
echo "Markdown source: $SRC"
exit 1
