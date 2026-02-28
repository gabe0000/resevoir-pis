# Refactor Records

## Purpose
This directory is the mandatory refactor ledger for architecture, runtime, and policy changes.

Each refactor must record:
1. context and goals,
2. design and changes,
3. debugging and restabilization chronology,
4. verification evidence and residual risk.

## Required Structure
- `docs/refactors/templates/refactor-entry.md`
- `docs/refactors/templates/restabilization-log.md`
- `docs/refactors/<refactor-id>/01-context-and-goals.md`
- `docs/refactors/<refactor-id>/02-design-and-changes.md`
- `docs/refactors/<refactor-id>/03-debugging-and-restabilization.md`
- `docs/refactors/<refactor-id>/04-verification-and-known-risks.md`

## Process Rule
- Open refactor folder at the beginning of a refactor.
- Append restabilization entries as debugging occurs.
- Close only after verification and known-risk summary are documented.

## Naming
Use `RF-YYYYMMDD-###-short-slug`.
