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
  awk '
    BEGIN { in_header=0 }
    /^---[[:space:]]*$/ {
      if (in_header == 0) { in_header=1; next }
      if (in_header == 1) { exit }
    }
    in_header == 1 && /^[[:space:]]*[Tt][Ii][Tt][Ll][Ee][[:space:]]*:/ {
      sub(/^[[:space:]]*[Tt][Ii][Tt][Ll][Ee][[:space:]]*:[[:space:]]*/, "")
      sub(/[[:space:]]*$/, "")
      if (($0 ~ /^".*"$/) || ($0 ~ /^'\''.*'\''$/)) {
        $0 = substr($0, 2, length($0)-2)
      }
      print
      exit
    }
  ' "$input_file"
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
