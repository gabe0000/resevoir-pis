# Channel Identity Contract

## Rule
Actionable command authorization is based on dedicated channel identity by name plus key fingerprint, not channel index.

## Required Match Conditions
- `channel.name` equals configured dedicated channel name
- `channel.fingerprint` equals configured dedicated key fingerprint
- sender is allowlisted for actionable intents

## Rationale
Channel indices can drift between devices and over time; identity matching reduces accidental policy bypass.

## Anti-Pattern (Do Not Use)
- Do not use `channel_index` as an authorization selector.
- Do not treat topic index and packet index mismatches as a permission decision source.
- Do treat index fields as transport metadata useful for diagnostics and routing telemetry only.

## Operational Warning
Treating channel index as authorization identity is an expensive recurring failure mode that causes ghost-channel behavior, dropped escalation, and recovery churn.
