# Surface: Stock Meshtastic MQTT

## Scope
This surface documents the stock-compatible transport behavior used for Meshtastic MQTT interoperability.

## In Scope
- Topic family: `msh/US/...`
- Stock payload structure and semantics
- RF plus MQTT dual transport expectations where enabled
- Transport metadata usage for diagnostics

## Out Of Scope
- Custom JSON agent envelope semantics
- OpenClaw or tool execution behavior

## Rules
1. Maintain stock topic and payload compatibility.
2. Do not embed custom control semantics into stock payloads.
3. Do not use channel index as authorization identity.
4. Keep stock path separate from custom `susnet/agent/*` lifecycle path.

## Related Docs
- [Stock Meshtastic MQTT Contract](../../contracts/stock-meshtastic-mqtt-contract.md)
- [Cross-Host Component Map](../cross-host-component-map.md)
