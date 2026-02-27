# Reservoir Pi(s) Owner's Manual

## Canonical State
- Program: Reservoir Pi(s)
- Last validated (UTC): 2026-02-27 14:20
- Control-plane authority: `Joe Cabot` on `<control-host>`
- RF edge agent: `Mr. Pink` on `<edge-host>`
- Inter-host transport: MQTT over private tailnet
- Action gate model: dedicated channel identity (`name + key fingerprint`) plus sender allowlist
- Stock MQTT path: strict Meshtastic compatibility under `msh/US/...`
- Custom MQTT path: JSON envelope lifecycle on `susnet/agent/query|ack|progress|reply`
- RF response budget: max 5 chunks, broad requests must refuse and ask for rephrase
- Node naming policy: longname then shortname then node_id fallback
- Repo roles:
  - Canonical public projection: `resevoir-pis`
  - Private control implementation: `susnet`
  - Private edge implementation: `meshbox-privat`
- Active canonical event IDs:
  - `RP-20260222-001`
  - `RP-20260222-002`
  - `RP-20260222-003`
  - `RP-20260227-001`
- Validator: `scripts/validate-docs.sh v2`

## Definition of Done
- [ ] Runtime/docs changes reconciled in private repos
- [ ] Public-safe projection updated in this repo
- [ ] Journal/logbook/changelog updated
- [ ] Validation script passes
