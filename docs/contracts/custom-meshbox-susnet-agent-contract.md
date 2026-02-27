# Custom MeshBox-Susnet Agent Contract (Public-Safe)

## Topics
- Request: `susnet/agent/query`
- Lifecycle responses: `susnet/agent/ack`, `susnet/agent/progress`, `susnet/agent/reply`
- Optional error path: `susnet/agent/error`

## Request Envelope Example
```json
{
  "request_id": "string",
  "sender": "string",
  "text": "string",
  "ts": 0,
  "context": {
    "source": "meshbox",
    "channel": "string"
  }
}
```

## Response Envelope Example
```json
{
  "request_id": "string",
  "status": "ack|progress|completed|error",
  "agent": "Joe Cabot",
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
  "required": ["request_id", "sender", "text"],
  "properties": {
    "request_id": {"type": "string", "minLength": 1},
    "sender": {"type": "string", "minLength": 1},
    "text": {"type": "string", "minLength": 1},
    "ts": {"type": "integer"},
    "context": {
      "type": "object",
      "properties": {
        "source": {"type": "string"},
        "channel": {"type": "string"}
      },
      "additionalProperties": true
    }
  },
  "additionalProperties": true
}
```

## Validation Rules
- Payload must be a JSON object.
- Required keys must be present and non-empty.
- Malformed payloads enter error path with correlation when possible.
