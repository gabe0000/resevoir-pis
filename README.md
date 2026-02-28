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

## Meet The Main Agents

### Joe Cabot
Joe is the control-side authority.

You can think of Joe as the one with the office.
He handles the higher-level decisions and longer-path processing.
He is where the system escalates requests when deeper handling is needed.

### Mr. Pink
Mr. Pink works the front desk for Joe.

He sits closer to the live messaging edge, handles intake, applies rules, and keeps things moving.
When a request needs Joe, Mr. Pink relays it and then returns the result.

Mr. Pink also has personality in this project: he likes to chat, and he is a Meshtastic nerd. He studies Meshtastic behavior, protobuf/message flow patterns, and related docs, which makes him useful for practical Meshtastic conversations.

## Joe's Office and Mr. Pink's Front Desk
This project uses those ideas as architecture metaphors:
- **Front desk (Mr. Pink):** receives traffic, validates context, routes correctly, keeps responses orderly.
- **Office (Joe):** processes deeper questions and returns structured outputs.

This structure helps keep the system stable because each part has a focused role.

## How A Typical Request Moves
At a high level:
1. A message enters from the edge conversation path.
2. Mr. Pink receives it and checks policy gates.
3. If it is simple, Mr. Pink may handle it directly.
4. If it needs deeper handling, Mr. Pink escalates to Joe.
5. Joe returns results.
6. Mr. Pink relays back to the user in a bounded, readable format.

## Why This Matters
A lot of agent projects become hard to operate because everything is mixed together.

Reservoir Pi(s) separates concerns on purpose:
- messaging and intake at the edge,
- deeper processing in control,
- documented permission gates between them,
- clear contracts for what each path is allowed to do.

That makes onboarding easier and debugging less chaotic.

## Safety and Permission Philosophy
This project documents and enforces permission gates as first-class design elements.

Key principle:
- authorization must be based on stable identity signals,
- not fragile transport artifacts.

In practice, that means channel identity rules are explicit, and the team treats channel-index-based authorization logic as a known expensive failure pattern to avoid.

## What This Public Repository Is For
Use this repo to:
- understand the architecture and agent roles,
- learn the message contracts,
- follow refactors and stabilization history,
- bootstrap other agents/tools (notebooks, audio scripts, summaries, etc.) from clean documentation.

## What This Public Repository Is Not For
This is not an operations secrets repo.

It does not include:
- passwords,
- tokens,
- private host addresses,
- direct privileged access instructions,
- exploit-enabling details.

## Documentation You Probably Want First
- `docs/owners-manual/README.md`
- `docs/architecture/system-map.md`
- `docs/architecture/cross-host-component-map.md`
- `docs/architecture/surfaces/edge-bridge-mr-pink.md`
- `docs/architecture/surfaces/control-runtime-joe-openclaw.md`
- `docs/contracts/stock-meshtastic-mqtt-contract.md`
- `docs/contracts/custom-meshbox-susnet-agent-contract.md`
- `docs/refactors/README.md`

## Current Direction
The current direction is to keep transport contracts stable while improving agent depth and reliability.

That means:
- preserve stock-compatible behavior where required,
- evolve custom agent behavior behind documented contracts,
- keep refactor logs and restabilization steps explicit,
- keep the public docs clear enough for non-specialists while still useful to engineers.

If you are new: start with the Owner's Manual and System Map, then read the agent surface docs for Mr. Pink and Joe.
