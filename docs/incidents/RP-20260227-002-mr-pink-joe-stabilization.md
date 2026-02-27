# RP-20260227-002: Mr. Pink <-> Joe Flow Stabilization (Public-Safe)

Date: 2026-02-27  
Severity: medium-high operational instability  
Status: stabilized

## 1. Problem Statement
The end-to-end assistant flow was intermittently failing despite partial signs of health:
- native Meshtastic ACK could succeed while Joe relay failed
- lifecycle events were present but final response relay was inconsistent
- channel confusion and timing races produced non-deterministic operator experience

## 2. What Made This Hard
- Multiple overlapping transports (stock path + custom path) made symptoms ambiguous.
- Concurrency faults looked like transport failures.
- Some regressions only appeared in live timing windows, not isolated unit probes.
- Channel-index drift created expensive debugging loops when confused with channel identity.

## 3. Root Causes
1. Channel identity misuse risk:
   - index metadata was too easy to treat as identity source.
2. Callback deadlock risk:
   - backend state transitions could re-enter lock-sensitive paths.
3. Relay race conditions:
   - asynchronous and synchronous completion paths could both attempt final relay.
4. Outbound ordering race:
   - concurrent send attempts could leapfrog chunk or status emission order.

## 4. Corrective Actions
1. Enforced identity policy:
   - actionable gate anchored to channel name + fingerprint, not index.
2. Deadlock fix:
   - moved backend state updates outside lock-held section in callback path.
3. Duplicate suppression:
   - single-relay guard per `request_id`.
4. Outbound order hardening:
   - FIFO send sequencing in edge relay.
5. Human-operational pacing:
   - minimum inter-chunk delay for multi-chunk replies.
6. Temporary status transparency:
   - staged flow notices used during diagnosis, later disabled for clean production behavior.

## 5. Validation Evidence (Sanitized)
- Stock ingress observed on Meshtastic-compatible topic family.
- Query lifecycle observed:
  - `susnet/agent/query`
  - `susnet/agent/ack`
  - `susnet/agent/progress`
  - `susnet/agent/reply`
  - `susnet/agent/progress (completed)`
- Final relay observed in correct chunk order with enforced spacing.
- Status debug texts removed after stabilization confirmation.

## 6. Operator-Facing Lessons
- Never treat channel index as authorization identity.
- Confirm state-machine completion path before tuning UX timing.
- Add delays to match real RF cadence, not workstation cadence.
- Keep public docs synchronized with live policy behavior after each stabilization wave.

## 7. Remaining Risks
- End-to-end quality still depends on control runtime capability (lightweight vs full LLM stack).
- DLQ/orphan handling should remain monitored under heavy traffic.
- Additional replay/chaos tests are recommended before high-volume rollout.

## 8. Next Step
Proceed to Phase 2: integrate full LLM + agent stack behind existing custom contract and permission gates, with transport contracts preserved.
