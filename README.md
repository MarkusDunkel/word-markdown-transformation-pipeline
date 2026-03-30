# Markdown ↔ Word Konvertierungs-Workflow

Dieses Verzeichnis enthält Skripte, um Word-Dokumente nach Markdown zu konvertieren und anschließend wieder nach Word zurückzuwandeln, inklusive Nachbearbeitung.

## Übersicht

Der gesamte Ablauf besteht aus zwei Richtungen:

### 1. Word → Markdown
DOCX → pandoc → Markdown → optionale Python-Nachbearbeitung

### 2. Markdown → Word
Markdown → pandoc mit Word-Vorlage → DOCX → Python-Nachbearbeitung für Tabellen

## Dateien im Ordner

| Datei | Beschreibung |
|---|---|
| `convertdocx.sh` | Konvertiert Word → Markdown |
| `build_docx.sh` | Konvertiert Markdown → Word |
| `fix_table_borders.py` | Formatiert Tabellen im DOCX |
| `md_postprocess.py` | Bereinigt Markdown, z. B. TOC entfernen, YAML ergänzen |
| `vorlage.dotx` | Word-Vorlage für Pandoc |
| `README.md` | Diese Dokumentation |

## Voraussetzungen

Benötigte Programme:

- `pandoc`
- `python`
- `python-docx`

Installation von `python-docx`:

```bash
python -m pip install python-docx
```

Versionen prüfen:

```bash
pandoc --version
python --version
```

## Word → Markdown

Beispiel:

```bash
./convertdocx.sh \
  /c/Users/markus.dunkel/Downloads/input.docx \
  /c/Users/markus.dunkel/Downloads/output.md
```

Optionales Nachbearbeiten des erzeugten Markdown:

```bash
python md_postprocess.py raw.md clean.md
```

## Markdown → Word

Beispiel:

```bash
./build_docx.sh \
  /c/Users/markus.dunkel/Downloads/fertig.md \
  /c/Users/markus.dunkel/Downloads/ziel.docx
```

## Referenz: direktes Pandoc-Kommando

Das Skript baut im Kern auf diesem Pandoc-Aufruf auf:

```bash
pandoc /c/Users/markus.dunkel/Downloads/fertig.md \
  --resource-path=/c/Users/markus.dunkel/Downloads:/c/Users/markus.dunkel/Downloads/images \
  --reference-doc=./vorlage.dotx \
  --toc \
  --number-sections \
  -o /c/Users/markus.dunkel/Downloads/ziel.docx
```

## Typischer Gesamt-Workflow

```bash
# 1. Word → Markdown
./convertdocx.sh input.docx raw.md

# 2. Markdown bereinigen
python md_postprocess.py raw.md clean.md

# 3. Markdown manuell weiter bearbeiten

# 4. Markdown → Word
./build_docx.sh clean.md final.docx
```

## Hinweise

### Tabellen
Tabellen werden nach der Pandoc-Konvertierung automatisch nachbearbeitet, z. B.:

- Rahmen
- Innenlinien
- graue Linien
- vertikale Zentrierung
- Korrektur von Absatzabständen

### Word-Vorlage
Layout, Schriftarten, Überschriften, Inhaltsverzeichnis und weitere Formatierungen werden über `vorlage.dotx` gesteuert.

## Troubleshooting

### Fehler: `ModuleNotFoundError: No module named 'docx'`

```bash
python -m pip install python-docx
```

### Pandoc findet Bilder nicht
Dann `--resource-path` prüfen.

### Tabellen ohne Rahmen
Dann wurde `fix_table_borders.py` nicht ausgeführt oder `python-docx` fehlt.

## Projektstruktur

```text
markdown_word_transform/
├── convertdocx.sh
├── build_docx.sh
├── fix_table_borders.py
├── md_postprocess.py
├── vorlage.dotx
└── README.md
```

## Zusammenfassung

| Richtung | Skript |
|---|---|
| Word → Markdown | `convertdocx.sh` |
| Markdown → Word | `build_docx.sh` |
| Tabellen formatieren | `fix_table_borders.py` |
| Markdown bereinigen | `md_postprocess.py` |
