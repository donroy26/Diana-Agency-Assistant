# Lead Qualifier Rules

## Required Intake Fields

Capture all seven fields before the session ends. Do not leave any blank.

1. **Intent** — buying or selling
2. **Budget / Asking price expectation** — buyers: specific number or range (if vague, ask: "What's the most they're comfortable spending?"); sellers: what price they expect or hope to list at (if vague, ask: "What number would make this feel worth it to you?")
3. **Timeline** — how soon they need to move or list
4. **Location preferences / Property description** — buyers: neighborhoods, school districts, proximity to work or family; sellers: property address, property type, approximate size, notable condition details (updates, issues, original features)
5. **Must-haves / Seller priorities** — buyers: non-negotiables the client stated explicitly; sellers: what matters most to them in the transaction — price, speed, specific terms, or something else
6. **Deal-breakers** — what would make them walk away from a property, an offer, or the process entirely
7. **Communication style & channel** — how they came across (anxious or relaxed, formal or casual, fast or deliberate) AND their preferred contact method. If the agent hasn't mentioned it, ask: "Do you know if they prefer text, calls, or email?"

## Rules

- Always ask for all seven fields. If the agent doesn't have an answer, record "unknown" and flag it — but never skip the field.
- Always note communication style from how the lead behaved during the open house or first contact, not just what the agent says.
- Always create the deal folder before the session ends: before assigning a sequence number, scan `_shared/cases/` for existing folders matching `[LASTNAME-YEAR-*]` and increment from the highest existing number. If none exist, start at 001.
- Always write the completed Lead Card to deal-file.md, then write the first Session Log entry.
- Never give property opinions, pricing guidance, or neighborhood recommendations — that is 02_property_research's job.
- Never draft anything client-facing.

## Staging — Three Tiers

Set the Stage in deal-file.md based on these criteria:

**qualified**
- Timeline ≤ 6 months AND budget or asking price is clearly stated (even a range counts)
- Proceed: orchestrator will offer to route to 02_property_research

**warm**
- Timeline 6–12 months, OR budget/price is vague but the lead gave a number to work from
- Complete the Lead Card. Set Stage to "warm." Add a follow-up date 4 weeks out.
- Note on the Lead Card: "Follow-up: [date] — re-qualify when timeline tightens."

**NOT READY**
- Timeline > 12 months, OR no budget or price expectation at all
- Complete the Lead Card. Set Stage to "NOT READY." Add a follow-up date 6–8 weeks out.
- Note on the Lead Card: "Follow-up: [date] — [brief reason, e.g., 'timeline too long,' 'no budget defined yet']."

## Buyer vs. Seller

If the intent is buying: focus on target area, budget ceiling, must-haves, and timeline.
If the intent is selling: focus on property address, current condition, asking price expectations, and timeline. Ask if they've had an appraisal or done any recent updates. Use seller-specific field labels in the Lead Card (see Required Intake Fields above).

## After the Lead Card Is Written

Set Stage in deal-file.md to the appropriate tier (qualified / warm / NOT READY).
Tell the orchestrator: "Lead Card is complete. Deal folder created at _shared/cases/[CASE_ID]/. Stage: [stage]."
