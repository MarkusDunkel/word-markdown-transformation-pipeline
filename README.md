# Markdown ↔ Word Konvertierungs-Workflow

This directory contains scripts to convert Word documents to Markdown and then convert them back to Word, including post-processing.

## Übersicht

The overall flow consists of two directions:

### 1. Word → Markdown
DOCX → pandoc → Markdown → optional Python post-processing

### 2. Markdown → Word
Markdown → pandoc with Word template → DOCX → Python post-processing for tables

## Dateien im Ordner

| Datei | Beschreibung |
|---|---|
| `convert_docx.sh` | Converts Word → Markdown |
| `build_docx.sh` | Converts Markdown → Word |
| `fix_table_borders.py` | Formats tables in DOCX |
| `md_postprocess.py` | Cleans Markdown, e.g. removes TOC and adds YAML |
| `vorlage.dotx` | Word template for Pandoc |
| `README.md` | This documentation |

## Voraussetzungen

Required programs:

- `pandoc`
- `python`
- `python-docx`

Install `python-docx`:

```bash
python -m pip install python-docx
```

Check versions:

```bash
pandoc --version
python --version
```

## Word → Markdown

Example:

```bash
./convert_docx.sh \
  /c/Users/markus.dunkel/Downloads/input.docx \
  /c/Users/markus.dunkel/Downloads/output.md
```

Optional post-processing of the generated Markdown:

```bash
python md_postprocess.py raw.md clean.md
```

## Markdown → Word

Example:

```bash
./build_docx.sh \
  /c/Users/markus.dunkel/Downloads/fertig.md \
  /c/Users/markus.dunkel/Downloads/ziel.docx
```

## Referenz: direktes Pandoc-Kommando

At its core, the script is based on this Pandoc call:

```bash
pandoc /c/Users/markus.dunkel/Downloads/fertig.md \
  --resource-path=/c/Users/markus.dunkel/Downloads:/c/Users/markus.dunkel/Downloads/images \
  --reference-doc=./vorlage.dotx \
  --toc \
  --number-sections \
  -o /c/Users/markus.dunkel/Downloads/ziel.docx
```

## Namenskonvention für Templates

All template files use the placeholder standard `YYYY-TT-nnnn-Liefergegenstand`:

- `YYYY-LH-nnnn-Liefergegenstand.docx` (Requirements specification)
- `YYYY-PH-nnnn-Liefergegenstand.docx` (Functional specification / detailed concept)
- `YYYY-TD-nnnn-Liefergegenstand.md` (Technical documentation)
- `YYYY-TA-nnnn-Liefergegenstand.docx` (Testing and delivery)
- `YYYY-BD-nnnn-Liefergegenstand.docx` (User documentation)

Markdown templates are located in `markdown-templates/`; Word templates are generated in `Word-Templates/` with `./build_all_docx_templates.sh`.

## Typischer Gesamt-Workflow

```bash
# 1. Word → Markdown
./convert_docx.sh input.docx raw.md

# 2. Clean Markdown
python md_postprocess.py raw.md clean.md

# 3. Continue editing Markdown manually

# 4. Markdown → Word
./build_docx.sh clean.md final.docx
```

## Hinweise

### Tabellen
After Pandoc conversion, tables are automatically post-processed, for example:

- Borders
- Inner lines
- Gray lines
- Vertical centering
- Correction of paragraph spacing

### Word-Vorlage
Layout, fonts, headings, table of contents, and additional formatting are controlled via `vorlage.dotx`.

## Troubleshooting

### Fehler: `ModuleNotFoundError: No module named 'docx'`

```bash
python -m pip install python-docx
```

### Pandoc findet Bilder nicht
Then check `--resource-path`.

### Tabellen ohne Rahmen
Then `fix_table_borders.py` was not executed, or `python-docx` is missing.

## Projektstruktur

```text
markdown_word_transform/
├── convert_docx.sh
├── build_docx.sh
├── fix_table_borders.py
├── md_postprocess.py
├── vorlage.dotx
└── README.md
```

## Zusammenfassung

| Richtung | Skript |
|---|---|
| Word → Markdown | `convert_docx.sh` |
| Markdown → Word | `build_docx.sh` |
| Format tables | `fix_table_borders.py` |
| Clean Markdown | `md_postprocess.py` |
