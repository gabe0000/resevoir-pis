# MQTT Agent Contract

## 1) Edge -> Control Plane
- `meshbox/agent/events/rx`
- `meshbox/agent/events/policy`
- `meshbox/agent/events/health`
- `meshbox/agent/events/nodes`

## 2) Operator Query/Reply
- `susnet/agent/query`
- `susnet/agent/reply`

## 3) Existing Edge Bridge Topics (Compatibility)
- `meshbox/meshtastic/#`

## Envelope Minimum (event payloads)
- `ts`
- `sender.identity.node_id`
- `sender.identity.shortname`
- `sender.identity.longname`
- `receiver.identity.*` when available

## Query Payload (recommended)
```json
{
  "request_id": "string",
  "sender": "!9e77f1a0",
  "text": "traffic load summary please"
}
```

## Reply Payload (current)
```json
{
  "ts": 1771802293,
  "agent": "Joe Cabot",
  "sender": "!9e77f1a0",
  "request_id": "1771802292-32387",
  "text": "Traffic load: 5m=8 msgs (ch0:8); 1h=9 msgs (ch0:9).",
  "chunk_index": 1,
  "chunk_count": 1
}
```

## Behavior Constraints
- Replies must obey RF chunk budget policy (max 5 chunks).
- Broad requests must refuse with rephrase guidance.
