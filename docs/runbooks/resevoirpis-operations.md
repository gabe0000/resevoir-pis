# ResevoirPis Operations Runbook (Public-Safe)

## Purpose
`ResevoirPis` is a Mac-side operator command that toggles between two system states:

1. `normal`
2. `resevoir`

It applies a dual-state service/data switch model across Susnet and MeshBox with guardrails so protected services are never touched by this workflow.

## Command Surface

1. `ResevoirPis help`
2. `ResevoirPis list`
3. `ResevoirPis down --confirm RESEVOIRPIS`
4. `ResevoirPis up --confirm RESEVOIRPIS`

## Protected-Service Policy

`ResevoirPis` is designed to preserve protected services and fail if an operation would affect them.

Examples of protected classes:

1. Tailscale runtime.
2. Allstar and non-Reservoir Susnet core services.
3. MeshBox Portainer.

## Transition Model

### `down` (resevoir -> normal)
1. Preflight checks (host reachability, tailscale state, docker access).
2. Snapshot current `resevoir` state on each host.
3. Stop Reservoir-managed services only.
4. Restore latest `normal` bundle where available.
5. Verify protected services remained unchanged.
6. Mark active state as `normal`.

### `up` (normal -> resevoir)
1. Preflight checks.
2. Snapshot current `normal` state on each host.
3. Restore latest `resevoir` bundle where available.
4. On MeshBox, run RAK flash/config-restore flow using approved manifest policy.
5. Start managed services in defined order.
6. Verify managed services are healthy and protected services unchanged.
7. Mark active state as `resevoir`.

## Snapshot Bundle Shape

Each host/state bundle contains:

1. `manifest.json`
2. `managed-status.txt`
3. `protected-status.txt`
4. file bundle tarball (`files.tar.gz`) from allowlisted paths
5. managed-volume backups
6. `SHA256SUMS.txt`

## Flash Policy

1. `up` includes flash by default in this phase.
2. Firmware source/checksum/command are controlled by an approved manifest.
3. Flash fails closed if manifest data is incomplete or checksum validation fails.
4. Configuration is exported pre-flash and restored post-flash.

## Failure Handling

1. Snapshot failure aborts transition.
2. Restore failure triggers rollback attempt to pre-transition bundle.
3. Flash failure aborts startup before full service bring-up.
4. Confirmation token is required for mutating commands.

## Local Help Surface

The command help output includes:

1. local README path
2. in-depth public docs link

This runbook is intentionally public-safe and excludes sensitive host-access or credential details.
