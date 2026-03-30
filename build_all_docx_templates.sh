#!/usr/bin/env bash
set -euo pipefail

mkdir -p "Word-Templates"

./build_docx.sh "markdown-templates/YYYY-LH-nnnn-Liefergegenstand.md" "Word-Templates/YYYY-LH-nnnn-Liefergegenstand.docx"
./build_docx.sh "markdown-templates/YYYY-PH-nnnn-Liefergegenstand.md" "Word-Templates/YYYY-PH-nnnn-Liefergegenstand.docx"
./build_docx.sh "markdown-templates/YYYY-TA-nnnn-Liefergegenstand.md" "Word-Templates/YYYY-TA-nnnn-Liefergegenstand.docx"
./build_docx.sh "markdown-templates/YYYY-BD-nnnn-Liefergegenstand.md" "Word-Templates/YYYY-BD-nnnn-Liefergegenstand.docx"

echo "Alle Word-Templates wurden unter Word-Templates mit Namenskonvention YYYY-TT-nnnn-Liefergegenstand erstellt."
