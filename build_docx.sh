#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Verwendung: ./build_docx.sh eingabe.md ausgabe.docx"
  exit 1
fi

INPUT_MD="$1"
OUTPUT_DOCX="$2"

RESOURCE_PATH="/c/Users/markus.dunkel/Downloads:/c/Users/markus.dunkel/Downloads/images"
REFERENCE_DOC="./vorlage.dotx"

TMP_PANDOC_DOCX="$(mktemp --suffix=.docx)"
TMP_BORDERS_DOCX="$(mktemp --suffix=.docx)"

extract_yaml_title() {
  local input_file="$1"
  python - "$input_file" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
match = re.match(r"\A---\s*\n(.*?)\n---\s*(?:\n|$)", text, re.DOTALL)
if not match:
    raise SystemExit(0)

header = match.group(1)
for line in header.splitlines():
    title_match = re.match(r'^\s*title\s*:\s*(.*?)\s*$', line)
    if not title_match:
        continue
    value = title_match.group(1).strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
        value = value[1:-1]
    print(value)
    raise SystemExit(0)
PY
}

cleanup() {
  rm -f "$TMP_PANDOC_DOCX" "$TMP_BORDERS_DOCX"
}
trap cleanup EXIT

echo "==> Pandoc: Markdown -> DOCX"
pandoc "$INPUT_MD" \
  --resource-path="$RESOURCE_PATH" \
  --reference-doc="$REFERENCE_DOC" \
  --number-sections \
  -o "$TMP_PANDOC_DOCX"

echo "==> Tabellenrahmen setzen"
python fix_table_borders.py "$TMP_PANDOC_DOCX" "$TMP_BORDERS_DOCX"

echo "==> TOC-Feld nach erster Tabelle einfügen"
TITLE="$(extract_yaml_title "$INPUT_MD")"
if [ -n "$TITLE" ]; then
  python insert_toc.py "$TMP_BORDERS_DOCX" "$OUTPUT_DOCX" --title "$TITLE"
else
  python insert_toc.py "$TMP_BORDERS_DOCX" "$OUTPUT_DOCX"
fi

echo "Fertig: $OUTPUT_DOCX"
