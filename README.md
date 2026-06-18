# Tutu Travel Agent Skill

Shareable Codex/OpenClaw skill for travel search and trip-choice workflows over the Tutu MCP server.

## What It Does

The bundle packages one reusable skill, `tutu-travel-agent`, with three routing modes:

- flight search
- hotel pick
- transport compare

The skill is designed to turn raw `tutu` MCP results into shortlist-style recommendations with grounded tradeoff explanations and optional checkout/deeplink handoff.

## Repo Layout

```text
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

Copy `skill/tutu-travel-agent/` into your local skills directory.

Typical targets:

- Codex: `$CODEX_HOME/skills/` or `~/.codex/skills/`
- OpenClaw workspace skills folder, if you manage skills there

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

## License

MIT
