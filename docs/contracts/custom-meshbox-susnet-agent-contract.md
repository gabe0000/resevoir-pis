# Custom MeshBox-Susnet Agent Contract (Public-Safe)

## Topics
- Request: `susnet/agent/query`
- Lifecycle responses: `susnet/agent/ack`, `susnet/agent/progress`, `susnet/agent/reply`
- Optional error path: `susnet/agent/error`

## Request Envelope Example
```json
{
  "request_id": "mesh-<ts>-<id>",
  "session_id": "sess-<id>",
  "text": "user query with RF output constraints",
  "sender": {
    "node_id": "!xxxxxxxx",
    "shortname": "NODE",
    "longname": "Node Name"
  },
  "channel_index": 0,
  "channel_fingerprint": "<channel-fingerprint>",
  "channel_name": "<channel-name>",
  "origin": "meshtastic",
  "created_ts": 0,
  "expires_ts": 0,
  "trace": {
    "edge_host": "<edge-host>",
    "control_host": "<control-host>",
    "version": "<bridge-version>"
  },
  "max_output_chars": 520,
  "rf_max_chunks": 5,
  "rf_chunk_chars": 110
}
```

## Response Envelope Example
```json
{
  "request_id": "mesh-<ts>-<id>",
  "session_id": "sess-<id>",
  "sender": {
    "node_id": "!xxxxxxxx",
    "shortname": "NODE",
    "longname": "Node Name"
  },
  "channel_index": 0,
  "channel_fingerprint": "<channel-fingerprint>",
  "channel_name": "<channel-name>",
  "origin": "meshtastic",
  "created_ts": 0,
  "expires_ts": 0,
  "trace": {
    "edge_host": "<edge-host>",
    "control_host": "<control-host>",
    "version": "<bridge-version>"
  },
  "status": "accepted",
  "stage": "queued|started|still_working|completed|canceled|failed",
  "text": "string",
  "chunk_index": 1,
  "chunk_count": 1,
  "ts": 0
}
```

## JSON Schema (Request)
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "required": ["request_id", "session_id", "sender", "text"],
  "properties": {
    "request_id": {"type": "string", "minLength": 1},
    "session_id": {"type": "string", "minLength": 1},
    "sender": {
      "type": "object",
      "required": ["node_id"],
      "properties": {
        "node_id": {"type": "string", "minLength": 1},
        "shortname": {"type": ["string", "null"]},
        "longname": {"type": ["string", "null"]}
      },
      "additionalProperties": true
    },
    "text": {"type": "string", "minLength": 1},
    "channel_index": {"type": "integer"},
    "channel_fingerprint": {"type": ["string", "null"]},
    "channel_name": {"type": ["string", "null"]},
    "origin": {"type": "string"},
    "created_ts": {"type": "integer"},
    "expires_ts": {"type": "integer"},
    "ts": {"type": "integer"},
    "trace": {
      "type": "object",
      "properties": {
        "edge_host": {"type": "string"},
        "control_host": {"type": "string"},
        "version": {"type": "string"}
      },
      "additionalProperties": true
    },
    "max_output_chars": {"type": "integer"},
    "rf_max_chunks": {"type": "integer"},
    "rf_chunk_chars": {"type": "integer"}
  },
  "additionalProperties": true
}
```

## Validation Rules
- Payload must be a JSON object.
- Required keys must be present and non-empty.
- Malformed payloads enter error path with correlation when possible.
- Channel index is transport metadata and not an authorization key.
