# Public Sanitization Policy

## Objective
Ensure public docs remain safe for publication while still useful for onboarding, automation, and learning.

## Required Redactions
- Replace real IP addresses with placeholders such as `<control-ip>` or `<edge-ip>`.
- Replace concrete hostnames with placeholders such as `<control-host>` or `<edge-host>`.
- Remove usernames tied to infrastructure access.
- Remove passwords, tokens, key material, and secret-file paths.
- Remove copy/paste credential commands and direct privileged access instructions.
- Convert exploit-enabling implementation details into high-level controls.

## Refactor Log Specific Rules
- Refactor writeups and debugging chronology must use sanitized placeholders for hosts, identities, and access paths.
- Include root cause, decision rationale, and verification detail without publishing operational footholds.
- Do not include packet captures or payload excerpts that expose real addresses, credentials, or private path markers.

## Allowed Content
- Public-safe architecture diagrams.
- Sanitized topic contracts and schema examples.
- Policy-level gate descriptions.
- Non-sensitive operational checklists.
- Detailed sanitized refactor records and restabilization timelines.

## Enforcement
- `scripts/validate-docs.sh` performs security scans for address, access-string, and secret-like leakage.
- Failing scans block CI and PR merge until sanitized.
