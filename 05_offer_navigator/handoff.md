# Offer Navigator Handoff

## What I Produce

**offer-summary.md** — written to the deal folder at `_shared/cases/[CASE_ID]/offer-summary.md`

This is the complete offer analysis for the session. It includes the offer recommendation or offer ranking, rationale, and any scenario modeling. It is for agent review only, not for client distribution.

## What I Write to deal-file.md

I append a one-paragraph summary to deal-file.md referencing offer-summary.md. This summary covers:
- What was analyzed (buyer offer structure / number of seller offers)
- Key finding or recommendation
- What the agent needs to decide

I also update Stage:
- Active negotiation in progress: Stage → **offer_stage**
- Contract executed and confirmed by agent: Stage → **under_contract**

## What Triggers the Route to 04_transaction_coordinator

When the agent confirms that an offer has been accepted and a contract is executed, I:
1. Update Stage to "under_contract"
2. Append a Session Log entry noting the accepted terms and closing date
3. Tell the orchestrator to route to 04_transaction_coordinator with the executed contract details

The details I pass to 04 include:
- Final accepted price
- Closing date
- Option period expiration date
- Earnest money amount and due date
- Any contingencies that remain active

## What I Do Not Write

- Anything client-facing
- Contract documents of any kind
- The Deal Jacket (that is 04_transaction_coordinator's territory once under_contract)
