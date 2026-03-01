# Reservoir Pi(s)

Reservoir Pi(s) is a multi-device AI agent project built to bring practical AI conversations and workflows into radio-linked systems.

This repository is the public, safe-to-share guide for the project. It explains how everything fits together without exposing secrets, private network details, or operational access info.

## The Big Idea (In Plain Language)
Think of this project as a small AI workplace spread across a few Raspberry Pi systems:
- one side listens and talks to the outside world,
- another side handles deeper thinking and backend processing,
- both sides coordinate through clear rules so conversations stay reliable.

The goal is not just "make a bot reply."
The goal is to build an agent system that is understandable, debuggable, and safe enough to hand off to other humans or other agents.

## Why The Reservoir Dogs Names?
The agent naming style is inspired by Quentin Tarantino's *Reservoir Dogs*.

That naming choice is intentional. It helps people remember roles quickly:
- instead of abstract service names,
- you get personified roles with clear responsibility boundaries.

For new users, this tends to make architecture easier to understand because each agent feels like a "job role" inside a small team.

## The HQ Model: Resevoir Comms HQ
In the current era of this project, the operating model is called **Resevoir Comms HQ**.

You can picture it as one building with three main areas:
- **Library** for long-lived shared knowledge,
- **Offices** for role-specific work and permission boundaries,
- **Desks** for fast, active context used during live conversations.

This model exists to keep things reliable under real-world conditions.
When systems get busy or unstable, this separation makes it much easier to see where a problem actually lives.

## Meet The Main Agents

### Joe Cabot
Joe is the control-side authority.

You can think of Joe as the one with the office.
He handles deeper processing and escalated tasks when policy gates allow it.

### Mr. Pink
Mr. Pink works the front desk for Joe.

He sits close to the live messaging edge, handles intake, applies rules, and keeps message flow orderly.
When a request needs Joe, Mr. Pink relays it and later returns the result.

Mr. Pink also has a project-specific personality: he likes to chat, and he is a Meshtastic nerd.
He studies Meshtastic behavior, protobuf/message flow patterns, and documentation so he can help with practical mesh operations and troubleshooting.

## Joe's Office and Mr. Pink's Front Desk
This project uses those ideas as architecture metaphors:
- **Front desk (Mr. Pink):** receives traffic, validates context, routes correctly, keeps responses orderly.
- **Office (Joe):** handles deeper control-side work and returns structured outputs.

This role split helps keep the system stable because each part has a focused job.

## How A Typical Request Moves
At a high level:
1. A message enters from the edge conversation path.
2. Mr. Pink receives it and checks policy gates.
3. If it is simple and safe, Mr. Pink may handle it directly.
4. If it needs deeper handling, Mr. Pink escalates to Joe.
5. Joe returns results.
6. Mr. Pink relays back in bounded, readable chunks.

## Permission Philosophy
Permission gates are a first-class design element.

Core rule:
- authorization must be based on stable identity signals,
- not fragile transport metadata.

In plain terms, channel identity is validated by channel name + key fingerprint, and sender identity gates are explicit.
The project treats channel-index-based authorization logic as a known expensive failure mode to avoid.

## Become-An-Expert Workflow
The system is adding a controlled workflow called `become_an_expert`.

This allows an authorized operator to tell a specific agent to ingest selected resource links and build a bounded expertise set.
The flow is interactive, gated, and storage-limited so it stays manageable over time.

Public docs describe this behavior in contract form without exposing private operational details.

## Why This Repo Exists
Use this repository to:
- understand the architecture and agent roles,
- follow refactors and stabilization history,
- learn contract boundaries,
- bootstrap other tools/agents from safe, structured documentation.

## What This Repo Never Publishes
This repository does not publish:
- credentials,
- secrets/tokens,
- private host access details,
- direct privileged operator instructions,
- exploit-enabling implementation details.

## Start Here
- `docs/owners-manual/README.md`
- `docs/architecture/system-map.md`
- `docs/architecture/cross-host-component-map.md`
- `docs/architecture/resevoir-comms-hq-layout.md`
- `docs/architecture/office-library-desk.md`
- `docs/contracts/stock-meshtastic-mqtt-contract.md`
- `docs/contracts/custom-meshbox-susnet-agent-contract.md`
- `docs/contracts/become-an-expert-contract.md`
- `docs/refactors/README.md`

## Current Direction
The project is focused on stable transport contracts and stronger agent behavior.
That means:
- keep stock-compatible behavior where required,
- evolve custom behavior behind explicit contracts,
- capture refactors and restabilization steps in detail,
- keep public docs readable for non-specialists and still useful to engineers.
