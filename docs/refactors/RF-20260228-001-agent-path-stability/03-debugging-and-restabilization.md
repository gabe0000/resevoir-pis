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

## Stabilization Outcomes
- Lifecycle path operates in semi-stable state.
- Primary remaining technical debt is polling-induced burst load and the need for stronger event-driven updates.
- Governance gap closed by making refactor and restabilization logging mandatory.

## Follow-Up Work
1. Replace high-frequency poll paths with socket/hook-based updates where feasible.
2. Add per-surface observability acceptance thresholds to refactor closure criteria.
3. Continue hard enforcement of channel identity rule in docs and review checklists.
