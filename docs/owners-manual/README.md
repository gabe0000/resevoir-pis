# Reservoir Pi(s) Owner's Manual

## Canonical State
- Program: Reservoir Pi(s)
- Date: 2026-02-22
- Control-plane authority: `Joe Cabot` on `susnet`
- RF edge agent: `Mr. Pink` on `meshbox`
- Transport: MQTT over Tailscale
- Action gate: dedicated channel identity (name + key fingerprint) + allowlist
- RF response budget: max 5 chunks; overflow = compact summary + rephrase request
- Repo roles:
  - Canonical architecture and governance: `resevoir-pis`
  - Control-plane implementation (public-safe): `susnet`
  - Edge implementation (private-sensitive): `meshbox-privat`
- Canonical event id seed: `RP-20260222-001`
- Last validated: 2026-02-22
- Validator: `scripts/validate-docs.sh v1`

## Links
- Susnet repo: https://github.com/gabe0000/susnet
- MeshBox private repo: https://github.com/gabe0000/meshbox-privat

## Definition of Done
- [ ] Change implemented
- [ ] Contracts/docs updated
- [ ] Journal entry appended
- [ ] Logbook/changelog updated
- [ ] Validation script passes
