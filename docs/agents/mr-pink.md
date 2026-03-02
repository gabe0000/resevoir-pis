# Mr. Pink: Edge Agent Architecture

## Abstract
Mr. Pink is a custom edge conversational agent in the Resevoir Pi(s) system. The implementation is event-driven, policy-gated, and transport-aware. It preserves stock Meshtastic message semantics on the stock path while isolating custom orchestration and escalation logic behind explicit contracts.

## System Context
Mr. Pink is designed as an edge-facing runtime in a split-host architecture:
- Edge-side services handle stock ingest/egress and policy-first routing.
- Control-side services provide lifecycle orchestration, state management, and optional deep execution surfaces.

This design avoids coupling core conversation reliability to any single backend execution engine.

## Functional Responsibilities
Mr. Pink performs the following functions:
- Ingest conversation traffic from the edge transport path.
- Validate request context using permission gates.
- Handle direct conversational traffic when policy and scope permit.
- Escalate requests to deeper execution layers only when required.
- Relay responses with RF-safe chunking, ordering, and pacing controls.

## Runtime and Containerization Model
Runtime decomposition is service-oriented:

1. Edge host runtime:
- Stock broker and bridge services for `msh/US/...` compatibility.
- Mr. Pink edge runtime for intake, gate enforcement, and reply relay.

2. Control host runtime:
- Custom agent gateway for lifecycle processing.
- Redis-backed state layer for inflight/session controls and dedupe.
- Optional model/tool execution surfaces for deeper task handling.

3. Contract-level lifecycle:
- `query -> ack -> progress -> reply -> error|completed`

This decomposition separates transport obligations from agent orchestration logic.

## Permission-Gate Semantics
Mr. Pink enforces layered authorization and policy checks:
- Channel identity gate.
- Sender allowlist and intent gate.
- Envelope/schema validation gate.
- Outbound resource and pacing gate.

Normative rule:
- Authorization decisions use channel identity semantics (for example, channel name plus fingerprint).
- Channel index is explicitly non-authoritative and treated as diagnostics/transport metadata only.

## OpenClaw Detachment and Escalation Boundaries
The current architecture intentionally detaches base Mr. Pink operation from OpenClaw dependency.

Operational effect:
- Core conversational operation remains available without OpenClaw.
- OpenClaw/Joe-style processing is an optional escalation path.
- Control-side degradation does not require edge conversation outage.

This is a reliability-first posture that keeps fallback behavior bounded and predictable.

## HQ / Office / Desk / Library Data Model
Mr. Pink is aligned to the Resevoir Comms HQ storage hierarchy:

1. HQ root (`/data/Resevoir-Comms-HQ`):
- Global root for shared runtime and governance assets.

2. Office (`/data/Resevoir-Comms-HQ/Offices/Mr-Pink`):
- Persistent agent-specific state, role policy, and operating notes.

3. Desk (`/data/Resevoir-Comms-HQ/Offices/Mr-Pink/Desk`):
- Small hot working set for low-latency runtime context.

4. Library (`/data/Resevoir-Comms-HQ/Library`):
- Shared long-horizon corpus (Meshtastic references, protobuf stream logs, curated summaries).

Reference resolution order:
1. Desk.
2. Office.
3. Library.

This ordering prioritizes deterministic response latency while retaining deep retrieval paths.

## Engineering Outcomes
The resulting agent profile is:
- Custom, not stock chatbot middleware.
- Contract-driven and observable.
- Resilient to backend escalation degradation.
- Compatible with stock Meshtastic transport requirements.

Future Joe/OpenClaw capability can be added as an escalation layer without breaking base edge behavior.
