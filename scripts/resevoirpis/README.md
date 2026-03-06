# ResevoirPis Command

`ResevoirPis` switches between host states:

1. `normal`
2. `resevoir`

## Commands

- `ResevoirPis help`
- `ResevoirPis list`
- `ResevoirPis up --confirm RESEVOIRPIS`
- `ResevoirPis down --confirm RESEVOIRPIS`

## Notes

- `up` performs RAK flash/config-restore on MeshBox before service bring-up.
- Protected services are never managed by this command.
- Tailscale is always out of scope.

## Config

`~/.config/resevoir-pis/hosts.env`

Required keys:

- `SSH_USER`
- `SUSNET_HOST`
- `MESHBOX_HOST`

## In-depth docs

- https://github.com/gabe0000/resevoir-pis/blob/main/docs/runbooks/resevoirpis-operations.md
