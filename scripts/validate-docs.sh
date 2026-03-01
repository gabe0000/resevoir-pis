#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

required=(
  docs/JOURNAL.md
  docs/LOGBOOK.md
  docs/CHANGELOG.md
  docs/DOCS_CONTRACT.md
  docs/owners-manual/README.md
  docs/owners-manual/10-governance.md
  docs/architecture/system-map.md
  docs/architecture/container-runtime-and-gates.md
  docs/architecture/permission-gates-overview.md
  docs/architecture/cross-host-component-map.md
  docs/architecture/resevoir-comms-hq-layout.md
  docs/architecture/office-library-desk.md
  docs/architecture/surfaces/stock-meshtastic.md
  docs/architecture/surfaces/edge-bridge-mr-pink.md
  docs/architecture/surfaces/control-runtime-joe-openclaw.md
  docs/architecture/surfaces/permission-gates.md
  docs/contracts/mqtt-agent-contract.md
  docs/contracts/stock-meshtastic-mqtt-contract.md
  docs/contracts/custom-meshbox-susnet-agent-contract.md
  docs/contracts/channel-identity-contract.md
  docs/contracts/become-an-expert-contract.md
  docs/runbooks/library-memory-management.md
  docs/PUBLIC_SANITIZATION_POLICY.md
  docs/PUBLIC_DOCS_MAP.md
  docs/papers/2026-02-system-state-and-llm-agent-phase2.md
  docs/incidents/RP-20260227-002-mr-pink-joe-stabilization.md
  docs/agents/joe-cabot.md
  docs/agents/mr-pink.md
  docs/refactors/README.md
  docs/refactors/templates/refactor-entry.md
  docs/refactors/templates/restabilization-log.md
  docs/refactors/RF-20260228-001-agent-path-stability/01-context-and-goals.md
  docs/refactors/RF-20260228-001-agent-path-stability/02-design-and-changes.md
  docs/refactors/RF-20260228-001-agent-path-stability/03-debugging-and-restabilization.md
  docs/refactors/RF-20260228-001-agent-path-stability/04-verification-and-known-risks.md
  docs/refactors/RF-20260301-002-resevoir-comms-hq-office-library-desk/01-context-and-goals.md
  docs/refactors/RF-20260301-002-resevoir-comms-hq-office-library-desk/02-design-and-changes.md
  docs/refactors/RF-20260301-002-resevoir-comms-hq-office-library-desk/03-debugging-and-restabilization.md
  docs/refactors/RF-20260301-002-resevoir-comms-hq-office-library-desk/04-verification-and-known-risks.md
)

for f in "${required[@]}"; do
  [[ -f "$f" ]] || { echo "missing: $f"; exit 1; }
done

required_refactor_files=(
  01-context-and-goals.md
  02-design-and-changes.md
  03-debugging-and-restabilization.md
  04-verification-and-known-risks.md
)

refactor_dirs=()
while IFS= read -r d; do
  refactor_dirs+=("$d")
done < <(find docs/refactors -mindepth 1 -maxdepth 1 -type d ! -name templates | sort)

[[ ${#refactor_dirs[@]} -gt 0 ]] || { echo "missing: docs/refactors/<refactor-id> directories"; exit 1; }

for d in "${refactor_dirs[@]}"; do
  for rf in "${required_refactor_files[@]}"; do
    [[ -f "$d/$rf" ]] || { echo "missing: $d/$rf"; exit 1; }
  done
done

hq_refactor="docs/refactors/RF-20260301-002-resevoir-comms-hq-office-library-desk"
grep -qi "Phase A: Baseline" "$hq_refactor/01-context-and-goals.md" || { echo "missing baseline marker in $hq_refactor"; exit 1; }
grep -qi "Phase D: Final Verified State" "$hq_refactor/04-verification-and-known-risks.md" || { echo "missing final-state marker in $hq_refactor"; exit 1; }

grep -qi "private-first" docs/DOCS_CONTRACT.md || { echo "missing private-first model"; exit 1; }
grep -q "PR-only gated" docs/DOCS_CONTRACT.md || { echo "missing publish flow rule"; exit 1; }
grep -q "docs/refactors" docs/DOCS_CONTRACT.md || { echo "missing refactor governance rule"; exit 1; }
grep -q "name plus key fingerprint" docs/contracts/channel-identity-contract.md || { echo "missing channel identity rule"; exit 1; }
grep -q 'Do not use `channel_index` as an authorization selector' docs/contracts/channel-identity-contract.md || { echo "missing explicit channel-index anti-pattern"; exit 1; }
grep -qi "become_an_expert" docs/contracts/become-an-expert-contract.md || { echo "missing become_an_expert contract"; exit 1; }
grep -qi "PR ordering" docs/owners-manual/10-governance.md || { echo "missing private->public PR ordering"; exit 1; }
grep -qi "semi-stable baseline" docs/refactors/RF-20260228-001-agent-path-stability/01-context-and-goals.md || { echo "missing baseline marker in initial refactor"; exit 1; }

grep -q "RF-20260301-002-resevoir-comms-hq-office-library-desk" docs/PUBLIC_DOCS_MAP.md || { echo "missing map rows for RF-20260301-002"; exit 1; }
grep -q "docs/contracts/become-an-expert-contract.md" docs/PUBLIC_DOCS_MAP.md || { echo "missing map row for become-an-expert contract"; exit 1; }
grep -q "docs/architecture/resevoir-comms-hq-layout.md" docs/PUBLIC_DOCS_MAP.md || { echo "missing map row for HQ layout"; exit 1; }

# Security scan across markdown content, excluding policy/map docs that intentionally describe patterns.
md_files=()
while IFS= read -r f; do
  md_files+=("$f")
done < <(
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
run_scan "api key literal" 'api[_-]?key[[:space:]]*[:=]'
run_scan "private key block" 'BEGIN[[:space:]]+(RSA[[:space:]]+|EC[[:space:]]+|OPENSSH[[:space:]]+)?PRIVATE[[:space:]]+KEY'
run_scan "secret path" '/home/[A-Za-z0-9._/-]*\.secrets'

if [[ "$fail" -ne 0 ]]; then
  exit 1
fi

echo "validate-docs.sh: OK"
