#!/bin/sh
# Renders rules-sheet/rules-sheet.html to rules-sheet.pdf and fails if it spills past one page.
set -e
cd "$(dirname "$0")/.."

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --virtual-time-budget=5000 \
  --print-to-pdf="$PWD/rules-sheet.pdf" "file://$PWD/rules-sheet/rules-sheet.html" 2>/dev/null

pages=$(python3 -c "import re; print(len(re.findall(rb'/Type\s*/Page[^s]', open('rules-sheet.pdf', 'rb').read())))")
echo "rules-sheet.pdf: $pages page(s)"
[ "$pages" = 1 ] || { echo "The rules sheet no longer fits on one page." >&2; exit 1; }
