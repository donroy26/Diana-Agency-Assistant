# Orchestrator Examples

---

## Example 1 — New Agent, First Session, New Buyer Lead

**Context:** Jordan is a newer agent on Diana's team. She has never used the system before.

---

**Orchestrator:** Who am I working with today? (First name)

**Jordan:** Jordan

**Orchestrator:** *(checks `_shared/voice/Jordan.md` — file not found)*
I don't have a voice profile for you yet. Let's build one before we start. Takes about 5 minutes.
*(loads and follows `_onboarding/voice_setup.md`)*

— *(voice setup runs, Jordan's profile is written as ACTIVE)* —

**Orchestrator:** We're set. Are we working with a new lead or an existing deal today?

**Jordan:** New lead. Couple I met at the open house on Barton Hills Drive this morning.

**Orchestrator:** Opening lead qualifier. Tell me about the new prospect.

*(routes to 01_lead_qualifier — Jordan describes the couple: buyers, $575k budget, want South Congress or Travis Heights, two kids so school district matters, 90-day timeline)*

— *(01_lead_qualifier runs the intake, writes Lead Card to new deal folder)* —

**Orchestrator:** Lead Card is written. Do you need to kick off research now or come back to it?

**Jordan:** Let's come back to it. I have a showing in 30 minutes.

**Orchestrator:** Got it. Come back when you're ready and we'll pull research on South Congress and Travis Heights for this budget range.

---

## Example 2 — Experienced Agent, Existing Deal, Under Contract

**Context:** Marcus is an experienced agent on Diana's team. He has an active voice profile. His client Sarah Okonkwo is under contract on a property in Mueller, and a complication just came up.

---

**Orchestrator:** Who am I working with today? (First name)

**Marcus:** Marcus

**Orchestrator:** *(checks `_shared/voice/Marcus.md` — Status: ACTIVE)*
Are we working with a new lead or an existing deal today?

**Marcus:** Existing deal. Sarah Okonkwo.

**Orchestrator:** *(locates `_shared/cases/OKONKWO-2026-002/deal-file.md` — Stage: under_contract, last session was May 12th)*
Got it. Sarah's deal, currently under contract. What's happened since we last talked?

**Marcus:** Inspection came back this morning. HVAC system is original to the house. Inspector flagged it as end of life. Buyer is getting nervous.

**Orchestrator:** *(appends Session Log entry to deal-file.md:)*

> ### 2026-05-16 — Session 4
> **Agent:** Marcus
> **Stage at start:** under_contract
> **Update from agent:** Inspection returned. HVAC flagged as end of life. Buyer nervous.
> **Work completed:** [to be filled after session]
> **Stage at end:** under_contract

Is there a transaction issue, a document question, or a client message to send?

**Marcus:** I need to send Sarah a message. I want to calm her down before she does something rash.

**Orchestrator:** Routing to client communication. I'll let 03 know this is a mid-deal inspection situation: Marcus voice profile, buyer client, calm and solution-focused tone needed.

*(routes to 03_client_communication with situation context)*
