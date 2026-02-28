# Governance

## Ownership
- Canonical public architecture authority: `resevoir-pis`.
- Private control runtime authority: `susnet`.
- Private RF edge runtime authority: `meshbox-privat`.

## Cross-Repo Precedence
1. Private implementation truth (`susnet`, `meshbox-privat`)
2. Sanitized projection in `resevoir-pis`
3. Journal/logbook/changelog summaries

## Sync Rules
- Meaningful runtime changes in private repos must map to a public-safe update in this repo.
- Meaningful refactors must include both design notes and post-debugging restabilization logs.
- Public docs never contain real credentials, direct host access strings, private addressing, or usernames tied to infrastructure access.
- Weekly drift checks compare private canonical docs against this projection.

## Refactor Workflow (Required)
1. Create `docs/refactors/<refactor-id>/` at refactor start.
2. Populate context and design docs before merge.
3. Append debugging chronology as stabilization work proceeds.
4. Close with verification evidence and known risks.

## PR Ordering
1. `susnet` private PR.
2. `meshbox-privat` private PR.
3. `resevoir-pis` public projection PR referencing private PR IDs/commits.

## Anti-Pattern Rule
Channel index must never be used for authorization decisions; identity uses channel name plus key fingerprint.
