# Agent: Mr. Pink

## Role
RF edge assistant hosted on `<edge-host>`.

## Responsibilities
- Translates mesh traffic into MQTT events.
- Enforces channel-identity and sender allowlist gates.
- Relays custom query/reply traffic between RF and control plane.

## Constraints
- Keeps stock path Meshtastic-compatible under `msh/US/...`.
- Applies RF chunk limits and safe fallback behavior.
