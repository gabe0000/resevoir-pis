#!/usr/bin/env bash
set -euo pipefail

required=(
  docs/JOURNAL.md
  docs/LOGBOOK.md
  docs/CHANGELOG.md
  docs/DOCS_CONTRACT.md
  docs/owners-manual/README.md
  docs/owners-manual/10-governance.md
  docs/contracts/mqtt-agent-contract.md
  docs/contracts/channel-identity-contract.md
  docs/agents/joe-cabot.md
  docs/agents/mr-pink.md
)

for f in "${required[@]}"; do
  [[ -f "$f" ]] || { echo "missing: $f"; exit 1; }
done

grep -q "max 5 chunks" docs/owners-manual/README.md || { echo "missing RF budget in canonical state"; exit 1; }
grep -q "name + key fingerprint" docs/contracts/channel-identity-contract.md || { echo "missing channel identity rule"; exit 1; }

echo "validate-docs.sh: OK"
