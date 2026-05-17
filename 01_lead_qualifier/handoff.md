# Lead Qualifier Handoff

## What I Produce

I do not produce a standalone file. The Lead Card lives inside deal-file.md.

## What I Write

**1. Deal folder created:**
`_shared/cases/[LASTNAME-YEAR-###]/`

Before assigning ###: scan `_shared/cases/` for folders matching `[LASTNAME-YEAR-*]` and use the next available number. Start at 001 if none exist.

Contents copied from `_shared/cases/_template/`:
- deal-file.md (with Lead Card and first Session Log entry filled in)
- comms/ (empty folder, ready for 03_client_communication)

**2. Lead Card section of deal-file.md**

For buyers, use these labels:
- Intent
- Budget
- Timeline
- Location preferences
- Must-haves
- Deal-breakers
- Communication style & channel

For sellers, use these labels:
- Intent
- Asking price expectation
- Timeline
- Property address & description
- Seller priorities
- Deal-breakers
- Communication style & channel

All seven fields must be filled. Record "unknown" and flag if the agent couldn't provide a value.

If stage is **warm** or **NOT READY**, include a follow-up date field:
- `Follow-up date: [date] — [brief reason]`

**3. First Session Log entry in deal-file.md:**
```
### [Date] — Session 1
**Agent:** [name]
**Stage at start:** new_lead
**Update from agent:** first session
**Work completed:** Lead Card written by 01_lead_qualifier
**Stage at end:** [qualified / warm / NOT READY]
```

**4. Stage field in deal-file.md** set to one of:
- `qualified` — timeline ≤6 months AND clear budget or asking price
- `warm` — timeline 6–12 months, or budget/price vague but stated
- `NOT READY` — timeline >12 months, or no budget/price at all

## What Comes Next

- **qualified** → orchestrator offers to route to 02_property_research; agent decides whether to continue now or return later
- **warm** → no immediate routing; orchestrator notes the follow-up date and closes the session
- **NOT READY** → no immediate routing; orchestrator notes the follow-up date and closes the session
