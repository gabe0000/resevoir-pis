# Docs Contract

## Purpose
This repository is the canonical source for Reservoir Pi(s) architecture, policies, and cross-repo documentation governance.

## Required Updates Per Meaningful Change
1. Update canonical state in `docs/owners-manual/README.md`.
2. Update affected topical docs/contracts.
3. Append detailed entry to `docs/JOURNAL.md`.
4. Add concise `docs/LOGBOOK.md` and `docs/CHANGELOG.md` entry when user-visible.
5. Run `scripts/validate-docs.sh`.

## Precedence
1. Canonical state (`docs/owners-manual/README.md`)
2. Topical owner manual and contract docs
3. Journal narrative
4. Logbook/changelog summaries

## Sensitivity Policy
- Public-safe docs only in this repo.
- Secrets, exact PSKs, device serials, and private addressing live only in `meshbox-privat`.
