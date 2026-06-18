# Tutu Travel Agent Skill

Shareable Codex/OpenClaw skill for travel search and trip-choice workflows over the Tutu MCP server.

## Why This Exists

Most travel assistants stop at raw search results.

This skill is meant to sit one level higher:

- turn search output into a shortlist
- explain tradeoffs in plain language
- compare flights, hotels, and transport modes
- hand off a checkout/deeplink only after a real choice

## What It Does

The bundle packages one reusable skill, `tutu-travel-agent`, with three routing modes:

- flight search
- hotel pick
- transport compare

The skill is designed to turn raw `tutu` MCP results into shortlist-style recommendations with grounded tradeoff explanations and optional checkout/deeplink handoff.

## Repo Layout

```text
scripts/
  install.sh
skill/
  tutu-travel-agent/
    SKILL.md
    agents/openai.yaml
    references/
      flight-mode.md
      hotel-mode.md
      transport-compare.md
```

## Prerequisite

Configure the Tutu MCP server under the alias `tutu`.

Example:

```json
{
  "mcpServers": {
    "tutu": {
      "baseUrl": "https://mcp.tutu.ru/mcp"
    }
  }
}
```

## Install

Zero-manual-work path:

```bash
git clone https://github.com/AlexeyKorzhebin/tutu-travel-agent-skill.git
cd tutu-travel-agent-skill
./scripts/install.sh --target codex
```

Other install targets:

- Codex only: `./scripts/install.sh --target codex`
- OpenClaw only: `./scripts/install.sh --target openclaw`
- Both: `./scripts/install.sh --target all`
- Replace an existing install: add `--force`
- Keep one working copy via symlink: add `--link`

Typical default target directories:

- Codex: `$CODEX_HOME/skills/` or `~/.codex/skills/`
- OpenClaw: `~/.openclaw/workspace/skills/`

## How To Install In Codex

1. Make sure the `tutu` MCP server is configured in your Codex environment.
2. Run `./scripts/install.sh --target codex`.
3. Restart Codex or reopen the session if your setup caches skills on startup.
4. Invoke the skill explicitly as `$tutu-travel-agent` or let it trigger from travel-selection requests.

## How To Install In OpenClaw

1. Make sure the `tutu` MCP server is configured and reachable under the alias `tutu`.
2. Run `./scripts/install.sh --target openclaw`.
3. Restart or reload the runtime if your current contour only discovers skills at startup.
4. Use it for requests such as:
   - flight selection
   - hotel shortlist building
   - train vs plane comparison

## Quick Start

After installation, try prompts like:

- `Use $tutu-travel-agent to find 3 Moscow → Istanbul flight options with baggage.`
- `Use $tutu-travel-agent to shortlist hotels in Kazan with breakfast and free cancellation.`
- `Use $tutu-travel-agent to compare train and flight to Saint Petersburg for a business trip.`

## Trigger Examples

- "Find me 3 flight options Moscow to Istanbul with baggage"
- "Pick a hotel in Kazan for 2 nights with breakfast and free cancellation"
- "Compare train and flight to Saint Petersburg and recommend the best option"
- "Give me the checkout link for the best balanced option"

## Design Notes

- One skill, not three separate skills
- Shared grounding and checkout rules
- Mode-specific references for progressive disclosure
- No scripts in v1; ranking stays prompt-driven and easy to adapt

## Release

The first public shareable cut is `v0.1.0`.

## License

MIT
