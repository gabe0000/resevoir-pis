# Reservoir Pi(s)

Reservoir Pi(s) is the canonical architecture and governance repository for the multi-agent Raspberry Pi comms stack.

Primary mission:
- keep RF-edge behavior safe and lightweight
- keep control-plane decisions centralized
- document every meaningful change with traceable journal records

## Live Role Map (Current)
- `Joe Cabot` control-plane on `susnet` (`susnet`)
- `Mr. Pink` RF edge on `meshbox` (`meshbox`)

## Current Runtime Pattern
- Edge `meshbox` reads all Meshtastic channels, enforces policy gates, and publishes MQTT events.
- Control `susnet` consumes edge events and answers escalated requests.
- Mr Pink is the only Meshtastic-facing persona.
- Joe is back-office only for escalations.

## Core Safety Rules
1. Action gate: dedicated channel plus allowlisted sender.
2. Channel `0` remains unchanged.
3. RF response budget: max 5 chunks; broad requests refuse plus rephrase.
4. Node naming in replies: longname then shortname then node_id.
5. Timeout classes are explicit: unreachable if no ack in 7s, busy if acked but no final in 30s.

## Key MQTT Contracts
### Edge to Control events
- `meshbox/agent/events/rx`
- `meshbox/agent/events/policy`
- `meshbox/agent/events/health`
- `meshbox/agent/events/nodes`

### Control lifecycle topics
- `susnet/agent/query`
- `susnet/agent/reply`
- `susnet/agent/ack`
- `susnet/agent/progress`
- `susnet/agent/control`
- `susnet/agent/error`
- `susnet/agent/dlq`

### Existing edge bridge topics still active
- `meshbox/meshtastic/#`

## Repository Responsibilities
- `resevoir-pis`: canonical architecture, contracts, governance, cross-repo journal IDs.
- `susnet`: control-plane implementation and operations docs.
- `meshbox-privat`: RF edge implementation and private-sensitive details.

## Start Here
- `docs/QUICKSTART.md`
- `docs/owners-manual/README.md`
- `docs/contracts/mqtt-agent-contract.md`
- `docs/contracts/channel-identity-contract.md`

## Documentation Rule
If implementation and docs diverge, canonical state in `docs/owners-manual/README.md` governs until reconciled.
