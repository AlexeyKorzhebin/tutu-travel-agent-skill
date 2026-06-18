# Flight Mode

Use this mode for:

- point-to-point flight search
- baggage-sensitive selection
- refundable / changeable fare selection
- airport-sensitive recommendations
- checkout handoff after a flight is chosen

## Search Flow

1. Confirm origin, destination, and date.
2. Clarify only if it changes the shortlist:
   - baggage needed or not
   - non-stop vs any
   - preferred time window
   - refundability / exchange
   - airport preference
   - budget cap
3. Start with `search_avia`.
4. If the user is open to non-flight alternatives, switch to `search_multitransport`.

## Ranking Pattern

Default shortlist:

- cheapest
- most convenient by schedule
- best balance of price and convenience

If the user cares about baggage or flexibility, prefer variants with those properties over the absolute cheapest bare fare.

## Required Output Fields

- carrier
- exact airport and terminal when present
- departure and arrival time
- duration
- price
- baggage
- refund / exchange
- carrier rating when present
- short reason this option is in the shortlist

## Variant Handling

Within one offer, compare `variants[]` explicitly:

- cheapest tariff
- baggage-included tariff
- refundable or changeable tariff

Do not blend those into one fake combined tariff.

## Checkout Rule

Only use `create_checkout_link` after:

- the user selected a concrete offer, or
- the user explicitly asked for a checkout/deeplink on the recommended option

If the deeplink response also returns a browse/search fallback, mention that clearly.
