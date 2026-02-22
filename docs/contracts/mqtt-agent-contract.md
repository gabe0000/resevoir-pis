# MQTT Agent Contract

## Topics
### Edge -> Control Plane
- `meshbox/agent/events/rx`
- `meshbox/agent/events/policy`
- `meshbox/agent/events/health`
- `meshbox/agent/events/nodes`

### Control Plane -> Edge
- `meshbox/agent/cmd/reply`
- `meshbox/agent/cmd/action`

## Envelope Fields
- `trace_id`
- `ts`
- `origin_host`
- `agent_id`
- `channel.name`
- `channel.fingerprint`
- `channel.index` (advisory)
- `sender.identity.{node_id,shortname,longname}`
- `receiver.identity.{node_id,shortname,longname}` when available

## Compatibility
Existing `meshbox/meshtastic/*` topics remain during migration.
