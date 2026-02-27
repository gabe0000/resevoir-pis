# Docs Contract

## Purpose
This repository is the canonical public-safe architecture and governance projection for Reservoir Pi(s).

## Canonical Model
- Private-first source of truth: `susnet` and `meshbox-privat` technical docs.
- Public projection: sanitized docs in `resevoir-pis`.
- Publication model: PR-only gated merge; no direct auto-publish path.

## Required Updates Per Meaningful Change
1. Update canonical state in `docs/owners-manual/README.md`.
2. Update affected architecture and contract docs.
3. Update `docs/PUBLIC_DOCS_MAP.md` if source/target mappings change.
4. Append detailed entry to `docs/JOURNAL.md`.
5. Add concise `docs/LOGBOOK.md` and `docs/CHANGELOG.md` entry when user-visible.
6. Run `scripts/validate-docs.sh`.

## Precedence
1. Canonical state (`docs/owners-manual/README.md`)
2. Architecture and contract docs
3. Sanitization policy and docs map
4. Journal narrative
5. Logbook/changelog summaries

## Sensitivity Policy
- Public-safe docs only.
- Secrets, exact keys, passwords, tokens, private host addressing, and exploit-enabling details are prohibited.
