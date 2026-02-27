#!/usr/bin/env bash
set -euo pipefail

required=(
  docs/JOURNAL.md
  docs/LOGBOOK.md
  docs/CHANGELOG.md
  docs/DOCS_CONTRACT.md
  docs/owners-manual/README.md
  docs/owners-manual/10-governance.md
  docs/architecture/system-map.md
  docs/architecture/permission-gates-overview.md
  docs/contracts/mqtt-agent-contract.md
  docs/contracts/stock-meshtastic-mqtt-contract.md
  docs/contracts/custom-meshbox-susnet-agent-contract.md
  docs/contracts/channel-identity-contract.md
  docs/PUBLIC_SANITIZATION_POLICY.md
  docs/PUBLIC_DOCS_MAP.md
  docs/agents/joe-cabot.md
  docs/agents/mr-pink.md
)

for f in "${required[@]}"; do
  [[ -f "$f" ]] || { echo "missing: $f"; exit 1; }
done

grep -qi "private-first" docs/DOCS_CONTRACT.md || { echo "missing private-first model"; exit 1; }
grep -q "PR-only gated" docs/DOCS_CONTRACT.md || { echo "missing publish flow rule"; exit 1; }
grep -q "name plus key fingerprint" docs/contracts/channel-identity-contract.md || { echo "missing channel identity rule"; exit 1; }

# Security scan across markdown content, excluding policy/map docs that intentionally describe patterns.
mapfile -t md_files < <(
  {
    echo "README.md"
    find docs -type f -name '*.md' \
      ! -path 'docs/PUBLIC_SANITIZATION_POLICY.md' \
      ! -path 'docs/PUBLIC_DOCS_MAP.md'
  } | sort -u
)

fail=0
run_scan() {
  local label="$1"
  local pattern="$2"
  local hits
  hits=$(grep -nE "$pattern" "${md_files[@]}" || true)
  if [[ -n "$hits" ]]; then
    echo "security scan failed: $label"
    echo "$hits"
    fail=1
  fi
}

run_scan "ipv4" '(^|[^0-9])([0-9]{1,3}\.){3}[0-9]{1,3}([^0-9]|$)'
run_scan "ipv6" '([0-9a-fA-F]{1,4}:){2,7}[0-9a-fA-F]{1,4}'
run_scan "tailscale-like ipv4" '(^|[^0-9])100\.([0-9]{1,3}\.){2}[0-9]{1,3}([^0-9]|$)'
run_scan "concrete ssh user@host" 'ssh[[:space:]]+[A-Za-z0-9._-]+@[A-Za-z0-9._-]+'
run_scan "password literal" 'password[[:space:]]*[:=]'
run_scan "token literal" 'token[[:space:]]*[:=]'
run_scan "private key block" 'BEGIN[[:space:]]+(RSA[[:space:]]+|EC[[:space:]]+|OPENSSH[[:space:]]+)?PRIVATE[[:space:]]+KEY'
run_scan "secret path" '/home/[A-Za-z0-9._/-]*\.secrets'

if [[ "$fail" -ne 0 ]]; then
  exit 1
fi

echo "validate-docs.sh: OK"
