# Orchestrator Handoff

## When Creating a New Deal

When 01_lead_qualifier completes a Lead Card for a new client, the orchestrator:

1. Creates the deal folder: `_shared/cases/[LASTNAME-YEAR-###]/`
   - Copy `_shared/cases/_template/deal-file.md` into the new folder
   - Copy `_shared/cases/_template/comms/` (empty folder) into the new folder
2. Writes the first Session Log entry to the new deal-file.md:
   ```
   ### [Date] — Session 1
   **Agent:** [agent name]
   **Stage at start:** new_lead
   **Update from agent:** first session
   **Work completed:** Lead Card written by 01_lead_qualifier
   **Stage at end:** qualified
   ```

## When Resuming an Existing Deal

At the start of every session on an existing deal, the orchestrator appends a new Session Log entry to deal-file.md before routing to any specialist:

```
### [Date] — Session [N]
**Agent:** [agent name]
**Stage at start:** [current stage from deal-file.md]
**Update from agent:** [verbatim summary of what agent reported]
**Work completed:** [filled in after specialist work is done]
**Stage at end:** [filled in after specialist work is done]
```

The "Work completed" and "Stage at end" fields are updated at the end of the session, after the specialist finishes.

## What the Orchestrator Does Not Write

The orchestrator does not write the Lead Card, research-brief.md, offer-summary.md, or any client communication drafts. Those belong to their respective specialists.
