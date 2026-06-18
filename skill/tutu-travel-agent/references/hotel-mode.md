# Hotel Mode

Use this mode for:

- choosing among hotels in one city
- ranking budget vs quality vs location
- breakfast / free cancellation filtering
- producing a shortlist with reasons

## Search Flow

1. Confirm:
   - city
   - dates
   - guest count
2. Clarify only the criteria that affect ranking:
   - budget
   - breakfast
   - free cancellation
   - area / closeness to center
   - type of property
   - minimum rating
3. Start with `search_hotels`.
4. Use `get_offer_details` only when room-level or rate-level confirmation is needed.

## Ranking Pattern

Default shortlist:

- cheapest acceptable option
- best quality option
- best price/quality compromise

## Required Output Fields

- hotel name
- stars when present
- rating and review count
- distance-from-center text when present
- price
- room name from `best_offer.room_name`
- breakfast status
- free cancellation status
- one strong point
- one tradeoff
- checkout URL

## Grounding Rules

- If `best_offer.free_cancellation` is null or absent, say it is unknown.
- If `best_offer.breakfast_included` is absent, say it is unknown.
- Do not infer room size, view, noise level, breakfast quality, or neighborhood feel unless Tutu returned it.
- Do not call a hotel "best" without saying whether you mean price, quality, or balance.

## Checkout Rule

If the hotel listing already provides a ready details URL, it is fine to hand it over as the next step.
Use `create_checkout_link` only when you intentionally want the explicit Tutu deeplink flow.
