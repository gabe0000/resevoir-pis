# Surface: Edge Bridge (Mr. Pink)

## Scope
This surface covers edge-side policy, relay, and response handling between stock transport and custom agent lifecycle.

## Responsibilities
- Parse stock ingress events.
- Apply channel identity and sender policy gates.
- Emit `susnet/agent/query` envelopes for eligible requests.
- Relay `ack/progress/reply/error` outcomes back to stock route.
- Enforce chunking, pacing, and duplicate-suppression safeguards.

## Reliability Controls
1. FIFO outbound reply ordering.
2. Minimum inter-chunk delay for multi-chunk responses.
3. Single terminal relay guard per request id.
4. Safe fallback response path when upstream runtime is unavailable.

## Anti-Pattern
Authorization by channel index is prohibited. Use channel name plus key fingerprint.

## Related Docs
- [Permission Gate Surface](permission-gates.md)
- [Custom MeshBox-Susnet Agent Contract](../../contracts/custom-meshbox-susnet-agent-contract.md)
- [Refactor Entry RF-20260228-001](../../refactors/RF-20260228-001-agent-path-stability/01-context-and-goals.md)
