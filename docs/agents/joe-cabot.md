# Agent: Joe Cabot

## Role
Control-plane assistant hosted on `<control-host>`.

## Inputs and Outputs
- Consumes edge events from `meshbox/agent/events/*`.
- Handles custom query lifecycle on `susnet/agent/query|ack|progress|reply`.
- Produces policy-safe responses for edge relay.

## Constraints
- Requires valid JSON envelope for custom query path.
- Must respect RF budget constraints defined by edge policy.
