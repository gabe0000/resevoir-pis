# Become-An-Expert Contract

Intent: `become_an_expert`

Purpose:
- allow an authorized operator to instruct an agent to ingest and stage domain resources as a bounded expertise set

## Gate requirements
- sender must be allowlisted for this intent class
- channel identity validation must pass (name + key fingerprint)
- channel index must never be used as an authorization selector

## Interaction flow
1. Agent asks: "Which agent needs to become an expert?"
2. Agent asks: "Paste a resource link here or type `end` if you are finished."
3. Operator may send multiple links.
4. Operator sends `end`.
5. Runtime stages ingestion and emits lifecycle events.

## Budget and lifecycle defaults
- allocate up to 500MB per agent per expertise set
- apply cooldown policy between major refresh runs
- support scheduled refresh and on-demand refresh

## Event interfaces
- `expert_ingest_started`
- `expert_ingest_staged`
- `expert_ingest_promoted`
- `expert_ingest_failed`
- `library_threshold_crossed`
- `library_cap_reached_paused`
- `library_ingest_resumed`

## Non-breaking compatibility
- stock Meshtastic MQTT contract remains unchanged
- existing `susnet/agent/*` lifecycle contract remains unchanged
