# Surface: Permission Gates

## Gate Layers
1. Broker authentication gate.
2. Topic ACL gate.
3. Edge channel identity and sender gate.
4. Control runtime schema gate.
5. Outbound RF budget and pacing gate.

## Inputs Used By Gates
- Client identity.
- Topic identity.
- Channel name and key fingerprint.
- Sender allowlist.
- Contract-required envelope fields.
- Output budget constraints.

## Explicitly Not A Gate Input
- Channel index.

## Why This Rule Is Hard
Channel index drift causes expensive failures: ghost-channel behavior, dropped escalation, and unstable operator experience.

## Related Docs
- [Permission Gates Overview](../permission-gates-overview.md)
- [Channel Identity Contract](../../contracts/channel-identity-contract.md)
