#!/usr/bin/env bash
set -euo pipefail

INPUT_MD="$1"
OUTPUT_DOCX="$2"

RESOURCE_PATH="/c/Users/markus.dunkel/Downloads:/c/Users/markus.dunkel/Downloads/images"
REFERENCE_DOC="./vorlage-n.dotx"

TMP_DOCX="$(mktemp --suffix=.docx)"

echo "==> Pandoc: Markdown -> DOCX"
pandoc "$INPUT_MD" \
  --resource-path="$RESOURCE_PATH" \
  --reference-doc="$REFERENCE_DOC" \
  --toc \
  --number-sections \
  -o "$TMP_DOCX"

echo "==> Tabellenrahmen setzen"
python fix_table_borders.py "$TMP_DOCX" "$OUTPUT_DOCX"

rm "$TMP_DOCX"

echo "Fertig: $OUTPUT_DOCX"