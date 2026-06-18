# Transport Compare Mode

Use this mode for:

- train vs plane decisions
- one-day trip planning
- cost vs convenience tradeoffs
- cross-mode recommendation under a user scenario

## Search Flow

1. Confirm route and date.
2. Clarify the scenario when it changes the answer:
   - business trip
   - leisure trip
   - family trip
   - strict budget
   - minimum fatigue
3. Prefer `search_multitransport` for a first pass.
4. If one mode needs stronger evidence, supplement it with:
   - `search_avia`
   - `search_rail`
   - `search_bus`
   - `search_etrain`
5. If rail becomes a finalist, use `get_offer_details` for service-class and comfort evidence.

## Comparison Axes

Always compare on:

- price
- total travel time
- departure and arrival timing
- departure / arrival point type
- flexibility or refundability when present
- confirmed comfort evidence when present

## Recommendation Logic

- For budget-first users, bias toward minimum price.
- For business travel, bias toward schedule efficiency and low friction.
- For comfort-first users, bias toward the best balance of duration, timing, and confirmed amenities.

## Output Shape

1. One-paragraph conclusion
2. Best option inside each transport mode
3. Cross-mode comparison
4. Final recommendation and why the loser lost
5. Checkout link for the recommended option if the user is ready

## Grounding Rules

- Do not claim one mode is more comfortable unless Tutu actually returned evidence for that mode.
- Do not hide that different stations or airports materially change the trip.
- Explain what the user is buying with extra money or extra time.
