#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_SRC="$SRC_DIR/ResevoirPis"
README_SRC="$SRC_DIR/README.md"
HOSTS_SRC="$SRC_DIR/hosts.env.example"

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/resevoir-pis" "$HOME/.config/resevoir-pis"
install -m 0755 "$SCRIPT_SRC" "$HOME/.local/bin/ResevoirPis"
install -m 0644 "$README_SRC" "$HOME/.local/share/resevoir-pis/README.md"

if [[ ! -f "$HOME/.config/resevoir-pis/hosts.env" ]]; then
  install -m 0600 "$HOSTS_SRC" "$HOME/.config/resevoir-pis/hosts.env"
fi

cat <<EOF
Installed user-space command:
  $HOME/.local/bin/ResevoirPis

Config file:
  $HOME/.config/resevoir-pis/hosts.env

Optional system install (requires local sudo):
  sudo install -m 0755 "$SCRIPT_SRC" /usr/local/bin/ResevoirPis
  sudo mkdir -p /usr/local/share/resevoir-pis
  sudo install -m 0644 "$README_SRC" /usr/local/share/resevoir-pis/README.md
EOF
