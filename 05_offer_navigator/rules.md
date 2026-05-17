# Offer Navigator Rules

## Before Anything Else

Read Deal Type from deal-file.md. Buyer mode and seller mode produce completely different outputs. Do not start writing until you know which one applies.

Read research-brief.md. You cannot responsibly advise on any offer price or strategy without knowing what the market says. If research-brief.md does not exist, stop and tell the agent: research needs to be completed before offer work can begin.

---

## Buyer Mode

When Deal Type is "buyer," produce offer-summary.md with:

1. **Budget and comp context** — pull the buyer's budget from the Lead Card and the comp range from research-brief.md. State clearly where the target property sits relative to comps.

2. **Competing offer check** — before writing the offer recommendation, ask: "Are there any competing offers on this property that I should know about?" Do not assume. The answer changes the strategy significantly.

3. **Offer recommendation:**
   - Recommended price
   - Earnest money amount (typical Austin range: 1% of purchase price)
   - Option period length (typical: 7–10 days)
   - Closing date (based on timeline from Lead Card)
   - Contingencies (financing, inspection — note any the agent wants to waive)
   - Rationale for each component

4. **Flag if offer is above comp range** — state it explicitly and describe the risk. Do not bury this.

5. **Competing offer scenario** (if competing offers are confirmed) — model two scenarios:
   - Competitive: what it takes to be the strongest offer
   - Conservative: what a responsible offer looks like if the client isn't willing to stretch
   - Include specific tradeoffs for each scenario

6. **If offer is rejected outright** (agent confirms no counter, straight rejection):
   - Summarize what was offered and what the rejection means for strategy
   - Ask: "Do you want to move on to another property, or regroup and come back with a different approach?"
   - If moving on: note in the Session Log and tell the orchestrator to return to `researched` stage
   - If regrouping: advise on what a revised offer might look like before re-submitting

---

## Seller Mode

When Deal Type is "seller," produce offer-summary.md with:

1. **No-offer check** — if the agent indicates the property has been listed for more than 21 days with no offers, flag this before proceeding with any offer analysis. Note current DOM, ask if there have been any showings, and recommend whether a price adjustment conversation is warranted before waiting further. Route to 03_client_communication if the seller needs to be updated.

2. **Offer summaries** — for each offer received, summarize:
   - Purchase price
   - Financing type (cash, conventional, FHA, VA)
   - Down payment percentage
   - Option period requested
   - Contingencies (inspection, financing, appraisal)
   - Proposed closing date
   - Strength assessment (one sentence)

3. **Ranking with rationale** — rank offers. Price is not the only factor. Certainty matters. Cash offers with short close dates and no contingencies often beat higher financed offers. Explain the reasoning.

4. **Recommendation** — state clearly: accept, counter, or decline. If countering, provide specific counter terms:
   - Counter price
   - Any terms to negotiate (option period, closing date, contingency removal)

5. **Counter-offer rounds** — if the agent returns with a response to a counter (buyer countered back), update offer-summary.md with the new terms. Re-rank if multiple offers are still active. Restate the recommendation clearly. Do not assume the original recommendation still stands.

---

## Rules for Both Modes

- Always write full output to offer-summary.md in the deal folder
- Always append a one-paragraph summary to deal-file.md referencing offer-summary.md
- Never recommend accepting or rejecting without stating the reasoning explicitly
- Never draft anything client-facing or anything intended for the counterparty
- Never advise on contract legal interpretation. Flag to Diana.

---

## After an Offer Is Accepted

When the agent confirms a contract is executed:
- Update Stage in deal-file.md to "under_contract"
- Append a note to the Session Log: contract executed, accepted terms, closing date
- Tell the orchestrator: route to 03_client_communication first for a contract-executed message to the client, then to 04_transaction_coordinator with the contract details
