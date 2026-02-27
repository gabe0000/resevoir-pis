# Stock Meshtastic MQTT Contract (Public-Safe)

## Intent
Mirror stock Meshtastic MQTT topic and payload architecture exactly on the stock path.

## Contract
- Topic root: `msh/US/...`.
- Payload semantics: unchanged Meshtastic-native structure.
- No custom orchestration envelope keys in stock topics.
- Stock and custom contracts are isolated by topic namespace.

## Interface Guarantees
- Stock-compatible consumers can subscribe without custom decoder assumptions.
- Bridge layers preserve payload compatibility across host boundaries.

## Validation Scenarios
- Stock publish/subscribe confirms continuity on `msh/US/...`.
- Unauthorized identity publish attempts outside allowed stock prefixes are denied.
