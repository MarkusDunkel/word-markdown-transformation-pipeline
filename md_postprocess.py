#!/usr/bin/env python3
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


TOC_HEADINGS = {
    "inhalt",
    "inhaltsverzeichnis",
    "contents",
    "table of contents",
}

HEADING_RE = re.compile(r"^\s{0,3}(#{1,6})\s+(.+?)\s*$")
BULLET_TOC_RE = re.compile(r"^\s*[-*+]\s+\[.*\]\(#.*\)\s*$")
ORDERED_TOC_RE = re.compile(r"^\s*\d+\.\s+\[.*\]\(#.*\)\s*$")
PLAIN_LINK_TOC_RE = re.compile(r"^\s*\[.*\]\(#.*\)\s*$")

# Entfernt nur einen YAML-Header ganz am Dokumentanfang
YAML_HEADER_RE = re.compile(r"\A---\n.*?\n---\n+", re.DOTALL)

# Typische Pandoc/Word-Anker:
# <span id="_Toc225495975" class="anchor"></span>
WORD_ANCHOR_RE = re.compile(r'^<span id="_Toc\d+" class="anchor"></span>\s*')

MULTI_BLANKS_RE = re.compile(r"\n{3,}")
LIST_ITEM_RE = re.compile(r"^\s*(?:[-*+]\s+|\d+[.)]\s+)")


def remove_yaml_header(text: str) -> str:
    return YAML_HEADER_RE.sub("", text, count=1)


def parse_heading(line: str) -> tuple[int, str] | None:
    match = HEADING_RE.match(line)
    if not match:
        return None
    level = len(match.group(1))
    heading = match.group(2).strip()
    return level, heading


def is_toc_heading(line: str) -> bool:
    parsed = parse_heading(line)
    if not parsed:
        return False
    _, heading = parsed
    return heading.casefold() in TOC_HEADINGS


def is_toc_entry_line(line: str) -> bool:
    stripped = line.strip()
    if not stripped:
        return False

    return any(
        pattern.match(stripped)
        for pattern in (BULLET_TOC_RE, ORDERED_TOC_RE, PLAIN_LINK_TOC_RE)
    )


def remove_toc_block(text: str) -> str:
    """
    Entfernt einen TOC-Block der Form:

    # Inhalt
    [Kapitel](#kapitel)
    [Unterkapitel](#unterkapitel)

    oder auch Listenformen wie:
    - [Kapitel](#kapitel)
    1. [Kapitel](#kapitel)

    Der Block wird nur entfernt, wenn eine echte TOC-Überschrift erkannt wird.
    """
    lines = text.splitlines()
    output: list[str] = []
    i = 0

    while i < len(lines):
        if not is_toc_heading(lines[i]):
            output.append(lines[i])
            i += 1
            continue

        # TOC-Überschrift gefunden -> entfernen
        i += 1

        # Leerzeilen nach TOC-Überschrift überspringen
        while i < len(lines) and not lines[i].strip():
            i += 1

        removed_any_entries = False

        # TOC-Einträge + Leerzeilen entfernen
        while i < len(lines):
            current = lines[i]

            if not current.strip():
                i += 1
                continue

            if is_toc_entry_line(current):
                removed_any_entries = True
                i += 1
                continue

            break

        # Auch nachfolgende Leerzeilen entfernen
        while i < len(lines) and not lines[i].strip():
            i += 1

        # Egal ob Einträge gefunden wurden oder nicht:
        # die TOC-Überschrift selbst soll weg.
        # Deshalb kein output.append(...)

    return "\n".join(output)


def remove_word_anchor_spans(text: str) -> str:
    """
    Entfernt typische Word/Pandoc-Anker.
    Falls nach dem Span noch Text in derselben Zeile steht,
    bleibt dieser Text erhalten.
    """
    cleaned_lines: list[str] = []

    for line in text.splitlines():
        stripped = line.strip()

        if WORD_ANCHOR_RE.match(stripped):
            remainder = WORD_ANCHOR_RE.sub("", stripped, count=1).strip()
            if remainder:
                cleaned_lines.append(remainder)
            continue

        cleaned_lines.append(line)

    return "\n".join(cleaned_lines)


def build_yaml_header(title: str, lang: str = "de") -> str:
    escaped_title = title.replace('"', '\\"')
    escaped_lang = lang.replace('"', '\\"')

    return (
        "---\n"
        f'title: "{escaped_title}"\n'
        f'lang: "{escaped_lang}"\n'
        "---\n\n"
    )


def derive_title_from_filename(path: Path) -> str:
    name = path.stem.replace("_", " ").replace("-", " ").strip()
    return name if name else "Dokument"


def normalize_spacing(text: str) -> str:
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    text = remove_blank_lines_between_list_items(text)
    text = MULTI_BLANKS_RE.sub("\n\n", text)
    return text.strip() + "\n"


def remove_blank_lines_between_list_items(text: str) -> str:
    """
    Entfernt Leerzeilen zwischen direkt aufeinanderfolgenden Listeneinträgen.
    Beispiel:
    - Punkt A

    - Punkt B
    ->
    - Punkt A
    - Punkt B
    """
    lines = text.splitlines()
    cleaned_lines: list[str] = []
    i = 0

    while i < len(lines):
        line = lines[i]

        if line.strip():
            cleaned_lines.append(line)
            i += 1
            continue

        prev_line = cleaned_lines[-1] if cleaned_lines else ""

        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        next_line = lines[j] if j < len(lines) else ""

        if LIST_ITEM_RE.match(prev_line) and LIST_ITEM_RE.match(next_line):
            i = j
            continue

        cleaned_lines.append(line)
        i += 1

    return "\n".join(cleaned_lines)


def process_markdown(text: str, title: str, lang: str = "de") -> str:
    processed = text
    processed = remove_yaml_header(processed)
    processed = remove_toc_block(processed)
    processed = remove_word_anchor_spans(processed)
    processed = normalize_spacing(processed)
    return build_yaml_header(title=title, lang=lang) + processed


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Bereinigt ein von Pandoc aus DOCX erzeugtes Markdown."
    )
    parser.add_argument("input", type=Path, help="Eingabe-Markdown-Datei")
    parser.add_argument("output", type=Path, help="Ausgabe-Markdown-Datei")
    parser.add_argument(
        "--title",
        help="Titel für den YAML-Header. Standard: aus Dateiname der Ausgabedatei abgeleitet.",
    )
    parser.add_argument(
        "--lang",
        default="de",
        help='Sprache für den YAML-Header, Standard: "de".',
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    input_path: Path = args.input
    output_path: Path = args.output

    if not input_path.exists():
        print(f"Datei nicht gefunden: {input_path}", file=sys.stderr)
        return 1

    if not input_path.is_file():
        print(f"Kein regulärer Dateipfad: {input_path}", file=sys.stderr)
        return 1

    try:
        text = input_path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        print(
            f"Datei ist nicht als UTF-8 lesbar: {input_path}",
            file=sys.stderr,
        )
        return 1
    except OSError as exc:
        print(f"Fehler beim Lesen von {input_path}: {exc}", file=sys.stderr)
        return 1

    title = args.title if args.title else derive_title_from_filename(output_path)

    processed = process_markdown(text=text, title=title, lang=args.lang)

    try:
        output_path.write_text(processed, encoding="utf-8", newline="\n")
    except OSError as exc:
        print(f"Fehler beim Schreiben von {output_path}: {exc}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
