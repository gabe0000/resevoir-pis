# Reservoir Pi(s)

Reservoir Pi(s) is the public, sanitized architecture and governance repository for a multi-agent Raspberry Pi comms fleet.

Primary mission:
- explain component relationships and permission gates
- publish public-safe contracts that mirror private implementations
- maintain traceable documentation updates for downstream agents and content tooling

## Runtime Role Map (Sanitized)
- Control-plane assistant: `Joe Cabot` on `<control-host>`
- RF edge assistant: `Mr. Pink` on `<edge-host>`

## Current Runtime Pattern
- Edge reads Meshtastic channels, enforces policy gates, and publishes MQTT events.
- Control consumes edge events and produces query/reply outputs.
- Transport boundary between hosts is private tailnet plus broker authentication.

## Safety Rules
1. Action gate: dedicated channel identity plus sender allowlist.
2. Stock Meshtastic MQTT path remains contract-compatible.
3. Custom MeshBox-Susnet path uses JSON envelopes on `susnet/agent/*` topics.
4. RF response budget: max 5 chunks; broad requests refuse with rephrase guidance.

## Key Documentation
- `docs/owners-manual/README.md`
- `docs/architecture/system-map.md`
- `docs/architecture/container-runtime-and-gates.md`
- `docs/architecture/permission-gates-overview.md`
- `docs/contracts/stock-meshtastic-mqtt-contract.md`
- `docs/contracts/custom-meshbox-susnet-agent-contract.md`
- `docs/papers/2026-02-system-state-and-llm-agent-phase2.md`
- `docs/incidents/RP-20260227-002-mr-pink-joe-stabilization.md`
- `docs/PUBLIC_SANITIZATION_POLICY.md`
- `docs/PUBLIC_DOCS_MAP.md`

## Repository Responsibilities
- Public canonical architecture and contract projection.
- No secrets, credentials, private addresses, or direct infrastructure access instructions.
- PR-only gated publication flow.
