# MQTT Agent Contract

## 1) Edge to Control Events
- `meshbox/agent/events/rx`
- `meshbox/agent/events/policy`
- `meshbox/agent/events/health`
- `meshbox/agent/events/nodes`

## 2) Control Lifecycle Topics
- `susnet/agent/query`
- `susnet/agent/reply`
- `susnet/agent/ack`
- `susnet/agent/progress`
- `susnet/agent/control`
- `susnet/agent/error`
- `susnet/agent/dlq`

## 3) Existing Edge Bridge Topics Compatibility
- `meshbox/meshtastic/#`

## Canonical Envelope Minimum
- `request_id` required
- `session_id` required
- `sender.node_id`
- `sender.shortname`
- `sender.longname`
- `channel_index`
- `origin`
- `created_ts`
- `expires_ts`
- `trace.edge_host`
- `trace.control_host`
- `trace.version`

## Query Payload Example
```json
{
  "request_id": "mesh-1771953887-a5139b",
  "session_id": "sess-a1b2c3d4",
  "sender": {
    "node_id": "!9e77f1a0",
    "shortname": "GETB",
    "longname": "GETB"
  },
  "channel_index": 1,
  "origin": "meshtastic",
  "created_ts": 1771953887,
  "expires_ts": 1771954012,
  "trace": {
    "edge_host": "meshbox",
    "control_host": "susnet",
    "version": "mr-pink-refactor-v1"
  },
  "text": "what is 2+2"
}
```

## Progress Stages
- `queued`
- `started`
- `still_working`
- `completed`
- `cancel_requested`
- `canceled`

## Behavior Constraints
- Mr Pink is the only Meshtastic-facing persona.
- Joe is back office only over MQTT lifecycle topics.
- Replies must obey RF chunk budget policy max 5 chunks.
- Broad requests must refuse with rephrase guidance.
- Timeout classes are explicit and observable:
  - no ack by 7s -> unreachable
  - acked but no final by 30s -> busy timeout
