# Permission Gates Overview (Public-Safe)

## Gate Sequence
1. Broker authentication gate: service accounts must authenticate before session establishment.
2. ACL gate: authenticated clients are constrained to approved topics.
3. Identity gate at edge: actionable intents require dedicated channel identity (`name + key fingerprint`) and allowlisted sender.
4. Schema gate at control runtime: custom query envelopes must pass JSON validation.
5. RF budget gate at edge: replies are constrained to chunk budget and safe fallback behavior.

## Responsibility Matrix
| Gate | Enforced By | Inputs | Deny Outcome |
| --- | --- | --- | --- |
| Broker auth | Mosquitto brokers | username/password or configured auth backend | session refused |
| Topic ACL | Broker ACLs | client identity + topic | publish/subscribe denied |
| Channel identity | Edge policy runtime | channel metadata + sender | actionable request rejected |
| Envelope schema | Control runtime | JSON payload | error response path |
| RF budget | Edge relay runtime | reply text/chunk metadata | summarized/refused output |

## Notes
- Gate logic is documented publicly at policy level only.
- Secret values and detailed operational internals remain private.
- Channel index may appear as transport metadata but must not be used for authorization decisions.
- Operationally expensive mistake: treating channel index as stable identity can create ghost-channel publishes and false denies.
