# Reservoir Pi(s) Owner's Manual

## Canonical State
- Program: Reservoir Pi(s)
- Last validated date (UTC): 2026-02-24 14:12
- Control-plane authority: `Joe Cabot` on `susnet` (`susnet`)
- RF edge agent: `Mr. Pink` on `meshbox` (`meshbox`)
- Inter-host transport: MQTT over Tailscale
- Action gate model: dedicated channel identity plus allowlist
- Dedicated channel behavior: index `1` in current edge policy; channel index `0` unchanged
- RF response budget: max 5 chunks, broad requests must refuse plus rephrase
- Node naming policy: longname then shortname then node_id
- Front-desk timing defaults:
  - ack timeout `7s`
  - response timeout `30s`
  - wait extension `30s` max `2`
  - wait prompt auto-close `45s`
- Active operator query lifecycle topics:
  - `susnet/agent/query`
  - `susnet/agent/reply`
  - `susnet/agent/ack`
  - `susnet/agent/progress`
  - `susnet/agent/control`
  - `susnet/agent/error`
  - `susnet/agent/dlq`
- Edge event topics consumed by control:
  - `meshbox/agent/events/rx`
  - `meshbox/agent/events/policy`
  - `meshbox/agent/events/health`
  - `meshbox/agent/events/nodes`
- Repo roles:
  - Canonical architecture/governance: `resevoir-pis`
  - Control-plane implementation: `susnet`
  - Edge/private-sensitive implementation: `meshbox-privat`
- Canonical event IDs in use:
  - `RP-20260222-001`
  - `RP-20260222-002`
  - `RP-20260222-003`
  - `RP-20260224-001`
- Validator: `scripts/validate-docs.sh v1`

## Links
- Susnet repo: `https://github.com/gabe0000/susnet`
- MeshBox private repo: `https://github.com/gabe0000/meshbox-privat`

## Definition of Done
- [ ] Change implemented in runtime repo(s)
- [ ] Contracts/docs updated in canonical repo
- [ ] Journal entry appended with canonical ID
- [ ] Logbook/changelog updated
- [ ] Validation script passes
