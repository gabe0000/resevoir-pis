# Channel Identity Contract

## Rule
Actionable command authorization is based on dedicated channel identity by name plus key fingerprint, not channel index.

## Required Match Conditions
- `channel.name` equals configured dedicated channel name
- `channel.fingerprint` equals configured dedicated key fingerprint
- sender is allowlisted for actionable intents

## Rationale
Channel indices can drift between devices and over time; identity matching reduces accidental policy bypass.
