# Reservoir Pi(s)

Reservoir Pi(s) is the canonical architecture and governance repository for a multi-agent Raspberry Pi comms fleet.

Primary mission:
- keep RF-edge behavior safe and lightweight
- keep control-plane decisions centralized
- document every meaningful change with traceable journal records

## Live Role Map (Current)
- `Joe Cabot` (control-plane): `susnet` (`susnet`)
- `Mr. Pink` (RF edge): `meshbox` (`meshbox`)

## Current Runtime Pattern
- Edge (`meshbox`) reads all Meshtastic channels, enforces policy gates, and publishes MQTT events.
- Control (`susnet`) consumes edge events and provides lightweight query responses.
- Tailscale is the required transport boundary between hosts.

## Core Safety Rules
1. Action gate: dedicated channel + allowlisted sender.
2. Channel 0 remains unchanged for legacy/global mesh behavior.
3. RF response budget: max 5 chunks; broad requests must refuse + rephrase.
4. Node naming in replies: longname -> shortname -> node_id.

## Key MQTT Contracts
### Edge -> Control
- `meshbox/agent/events/rx`
- `meshbox/agent/events/policy`
- `meshbox/agent/events/health`
- `meshbox/agent/events/nodes`

### Operator Query/Reply
- `susnet/agent/query`
- `susnet/agent/reply`

### Existing Edge Bridge Topics (still active)
- `meshbox/meshtastic/#`

## Repository Responsibilities
- `resevoir-pis`: canonical architecture, contracts, governance, cross-repo journaling IDs.
- `susnet`: control-plane implementation and operations docs.
- `meshbox-privat`: RF edge implementation and private-sensitive details.

## Start Here
- `docs/QUICKSTART.md`
- `docs/owners-manual/README.md`
- `docs/contracts/mqtt-agent-contract.md`
- `docs/contracts/channel-identity-contract.md`

## Documentation Rule
When implementation and docs diverge, canonical state in `docs/owners-manual/README.md` governs until reconciled.
