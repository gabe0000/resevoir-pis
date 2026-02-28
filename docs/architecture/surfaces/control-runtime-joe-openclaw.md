# Surface: Control Runtime (Joe + OpenClaw/Ollama)

## Scope
This surface covers control-host request execution and lifecycle emission under existing topic contracts.

## Responsibilities
- Consume `susnet/agent/query` envelopes.
- Emit `ack`, `progress`, `reply`, `error`, and `dlq` lifecycle events.
- Enforce envelope validation and policy state checks.
- Run upstream execution engines (OpenClaw and/or local model fallback) without breaking external contract shape.

## Runtime Modes
1. Full runtime path: OpenClaw-enabled execution when policy and rollout allow.
2. Local-model path: direct local model response when selected.
3. Controlled fallback: bounded response path when upstream is paused or unavailable.

## Invariants
- No contract-breaking topic rename or payload key removal.
- No authorization decision based on channel index.
- Keep RF budget fields and chunking metadata aligned with edge relay requirements.

## Related Docs
- [Custom MeshBox-Susnet Agent Contract](../../contracts/custom-meshbox-susnet-agent-contract.md)
- [Permission Gate Surface](permission-gates.md)
- [Cross-Host Component Map](../cross-host-component-map.md)
