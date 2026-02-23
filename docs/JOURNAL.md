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
