#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Verwendung: ./convert_docx.sh eingabe.docx [ausgabe.md]"
  exit 1
fi

INPUT_DOCX="$1"

if [ ! -f "$INPUT_DOCX" ]; then
  echo "Datei nicht gefunden: $INPUT_DOCX"
  exit 1
fi

if [ $# -ge 2 ]; then
  OUTPUT_MD="$2"
else
  BASENAME="$(basename "$INPUT_DOCX" .docx)"
  OUTPUT_MD="${BASENAME}.md"
fi

TMP_MD="${OUTPUT_MD%.md}.raw.md"

pandoc "$INPUT_DOCX" -f docx -t gfm --wrap=none --number-sections -o "$TMP_MD"
python md_postprocess.py "$TMP_MD" "$OUTPUT_MD"
rm -f "$TMP_MD"

echo "Fertig: $OUTPUT_MD"