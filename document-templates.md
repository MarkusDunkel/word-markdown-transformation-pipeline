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
This guideline defines the standards for documenting process automation projects.  
The objective is consistent, traceable, and maintainable documentation across the entire lifecycle of an automated process.

The documentation should:
- make decisions traceable
- document requirements
- document technical implementation
- document tests and approvals
- document operations and usage
- preserve knowledge long-term
- enable collaboration with external partners

---

## 2. Grundprinzipien der Dokumentation

The following core principles apply to all process automation projects:

1. The documentation must be assigned to a process ID.
2. Business-facing documents are maintained in Word.
3. Technical documentation is maintained in Markdown in the code repository.
4. Decisions must be documented.
5. Tests and approvals must be documented in a traceable way.
6. The documentation must still explain the process years later.
7. Documentation is part of the project and is not optional.

---

## 3. Dokumentstruktur eines Prozessautomatisierungsprojekts

Every process automation project consists of the following standard documents:

| Nr. | Dokument                       | Zweck                                      | Format                |
| --- | ------------------------------ | ------------------------------------------ | --------------------- |
| 1   | Lastenheft / Grobkonzept       | Business requirements and target definition | Word                  |
| 2   | Feinkonzept & Abnahmekriterien | Detailed concept and business tests         | Word                  |
| 3   | Technische Dokumentation       | Architecture, implementation, technical details | Markdown (Repository) |
| 4   | Test- und Freigabedokument     | Test results and production approval        | Word                  |
| 5   | Benutzerdokumentation          | Instructions for end users                  | Word                  |

Together, these documents form the complete documentation of an automated process.

---

## 4. Prozess-ID und Benennung der Dokumente

Each process receives a unique process ID.

### Beispiel Prozess-ID
YYYY-TT-nnnn-{Liefergegenstand}

YYYY... Year  
TT... Document type abbreviation  
nnn... Dummy delivery-item ID (placeholder)

Example:
2026-LH-0001-Arbeitszeiterfassung

Template default value:
YYYY-LH-nnnn-{Liefergegenstand}

### Benennung der Dokumente
All documents must be named according to the following schema:


| Dokument-Typ | Kürzel | File-Typ |  
| ---          | ---    | ---      |
| Lastenheft   | LH | .docx  |
| Pflichtenheft | PH | .docx |
| Technische_Dokumentation | TD | .md  |
| Test_und_Auslieferung | TA | .docx |
| Benutzerdokumentation | BD | .docx |

Example file names with dummy values:
- `YYYY-LH-nnnn-{Liefergegenstand}.docx`
- `YYYY-PH-nnnn-{Liefergegenstand}.docx`
- `YYYY-TD-nnnn-{Liefergegenstand}.md`
- `YYYY-TA-nnnn-{Liefergegenstand}.docx`
- `YYYY-BD-nnnn-{Liefergegenstand}.docx`

---

## 5. Beschreibung der einzelnen Dokumente

### 5.1 Lastenheft / Grobkonzept
**Ziel:** Description of the business requirements and the process goal.

**Inhalte:**
- Problem statement
- **Process goal**
- Business benefit
- **Requirements (Must / Should)**
- High-level process flow
- Assumptions
- Open points
- **Rough effort estimate**
- Project decision
- **Comments from the digitalization team**

This document is mainly created by the business department.

---

### 5.2 Feinkonzept & Abnahmekriterien
**Ziel:** Detailed description of the process and definition of acceptance criteria.

**Inhalte:**
- Detailed process
- **Domain impact analysis**
- Affected systems
- Interfaces
- Make-or-buy decision
- Infrastructure requirements
- Effort estimate
- Acceptance criteria
- **Business test cases**
- **Comments from the digitalization team**

This document is created jointly by the business department and IT.

---

### 5.3 Technische Dokumentation (Repository)
**Ziel:** Documentation of the technical implementation.

**Inhalte:**
- System architecture
- Data flows
- Interfaces
- Data models
- Deployment
- Configuration
- Logging / monitoring
- Repository structure
- Links to pull requests
- Technical tests
- Known issues
- Operations concept

This document is maintained by IT / engineering and versioned in the repository.

---

### 5.4 Test- und Freigabedokument
**Ziel:** Documentation of testing and approval for production operations.

**Inhalte:**
- Test logs
- Test results
- Business sign-off
- IT sign-off
- Production system approval
- Installation date
- Version
- Responsible persons
- Signatures / approvals

This document serves as evidence of acceptance and production rollout. This document is created jointly by the business department and IT.

---

### 5.5 Benutzerdokumentation
**Ziel:** Documentation for end users.

**Inhalte:**
- Process description
- Step-by-step guide
- Screenshots
- Roles and permissions
- Error cases
- FAQ
- Contacts

This document serves as a user manual. This document is created by the business departments.

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
- Each document must contain a version number.
- Changes must be documented in the change history.
- Technical documentation is versioned via Git.
- Production releases must be assigned to a version.

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
The goal of this document structure is:
- standardization of project documentation
- traceability of decisions
- structured collaboration between business department and IT
- handover to operations and support
- documentation for audits and quality assurance
- long-term knowledge retention
