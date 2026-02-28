# Cross-Host Component Map (Public-Safe)

## Purpose
Provide a host-isolated view so readers can understand the system as two cooperating surfaces without losing end-to-end context.

## Host Ownership Matrix
| Component | Runtime Host Class | Owner Repo | Primary Input | Primary Output | Gate Responsibility |
| --- | --- | --- | --- | --- | --- |
| Stock Meshtastic broker path | edge host | `meshbox-privat` | `msh/US/...` ingress | normalized stock events | transport/stock compatibility |
| Edge bridge (Mr. Pink) | edge host | `meshbox-privat` | stock events + policy inputs | `susnet/agent/query` + stock replies | channel identity and sender policy gate |
| Control broker custom path | control host | `susnet` | `susnet/agent/*` topic lifecycle | agent lifecycle transport | broker auth and ACL gate |
| Control runtime (Joe + OpenClaw/Ollama) | control host | `susnet` | `susnet/agent/query` envelope | `ack/progress/reply/error` | schema and execution policy gate |
| Public docs projection | docs host (public git) | `resevoir-pis` | private canonical docs | sanitized architecture/contracts | sanitization and governance gate |

## Contract Boundaries
1. Stock path contract remains Meshtastic-compatible.
2. Custom path contract remains JSON envelope on `susnet/agent/*`.
3. Authorization identity uses channel name plus key fingerprint.
4. Channel index remains transport diagnostics metadata only.

## Reading Order
1. [Surface: Stock Meshtastic](surfaces/stock-meshtastic.md)
2. [Surface: Edge Bridge Mr. Pink](surfaces/edge-bridge-mr-pink.md)
3. [Surface: Control Runtime Joe OpenClaw](surfaces/control-runtime-joe-openclaw.md)
4. [Surface: Permission Gates](surfaces/permission-gates.md)
