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
python insert_toc.py "$TMP_BORDERS_DOCX" "$OUTPUT_DOCX"

echo "Fertig: $OUTPUT_DOCX"
