---
name: tutu-travel-agent
description: "Travel planning and trip-choice workflow over the Tutu MCP server for flights, hotels, trains, buses, commuter rail, and mixed transport. Use when Codex needs to search travel options, compare tradeoffs, shortlist recommendations, explain the best choice, or build checkout/deeplink URLs after the user chooses an option."
---

# Tutu Travel Agent

Use this skill as a routing layer over the `tutu` MCP server.

## Workflow

1. Identify the mode:
   - flight search
   - hotel pick
   - transport compare
2. If the request is too broad, ask only the missing constraints that change ranking:
   - dates
   - route or city
   - budget
   - baggage / refundability for flights
   - breakfast / cancellation / area for hotels
   - user scenario for cross-mode comparison
3. Run the narrowest search tool that fits the intent:
   - `search_avia`
   - `search_hotels`
   - `search_rail`
   - `search_bus`
   - `search_etrain`
   - `search_multitransport`
4. Build a shortlist, not a raw dump.
5. Use detail tools only on narrowed options:
   - `get_offer_details`
   - `get_rail_seatmap`
6. Use `create_checkout_link` only after the user has effectively chosen a concrete option or explicitly asked for a checkout link.

## Mode Routing

- For flights or airport-driven requests, read [references/flight-mode.md](references/flight-mode.md).
- For hotel selection, read [references/hotel-mode.md](references/hotel-mode.md).
- For train vs plane or any mixed-mode decision, read [references/transport-compare.md](references/transport-compare.md).

## Grounding Rules

- Use only fields returned by Tutu.
- If baggage, refundability, breakfast, cancellation, seat class, room details, or comfort evidence are absent, say that Tutu did not return them.
- Do not substitute web knowledge or generic travel assumptions for missing fields.
- Keep airport and station names exact when Tutu gives them.
- When one offer has multiple tariffs or variants, compare them explicitly instead of collapsing them into one synthetic option.
- Treat `search_results_url` as browse/fallback and `checkout_url` or `create_checkout_link` output as the concrete handoff link.
- Never imply that checkout means the booking is complete. It is only the handoff step.

## Recommendation Shape

Prefer a compact decision-oriented answer:

1. Short market summary
2. Top 3 options
3. Why each option exists in the shortlist
4. Clear recommendation with tradeoff explanation
5. Checkout link only when appropriate

## Common Failure Modes

- Dumping raw search output without ranking
- Inventing baggage, cancellation, or comfort details
- Using `create_checkout_link` too early
- Recommending a hotel or fare as "best" without stating the criterion
- Mixing different airports or stations without calling out the difference

## Output Style

- Use short paragraphs or flat bullets.
- Explain the tradeoff, not just the winner.
- Prefer language like:
  - "самый дешёвый"
  - "самый удобный по времени"
  - "лучший компромисс"
- If the user's scenario matters, tie the recommendation to that scenario:
  - business trip
  - family trip
  - budget travel
  - one-day trip
