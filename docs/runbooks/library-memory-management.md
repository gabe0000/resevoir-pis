# Library Memory Management Runbook

## Scope
Public-safe operational guidance for managing Library growth in `/data/Resevoir-Comms-HQ`.

## Capacity policy
- nominal Library target: 20GB
- raw stream ring target: 100MB
- threshold signals at 5GB, 10GB, 15GB, then every 500MB
- cap behavior: pause new ingest, alert operator, execute controlled intervention

## Intervention order
1. Confirm threshold/cap event source and timestamp.
2. Pause new ingest paths.
3. Validate current active jobs and preserve in-flight state.
4. Review staged artifacts and remove safe-to-regenerate intermediates first.
5. Re-check index/catalog integrity.
6. Resume ingest only after validation passes.

## Validation checklist
- catalogs still resolve referenced artifacts
- active agent desks can refresh from office/library without missing files
- no duplicate terminal events from resumed jobs
- threshold metrics return below cap guard

## Notes
- Do not publish credentials, private host access instructions, or secret file locations in this runbook.
- Keep this runbook aligned with private canonical docs after each refactor wave.
