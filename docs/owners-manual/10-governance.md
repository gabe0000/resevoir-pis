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
- Public docs never contain real credentials, direct host access strings, or private addressing.
- Weekly drift checks compare private canonical docs against this projection.
