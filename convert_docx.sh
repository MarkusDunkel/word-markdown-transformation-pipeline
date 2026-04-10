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

extract_docx_title() {
  local input_docx="$1"
  python - "$input_docx" <<'PY'
import sys

try:
    from docx import Document
except Exception:
    print("")
    raise SystemExit(0)

path = sys.argv[1]
document = Document(path)

for paragraph in document.paragraphs:
    text = paragraph.text.strip()
    if not text:
        continue

    style = paragraph.style
    style_name = (style.name or "").strip().casefold() if style else ""
    style_id = (style.style_id or "").strip().casefold() if style else ""

    if style_name in {"title", "titel"} or style_id == "title":
        print(text.splitlines()[0].strip())
        raise SystemExit(0)

print("")
PY
}

pandoc "$INPUT_DOCX" -f docx -t gfm --wrap=none --number-sections -o "$TMP_MD"
DOCX_TITLE="$(extract_docx_title "$INPUT_DOCX")"
if [ -n "$DOCX_TITLE" ]; then
  python md_postprocess.py "$TMP_MD" "$OUTPUT_MD" --title "$DOCX_TITLE"
else
  python md_postprocess.py "$TMP_MD" "$OUTPUT_MD"
fi
rm -f "$TMP_MD"

echo "Fertig: $OUTPUT_MD"
