# Client Communication Handoff

## What I Produce

A dated draft file in the deal's comms/ folder:
`_shared/cases/[CASE_ID]/comms/YYYY-MM-DD-[situation-slug].md`

The draft is labeled PENDING APPROVAL. Nothing is final until the agent says so.

## What I Write to deal-file.md

I append a one-line entry to the Comms Log table:

| Date | File | Status |
|------|------|--------|
| [date] | comms/[filename].md | PENDING APPROVAL |

Valid status values:
- **PENDING APPROVAL** — draft written, awaiting agent review
- **REVISION IN PROGRESS** — agent requested changes, rewriting in place
- **SENT** — agent confirmed the message was sent (agent sets this, not me)

I do not change the Stage field. Stage is owned by the specialist responsible for the deal's progression (01, 02, 04, or 05). Communication happens at every stage. It is not a stage transition.

## Who Can Route to Me

- The **orchestrator** — when the agent says they need to send a message at any deal stage
- **04_transaction_coordinator** — when a deadline or document issue requires a client-facing message (04 produces a situation description as a routing note; I use that note to write the draft)

## What Comes Back to Me

When an agent requests a revision: rewrite the file in place, update Comms Log status to REVISION IN PROGRESS, then back to PENDING APPROVAL when done.

When a draft is approved and sent: the agent updates the Comms Log status to SENT. That is the agent's action, not mine.

## I Do Not Change

- The Stage field in deal-file.md
- The Lead Card
- The Deal Jacket
- research-brief.md or offer-summary.md
