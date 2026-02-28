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
3. Create or update refactor bundle under `docs/refactors/<refactor-id>/`.
4. Include restabilization chronology after debugging in `03-debugging-and-restabilization.md`.
5. Include verification and residual-risk summary in `04-verification-and-known-risks.md`.
6. Update `docs/PUBLIC_DOCS_MAP.md` if source/target mappings change.
7. Append detailed entry to `docs/JOURNAL.md`.
8. Add concise `docs/LOGBOOK.md` and `docs/CHANGELOG.md` entries when user-visible.
9. Run `scripts/validate-docs.sh`.

## Definition Of Done Rule
Infra, config, auth, topic, routing, and gate changes are incomplete until the required refactor docs and validation updates are included.

## Precedence
1. Canonical state (`docs/owners-manual/README.md`)
2. Architecture and contract docs
3. Refactor bundles and verification records
4. Sanitization policy and docs map
5. Journal narrative
6. Logbook/changelog summaries

## Sensitivity Policy
- Public-safe docs only.
- Secrets, exact keys, passwords, tokens, private host addressing, usernames tied to access, and exploit-enabling details are prohibited.
