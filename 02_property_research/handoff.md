# Property Research Handoff

## What I Produce

**research-brief.md** — written to the deal folder at `_shared/cases/[CASE_ID]/research-brief.md`

This is the authoritative research document for the deal. Every specialist that comes after me reads it. 05_offer_navigator reads it before advising on any offer amount. The content of research-brief.md must be complete enough that the next specialist can act without asking me anything.

If this is a refresh of existing research, a "Refreshed:" date line is added at the top of the file and the deal-file.md summary is updated.

## Sections by Mode

**Buyer research-brief.md contains:**
1. Neighborhood analysis
2. Comparable sales (min 3 comps, last 90 days)
3. School ratings *(only if school district was in the Lead Card — omitted otherwise)*
4. Market conditions
5. Budget reality check
6. Timeline check *(only if a hard deadline is in the Lead Card — omitted otherwise)*

**Seller research-brief.md contains:**
1. Active comparable listings
2. Recently sold comparables (min 3 comps, last 90 days)
3. List price range recommendation
4. Seller expectation check *(explicit statement of whether seller's price expectation is above, within, or below comp range — always present)*
5. MLS positioning paragraph
6. Market conditions

## What I Write to deal-file.md

I append a one-paragraph summary to deal-file.md referencing research-brief.md. This summary covers:
- What I found (the key insight: does the budget work, is the comp range where the seller expects, etc.)
- What it means for this client
- What the recommended next step is

I also update Stage to: **researched**

## What Comes Next

After Stage is set to "researched," the orchestrator routes to either:
- **05_offer_navigator** — if the client is ready to make or evaluate an offer
- **03_client_communication** — if the agent needs to draft a message first (e.g., setting expectations with a seller before the listing conversation)

05_offer_navigator must read research-brief.md before advising on any offer price or strategy. That dependency is load-bearing. Do not let offer work begin without a completed research brief.
