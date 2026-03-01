# Resevoir Comms HQ Layout

Canonical data root:
- `/data/Resevoir-Comms-HQ`

Top-level structure:
- `Library/`
- `Offices/`
- `Desks/`
- `Governance/`
- `Streams/`

## Responsibilities

`Library/`:
- shared, durable knowledge and operational artifacts
- large rolling corpora (for example, curated stream books)
- cross-agent reference material that can be reused safely

`Offices/`:
- agent-owned working areas and policy-scoped resources
- files and state needed by one agent runtime or one service domain
- may expose selected read-only views into shared library resources

`Desks/`:
- fast-access, short-horizon material used for immediate interaction
- compact context windows, active notes, and currently prioritized tasks
- rebuilt/refreshed more frequently than office/library assets

`Governance/`:
- retention policies, cap thresholds, and runbook pointers
- audit-ready documentation references and lifecycle policy notes

`Streams/`:
- curated event streams and bounded raw capture buffers
- records used for diagnostics, summaries, and periodic journal extraction

## Public-safe notes
- This page documents conceptual and filesystem layout only.
- Credentials, host access details, and sensitive operator instructions are intentionally excluded.
