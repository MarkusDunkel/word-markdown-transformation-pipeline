#!/usr/bin/env bash

mkdir -p "Word-Templates"

./build_docx.sh "markdown-templates/1_lastenheft-grobkonzept-template.md" "Word-Templates/1_lastenheft-grobkonzept-template.docx"
./build_docx.sh "markdown-templates/2_feinkonzept-abnahmekriterien-template.md" "Word-Templates/2_feinkonzept-abnahmekriterien-template.docx"
./build_docx.sh "markdown-templates/3_test-und-freigabedokument-template.md" "Word-Templates/3_test-und-freigabedokument-template.docx"
./build_docx.sh "markdown-templates/5_benutzerdokumentation-template.md" "Word-Templates/5_benutzerdokumentation-template.docx"

echo "Alle Word-Templates wurden unter Word-Templates erstellt."
