# RF-20260228-001 Debugging And Restabilization

## Timeline Summary (Sanitized)
| UTC Window | Symptom | Scope |
| --- | --- | --- |
| 2026-02-27 to 2026-02-28 | intermittent relay stalls and out-of-order behavior | edge relay and lifecycle handoff |
| 2026-02-28 | periodic load spikes during active monitoring | dashboard poll chain |
| 2026-02-28 | message path confusion during policy checks | channel identity handling |

## Debugging Steps
1. Confirmed runtime health state of control and edge services.
2. Verified query lifecycle counters (`ack/progress/reply`) and timeout counters.
3. Isolated noisy polling path (`dashboard -> core API -> meshtastic module`).
4. Confirmed channel identity rule should be name plus key fingerprint, never index.
5. Re-validated fallback and upstream paths under current semi-stable behavior.
6. Applied poll-pressure reduction refactor on control side:
   - pooled and coalesced cache-miss handling in `core-api` Meshtastic read path
   - slower dashboard poll cadence for non-critical Meshtastic views.

## Stabilization Outcomes
- Lifecycle path operates in semi-stable state.
- Poll-induced pressure was reduced in the first runtime tuning pass.
- Primary remaining technical debt is full event-driven replacement for remaining polling-heavy views.
- Governance gap closed by making refactor and restabilization logging mandatory.

## Follow-Up Work
1. Replace remaining high-frequency poll paths with socket/hook-based updates where feasible.
2. Add per-surface observability acceptance thresholds to refactor closure criteria.
3. Continue hard enforcement of channel identity rule in docs and review checklists.

## Second Runtime Pass (Same Refactor Wave)
1. Traced another hotspot to node-snapshot handling in the Meshtastic module.
2. Removed unnecessary node-state write churn by only persisting node records when values actually change.
3. Switched `/nodes` reads to cached mode by default with opt-in refresh.
4. Added snapshot pacing (`MESH_NODE_SNAPSHOT_SECONDS`, default 15s) to reduce repeated full-node scans.
5. Confirmed this pass kept runtime contracts unchanged while lowering background churn.
