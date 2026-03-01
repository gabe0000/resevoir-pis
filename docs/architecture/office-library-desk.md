# Office-Library-Desk Model (Plain-English)

Think of the system as one building where each area has a clear job.

## The Library
The Library is where long-term shared knowledge lives.
It keeps bigger reference material that multiple agents can use, like curated activity records and technical references.

## The Office
Each agent has an Office.
An Office is where that agent keeps role-specific materials and guardrails.
This is where permissions matter most: what an agent can read, write, or trigger should follow policy.

## The Desk
The Desk is the quick-access surface.
It holds what an agent needs right now for a current conversation or immediate task.
If the Desk is clean and focused, responses are faster and more consistent.

## Why this helps
Without clear boundaries, agent systems become hard to maintain.
This model makes troubleshooting easier:
- if shared memory is wrong, look in Library workflows
- if one agent is acting oddly, inspect that agent Office rules
- if replies feel stale or confused, inspect Desk refresh behavior

## Who does what
- Mr. Pink: front-desk behavior for edge conversations, policy-aware intake, and practical mesh-facing responses.
- Joe: deeper control-side processing and escalated execution paths.

Both roles can reference shared material, but they should not blur permission boundaries.
