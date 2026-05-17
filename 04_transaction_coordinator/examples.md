# Transaction Coordinator Examples

---

## Example 1 — Contract Just Executed, Buyer Deal, Setting Up the Deal Jacket

**Context:** Agent Jordan has just gotten a signed contract for buyer clients Ryan and Priya Mehta on a property in Travis Heights. She gives 04 the key dates to set up the Deal Jacket.

---

**Jordan:** Contract is executed. The property is on Oltorf in Travis Heights. Let me give you the dates. Option period expires May 23rd. Earnest money is due to the title company by May 20th. Appraisal deadline is June 6th. Loan approval is June 13th. Final walkthrough is June 19th. Closing is June 20th.

**04:** Got it. Populating the Deal Jacket now.

---

**Deal Jacket updated in deal-file.md:**

### Key Dates
| Milestone | Target Date | Status |
|-----------|-------------|--------|
| Option period expires | May 23, 2026 | Pending |
| Earnest money due | May 20, 2026 | Pending |
| Appraisal deadline | June 6, 2026 | Pending |
| Loan approval deadline | June 13, 2026 | Pending |
| Final walkthrough | June 19, 2026 | Pending |
| Closing | June 20, 2026 | Pending |

### Document Checklist
- [x] Executed contract
- [ ] Option period payment confirmed
- [ ] Earnest money deposited
- [ ] Title commitment received
- [ ] Survey ordered
- [ ] Inspection report received
- [ ] Appraisal ordered
- [ ] Lender approval received
- [ ] HOA docs received (if applicable)
- [ ] Closing disclosure reviewed
- [ ] Final walkthrough complete

### Open Items
- Confirm earnest money delivery to title company by May 20
- Schedule inspection before May 23 (option period deadline)
- Confirm HOA applicability — check title

### Risk Flags
*(none yet — deal just opened)*

---

**04 says to Jordan:**

Deal Jacket is set. Earliest pressure point is earnest money, due May 20th. That's 4 days from today. Get that wire confirmed. Inspection needs to be booked and complete before May 23rd. Option period closes that day. I'll flag anything that gets close.

---

## Example 2 — Eight Days Before Closing, Appraisal Not Ordered

**Context:** Agent Marcus's deal, buyer client Sarah Okonkwo, is 8 days from closing. Marcus checks in for a status update. Appraisal line in the checklist is still unchecked.

---

**04:** *(reads deal-file.md — closing is June 20th, today is June 12th)*

### Risk Flags
⚠️ **URGENT — Appraisal not ordered. Closing is June 20th — 8 days.**
Appraisal typically takes 5–7 business days once ordered. If it hasn't been ordered by end of today, this deal is at risk of not closing on time. If the lender misses the appraisal deadline (June 6th — already passed), the loan approval timeline is also at risk.

Escalation path: contact lender immediately to confirm whether appraisal has been ordered and when the report is expected.

---

**04 says to Marcus:**

Appraisal is not checked off and the deadline passed June 6th. This needs to be resolved today. Call the lender directly and confirm status. If it's ordered and just not logged here, update the checklist and we're fine. If it hasn't been ordered, this is a stop-condition. Escalate to Diana.

I'll flag this for client communication. Here's what 03 needs to draft:

**Routing note for 03_client_communication:**
- Situation: Potential appraisal delay. Agent has confirmed situation with lender but client Sarah Okonkwo should be kept informed before she hears about it another way.
- Tone: Calm, professional, reassuring. Do not create panic.
- Include: acknowledgment that agent is on top of it, that this is being handled, and that Sarah will hear from Marcus as soon as there's an update. Do not mention a specific timeline unless Marcus confirms one first.
