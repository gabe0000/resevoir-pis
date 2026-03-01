# JOURNAL

## RP-20260222-001
- Date/Time: 2026-02-22 07:20 EST
- Context: Wave 1 bootstrap for Reservoir Pi(s) multi-agent program.
- Decision: Establish canonical documentation authority in `resevoir-pis`.
- Implementation:
  - Added layered docs system and governance precedence.
  - Defined `Joe Cabot` as control-plane authority and `Mr. Pink` as RF edge persona.
  - Defined channel identity matching by name + credential fingerprint (not index).
  - Defined RF output budget rule: max 5 chunks, summary+rephrase overflow fallback.
- Failure(s) / Incident(s): None in repository scaffolding.
- Verification:
  - `scripts/validate-docs.sh` passes in canonical repo.
- Open Risks / Follow-ups:
  - Cross-repo sync depends on private repo auth for `meshbox-privat` push.

## RP-20260222-002
- Date/Time: 2026-02-22 18:30 EST
- Context: Susnet storage expansion and control-plane lightweight runtime stabilization.
- Decision:
  - Expand susnet root to 100GiB.
  - Add dedicated 100GiB `/data` partition for future data/log placement.
  - Keep migration/remap deferred while activating Joe Cabot lightweight runtime.
- Implementation:
  - Repartitioned `/dev/mmcblk0` (msdos): `p2=100GiB`, `p3=100GiB`, remainder unallocated.
  - Mounted `/data` via fstab UUID and created canonical skeleton directories.
  - Activated `joe-cabot-lite` systemd service consuming edge MQTT events.
  - Confirmed query/reply path via MQTT and RF-budgeted responses.
  - Aligned OpenClaw exposure using host port remap + Tailscale TCP serve endpoint continuity.
- Failure(s) / Incident(s):
  - Initial package fetch timeout from `piwheels`.
  - Stuck docker build process for lightweight helper image.
  - OpenClaw host-port bind conflict after reboot due Tailscale serve mapping.
- Verification:
  - `/` and `/data` capacities validated post-reboot.
  - Joe Cabot service active and subscribed to required topics.
  - Direct query/reply test succeeded from SSH terminal.
  - OpenClaw reachable at `susnet:18789`.
- Open Risks / Follow-ups:
  - Move heavy raw/log retention to `/data` paths in a later migration wave.
  - Add hardened retry/backoff wrappers for intermittent package-download timeouts.


## RP-20260222-003
- Date/Time: 2026-02-22 19:05 EST
- Context: Edge conversational behavior on dedicated Meshtastic channel did not match operator expectation.
- Decision: Route dedicated-channel free chat from Mr. Pink to Joe Cabot over MQTT query/reply, while retaining allowlist action gates.
- Implementation:
  - MeshBox bridge updated to relay dedicated non-action chat (`susnet/agent/query` -> `susnet/agent/reply`).
  - Added request correlation + timeout fallback behavior in bridge router.
  - Susnet Joe Cabot runtime expanded for conversational prompts with bounded local fallback output.
  - Policy routing updated to reply to sender node directly for both dedicated and non-dedicated policy responses.
- Failure(s) / Incident(s):
  - Initial patch shell quoting failures.
  - Local-model path may exceed timeout budget in some runs, so fallback remains necessary.
- Verification:
  - Bridge logs confirmed subscription to `susnet/agent/reply`.
  - MQTT query/reply tests returned conversational and utility responses.
  - Existing traffic summary intent remained functional.
- Open Risks / Follow-ups:
  - Tune timeout and model latency behavior after live RF validation.
  - Add explicit metrics for upstream chat timeout rate.

## RP-20260227-001
- Date/Time: 2026-02-27 09:20 EST
- Context: Governance expansion to support private-first canonical docs with public-safe projection.
- Decision:
  - Split MQTT docs into stock Meshtastic contract and custom agent contract.
  - Add explicit public sanitization policy and private-to-public docs map.
  - Enforce PR-gated validation with leak scanning.
- Implementation:
  - Added architecture system map and permission-gate overview docs.
  - Added stock/custom contract files with JSON schema examples.
  - Added policy/map files, CI workflow, and weekly drift issue template.
  - Hardened docs validator with security scans.
- Failure(s) / Incident(s): None.
- Verification:
  - `scripts/validate-docs.sh` passes.
- Open Risks / Follow-ups:
  - Maintain weekly drift checks and tighten scan patterns as new leak classes appear.

## RP-20260227-002
- Date/Time: 2026-02-27 15:35 EST
- Context: Mr. Pink <-> Joe round-trip behavior showed intermittent relay failure, ordering issues, and ambiguity between stock path transport metadata and permission identity.
- Decision:
  - Stabilize runtime behavior first, then document the exact working state and Phase 2 LLM/agent integration path.
  - Preserve stock compatibility while keeping custom agent contract explicit.
- Implementation:
  - Enforced channel-identity-first authorization rule (name + fingerprint) and documented index as metadata only.
  - Fixed callback lock contention path affecting downstream relay progression.
  - Added single-relay guard and outbound FIFO sequencing in edge relay logic.
  - Enforced inter-chunk pacing for multi-chunk responses.
  - Added and then removed temporary user-facing status texts after stabilization validation.
  - Added public incident record and comprehensive technical paper for Phase 2 planning.
- Failure(s) / Incident(s):
  - High operational friction from overlapping async pathways and mixed transport signals.
  - Relay intermittency appeared as transport instability but included callback state-flow faults.
  - Timing-sensitive issues were difficult to reproduce in single-shot synthetic tests.
- Verification:
  - Observed query lifecycle: `query -> ack -> progress -> reply -> completed`.
  - Confirmed final relay chunk order and minimum spacing behavior.
  - Confirmed status-debug text removal in steady-state production behavior.
  - Confirmed docs validation pass.
- Open Risks / Follow-ups:
  - Integrate full LLM + agent runtime behind existing contract without breaking gates.
  - Expand chaos and replay testing for DLQ/orphan and cancellation branches.
  - Add richer machine-readable error taxonomy for agent-runtime failures.

## RP-20260228-001
- Date/Time: 2026-02-28 20:05 UTC
- Context: Baseline-now governance refactor to standardize deep refactor records and post-debug stabilization logs across private and public documentation surfaces.
- Decision:
  - Add a mandatory `docs/refactors/<refactor-id>/` bundle model.
  - Split public architecture docs into explicit surfaces (stock Meshtastic, edge bridge, control runtime, permission gates).
  - Add cross-host isolation map so readers can isolate subsystems while preserving end-to-end context.
  - Extend validator gates to fail on missing refactor artifacts and missing anti-pattern protections.
- Implementation:
  - Added `docs/refactors` README, templates, and first refactor record `RF-20260228-001-agent-path-stability`.
  - Added `docs/architecture/cross-host-component-map.md` and surface docs under `docs/architecture/surfaces/`.
  - Updated governance and docs contract to require refactor + restabilization entries as Definition of Done.
  - Updated `PUBLIC_DOCS_MAP.md` and sanitization policy to include refactor/surface projection rules.
  - Upgraded docs validator to enforce required refactor files and additional leakage checks.
- Failure(s) / Incident(s):
  - Automation identity did not have read access to private source tree paths on control host, so private repo sync requires owner-executed follow-through or access adjustment.
- Verification:
  - New required docs paths created and linked.
  - Validator updated to enforce new structure and policy checks.
- Open Risks / Follow-ups:
  - Complete equivalent private repo refactor-tree updates and link resulting private PR IDs into public projection PR notes.
  - Replace high-frequency polling chain with event-driven delivery to reduce periodic burst load.

### 2026-02-28 21:10 UTC Addendum
- Applied first runtime tuning pass on Susnet control side:
  - core API now coalesces concurrent Meshtastic cache misses and reuses pooled HTTP connections.
  - dashboard poll cadence for key Meshtastic views was reduced.
- Observed call-rate reduction in short verification window on core-api -> meshtastic module path.

## RP-20260301-002
- Date/Time: 2026-03-01 15:30 UTC
- Context: Public projection needed to catch up with private HQ-era architecture and governance updates.
- Decision:
  - Publish an explicit Resevoir Comms HQ model with Office/Library/Desk boundaries.
  - Add a public-safe become-an-expert contract and Library memory runbook.
  - Enforce mapping and phase-marker checks in docs validation.
- Implementation:
  - Added `docs/architecture/resevoir-comms-hq-layout.md`.
  - Added `docs/architecture/office-library-desk.md`.
  - Added `docs/contracts/become-an-expert-contract.md`.
  - Added `docs/runbooks/library-memory-management.md`.
  - Added refactor bundle `RF-20260301-002-resevoir-comms-hq-office-library-desk/*`.
  - Updated `docs/PUBLIC_DOCS_MAP.md` rows for new private->public mappings.
  - Updated `scripts/validate-docs.sh` with new required files and phase checks.
- Failure(s) / Incident(s): None during documentation update wave.
- Verification:
  - Public docs validator passes after updates.
- Open Risks / Follow-ups:
  - Maintain strict private-first sync so public projection remains current after each runtime refactor.
