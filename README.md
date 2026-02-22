# Reservoir Pi(s)

Reservoir Pi(s) is the multi-agent RF + automation platform for your Tailscale-connected Raspberry Pi fleet.

This repository is the canonical architecture and governance authority for the program.

## Why This Exists
You are building a distributed agent system with clear role separation:
- Joe Cabot on susnet as the control-plane boss (policy + orchestration)
- Mr. Pink on meshbox as the RF edge (Meshtastic-aware, execution-gated)
- additional agents added over time without collapsing governance or safety

The goal is practical field utility, not heavy compute on edge hardware.

## Program Goals
1. Keep mesh edge behavior reliable on constrained hardware.
2. Centralize decision authority on stronger infrastructure.
3. Enforce strict command safety gates (channel identity + allowlist).
4. Keep all docs continuously synchronized and auditable.
5. Support multiple interaction paths: Meshtastic, web/API, and future channels.

## System Architecture

### Control Plane: susnet (Joe Cabot)
Primary responsibilities:
- global policy decisions
- command authorization
- workflow orchestration
- direct operator web/API interface
- centralized audit trail and observability

### Edge Plane: meshbox (Mr. Pink)
Primary responsibilities:
- ingest all Meshtastic channels for awareness
- publish events/telemetry to control plane
- execute only policy-authorized actions
- enforce RF output constraints and safe fallbacks

### Transport
- MQTT over Tailscale is the primary inter-host messaging fabric.
- Existing meshbox/meshtastic/* topics remain during migration.

## Repository Roles
- resevoir-pis (this repo): canonical docs, contracts, governance, master journal
- susnet: control-plane runtime implementation and ops docs (public-safe)
- meshbox-privat: edge runtime implementation + sensitive private docs

## Command Safety Model

### Channel Gate
Actionable intents require dedicated channel identity match by:
- channel name
- key fingerprint/credentials identity

Not by channel index alone.

### Sender Gate
Actionable intents also require sender allowlist match.

### Read vs Execute
- Read/observe: all channels
- Execute: dedicated channel + allowlist only

## Naming and Response Rules
- Node references in user-facing replies are longname-first.
- Fallback: longname -> shortname -> node ID.

## RF Response Budget Policy
Hard requirement:
- max 5 chunks per RF response

If answer is too large:
- return compact summary only
- ask user to narrow the request

Example:
- There are 7 nodes online over RF. Ask for top 3 by activity.

## MQTT Contracts (Summary)

### Edge -> Control Plane
- meshbox/agent/events/rx
- meshbox/agent/events/policy
- meshbox/agent/events/health
- meshbox/agent/events/nodes

### Control Plane -> Edge
- meshbox/agent/cmd/reply
- meshbox/agent/cmd/action

### Envelope Minimum
- trace_id
- ts
- origin_host
- agent_id
- channel.name
- channel.fingerprint
- channel.index (advisory)
- sender.identity.{node_id,shortname,longname}
- receiver.identity.{node_id,shortname,longname} (when available)

See:
- docs/contracts/mqtt-agent-contract.md
- docs/contracts/channel-identity-contract.md

## Documentation Governance

### Precedence Order
1. docs/owners-manual/README.md canonical state
2. topical owner-manual and contract docs
3. docs/JOURNAL.md detailed narrative
4. docs/LOGBOOK.md and docs/CHANGELOG.md

### Change Completion Contract
Every meaningful change must include:
1. canonical state update
2. affected topical docs update
3. journal entry with canonical ID (RP-YYYYMMDD-###)
4. logbook/changelog updates when applicable
5. docs validation pass

### Sensitivity Policy
Public-safe repos:
- resevoir-pis
- susnet

Private-sensitive repo:
- meshbox-privat (keys, exact device IDs, private topology)

## Workflow for Contributors
1. Implement change in relevant runtime repo.
2. Update canonical docs/contracts in resevoir-pis.
3. Cross-link journal IDs in affected repos.
4. Run validation scripts.
5. Push codex/* branch and open PR.

## Branching and Commit Conventions
- Source-of-truth branch: master
- Working branch prefix: codex/
- Coordinated commits include footer:
  - Canonical-ID: RP-YYYYMMDD-###

## Validation
Run from repo root:

```bash
./scripts/validate-docs.sh
```

Expected:

```text
validate-docs.sh: OK
```

## Program Roadmap Snapshot
- Wave 1: docs/governance bootstrap (completed)
- Wave 2: control-plane and edge runtime cutover
- Wave 3: multi-agent expansion + deeper observability

## Operational Principle
When docs and implementation differ, canonical state in docs/owners-manual/README.md governs until reconciled.
