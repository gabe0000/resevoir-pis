# Container Runtime and Permission Gates (Public-Safe)

## Why This Exists
This doc explains the real runtime control points for the Mr. Pink <-> Joe flow and where requests can fail or be denied.

## Runtime Containers and Services
| Surface | Runtime Type | Primary Role | Notes |
| --- | --- | --- | --- |
| Edge broker | container | stock Meshtastic MQTT ingest + custom topic relay | public docs describe policy, not credentials |
| Edge bridge (Mr. Pink) | container | policy gate, escalation routing, RF and stock reply emission | handles chunking, pacing, sender context |
| Control broker | container/service | custom topic transport for Joe lifecycle | enforces auth and ACL gates |
| Control runtime (Joe) | container/service | query processing and lifecycle emit (`ack/progress/reply/error`) | no public secrets or host internals documented |

## Flow Summary
1. Message arrives through stock Meshtastic MQTT path.
2. Edge bridge validates policy gates.
3. If escalation is required, edge publishes `susnet/agent/query`.
4. Joe publishes lifecycle events on `susnet/agent/ack|progress|reply|error`.
5. Edge relays final response back over stock path (and RF where available).

## Permission Gates by Stage
| Stage | Gate | Decision Input | Deny Behavior |
| --- | --- | --- | --- |
| broker session | broker auth | service identity + auth material | session refused |
| topic usage | ACL | client identity + topic | publish/sub denied |
| actionable command | edge policy | channel identity + sender allowlist | command denied, safe reply |
| escalation payload | Joe schema gate | request envelope validity | DLQ/error path |
| outbound response | edge resource gate | chunk budget + pacing + routing context | summarize/refuse/defer |

## Failure Modes We Actually Hit
- Channel identity drift between topic metadata and packet metadata.
- Cross-thread message handling races creating out-of-order relay behavior.
- Lock contention in callback path blocking downstream relay steps.
- Duplicate relay emissions when synchronous and asynchronous paths both attempted completion.

## Stabilization Controls
- Dedicated-channel authorization based on channel name plus fingerprint (not index).
- FIFO send sequencing for outbound reply emissions.
- Minimum inter-chunk delay enforced for multi-chunk replies.
- Single-relay guard per request correlation id.
- Callback deadlock fix by avoiding re-entrant state updates while locks are held.

## Public Safety Boundaries
- No concrete addresses, usernames, passwords, tokens, or key material in this doc.
- No copy-paste access commands with real infrastructure identifiers.
