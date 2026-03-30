---
tags:
  - Governance
  - Struktur
  - Prozessautomatisierung
  - Dokumente
  - Freigaben
  - Konzepte
---

## Richtlinie zur Dokumentation von Prozessautomatisierungsprojekten

## 1. Zweck der Richtlinie
Diese Richtlinie definiert die Standards zur Dokumentation von Prozessautomatisierungsprojekten.  
Ziel ist eine einheitliche, nachvollziehbare und langfristig wartbare Dokumentation über den gesamten Lebenszyklus eines automatisierten Prozesses.

Die Dokumentation soll:
- Entscheidungen nachvollziehbar machen
- Anforderungen dokumentieren
- technische Umsetzung dokumentieren
- Tests und Freigaben dokumentieren
- den Betrieb und die Nutzung dokumentieren
- Wissen langfristig sichern
- die Zusammenarbeit mit externen Partnern ermöglichen

---

## 2. Grundprinzipien der Dokumentation

Für alle Prozessautomatisierungsprojekte gelten folgende Grundprinzipien:

1. Die Dokumentation muss einer Prozess-ID zugeordnet sein.
2. Fachliche Dokumente werden in Word geführt.
3. Technische Dokumentation wird im Code-Repository in Markdown geführt.
4. Entscheidungen müssen dokumentiert werden.
5. Tests und Freigaben müssen nachvollziehbar dokumentiert werden.
6. Die Dokumentation muss auch Jahre später den Prozess erklärbar machen.
7. Die Dokumentation ist Teil des Projekts und nicht optional.

---

## 3. Dokumentstruktur eines Prozessautomatisierungsprojekts

Jedes Prozessautomatisierungsprojekt besteht aus folgenden Standarddokumenten:

| Nr. | Dokument                       | Zweck                                      | Format                |
| --- | ------------------------------ | ------------------------------------------ | --------------------- |
| 1   | Lastenheft / Grobkonzept       | Fachliche Anforderungen und Zieldefinition | Word                  |
| 2   | Feinkonzept & Abnahmekriterien | Detailkonzept und fachliche Tests          | Word                  |
| 3   | Technische Dokumentation       | Architektur, Umsetzung, technische Details | Markdown (Repository) |
| 4   | Test- und Freigabedokument     | Testergebnisse und Freigabe Produktion     | Word                  |
| 5   | Benutzerdokumentation          | Anleitung für Endanwender                  | Word                  |

Diese Dokumente bilden gemeinsam die vollständige Dokumentation eines automatisierten Prozesses.

---

## 4. Prozess-ID und Benennung der Dokumente

Jeder Prozess erhält eine eindeutige Prozess-ID.

### Beispiel Prozess-ID
YYYY-TT-nnnn-{Liefergegenstand}

YYYY... Jahr
TT... Kürzel des Dokument-Typs
nnn... Dummy-Liefergegenstands-ID (Platzhalter)

Beispiel:
2026-LH-0001-Arbeitszeiterfassung

Template-Standardwert:
YYYY-LH-nnnn-{Liefergegenstand}

### Benennung der Dokumente
Alle Dokumente müssen nach folgendem Schema benannt werden:


| Dokument-Typ | Kürzel | File-Typ |  
| ---          | ---    | ---      |
| Lastenheft   | LH | .docx  |
| Pflichtenheft | PH | .docx |
| Technische_Dokumentation | TD | .md  |
| Test_und_Auslieferung | TA | .docx |
| Benutzerdokumentation | BD | .docx |

Beispiel-Dateinamen mit Dummy-Werten:
- `YYYY-LH-nnnn-{Liefergegenstand}.docx`
- `YYYY-PH-nnnn-{Liefergegenstand}.docx`
- `YYYY-TD-nnnn-{Liefergegenstand}.md`
- `YYYY-TA-nnnn-{Liefergegenstand}.docx`
- `YYYY-BD-nnnn-{Liefergegenstand}.docx`

---

## 5. Beschreibung der einzelnen Dokumente

### 5.1 Lastenheft / Grobkonzept
**Ziel:** Beschreibung der fachlichen Anforderungen und des Prozessziels.

**Inhalte:**
- Problemstellung
- **Ziel des Prozesses**
- Business Nutzen
- **Anforderungen (Muss / Soll)**
- Grober Prozessablauf
- Annahmen
- Offene Punkte
- **Grobe Aufwandsschätzung**
- Projektentscheidung
- **Anmerkungen Digitalisierungsteam**

Dieses Dokument wird hauptsächlich vom Fachbereich erstellt.

---

### 5.2 Feinkonzept & Abnahmekriterien
**Ziel:** Detaillierte Beschreibung des Prozesses und Definition der Abnahmekriterien.

**Inhalte:**
- Detailprozess
- **Domain-Impact-Analyse**
- Betroffene Systeme
- Schnittstellen
- Make-or-Buy Entscheidung
- Infrastruktur-Anforderungen
- Aufwandsschätzung
- Abnahmekriterien
- **Fachliche Testfälle**
- **Anmerkungen Digitalisierungsteam**

Dieses Dokument wird gemeinsam von Fachbereich und IT erstellt.

---

### 5.3 Technische Dokumentation (Repository)
**Ziel:** Dokumentation der technischen Umsetzung.

**Inhalte:**
- Systemarchitektur
- Datenflüsse
- Schnittstellen
- Datenmodelle
- Deployment
- Konfiguration
- Logging / Monitoring
- Repository Struktur
- Links zu Pull Requests
- Technische Tests
- Known Issues
- Betriebskonzept

Dieses Dokument wird von der IT / Entwicklung gepflegt und im Repository versioniert.

---

### 5.4 Test- und Freigabedokument
**Ziel:** Dokumentation der Tests und Freigabe für den Produktivbetrieb.

**Inhalte:**
- Testprotokolle
- Testergebnisse
- Abnahme Fachbereich
- Abnahme IT
- Freigabe Produktivsystem
- Installationsdatum
- Version
- Verantwortliche
- Unterschriften / Freigaben

Dieses Dokument dient als Nachweis für Abnahme und Produktivsetzung. Dieses Dokument wird gemeinsam von Fachbereich und IT erstellt.

---

### 5.5 Benutzerdokumentation
**Ziel:** Dokumentation für Endanwender.

**Inhalte:**
- Prozessbeschreibung
- Schritt-für-Schritt Anleitung
- Screenshots
- Rollen und Berechtigungen
- Fehlerfälle
- FAQ
- Ansprechpartner

Dieses Dokument dient als Anwenderhandbuch. Dieses Dokument wird von den Fachabteilungen erstellt.

---

## 6. Lebenszyklus der Dokumente

| Projektphase | Dokument |
|---------------|-----------|
| Prozessidee | Lastenheft |
| Konzept | Feinkonzept |
| Umsetzung | Technische Dokumentation |
| Test | Test- und Freigabedokument |
| Go-Live | Test- und Freigabedokument |
| Betrieb | Benutzerdokumentation |
| Betrieb | Technische Dokumentation |
| Änderungen | Feinkonzept + Technische Dokumentation |

---

## 7. Versionierung
- Jedes Dokument muss eine Versionsnummer enthalten.
- Änderungen müssen in der Änderungshistorie dokumentiert werden.
- Technische Dokumentation wird über Git versioniert.
- Produktivsetzungen müssen einer Version zugeordnet sein.

---

## 8. Verantwortlichkeiten

| Dokument                   | Verantwortlich   |     |
| -------------------------- | ---------------- | --- |
| Lastenheft                 | Fachbereich      |     |
| Feinkonzept                | Fachbereich      |     |
| Technische Dokumentation   | IT               |     |
| Test- und Freigabedokument | Fachbereich      |     |
| Benutzerdokumentation      | Fachbereich      |     |

---

## 9. Ziel der Dokument-Governance
Ziel dieser Dokumentstruktur ist:
- Standardisierung der Projektdokumentation
- Nachvollziehbarkeit von Entscheidungen
- Strukturierte Zusammenarbeit zwischen Fachbereich und IT
- Übergabe an Betrieb und Support
- Dokumentation für Audits und Qualitätssicherung
- Langfristige Wissenssicherung