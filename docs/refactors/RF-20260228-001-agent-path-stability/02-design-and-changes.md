# RF-20260228-001 Design And Changes

## Design Choice
Use a surface-based documentation split with cross-host mapping, rather than host-only or timeline-only organization.

## Changes Implemented In Public Projection
1. Added `docs/refactors` governance tree with templates and required file structure.
2. Added first full refactor bundle for this stabilization wave.
3. Added architecture surface docs:
   - stock Meshtastic,
   - edge bridge Mr. Pink,
   - control runtime Joe OpenClaw,
   - permission gates.
4. Added `docs/architecture/cross-host-component-map.md` for host isolation clarity.
5. Updated governance, owner manual, map, and sanitization policy to require refactor + restabilization records.
6. Updated `PUBLIC_DOCS_MAP.md` for new surface and refactor projection mapping.
7. Extended validator expectations for required refactor files and architecture docs.

## Contract Position
- Stock Meshtastic contract unchanged.
- Custom `susnet/agent/*` contract unchanged.
- Channel index remains transport metadata only; never authorization identity.
