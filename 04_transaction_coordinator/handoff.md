# Transaction Coordinator Handoff

## What I Receive

I receive from **05_offer_navigator** when a contract is executed and the deal moves to under_contract. At that point, 05 passes the accepted offer details (price, closing date, option period, earnest money, contingencies) and I set up the Deal Jacket.

I am also called directly by the orchestrator at any point during under_contract stage when the agent has a transaction question or document issue.

## What I Produce

I do not produce a standalone file. All my output lives inside the deal-file.md Deal Jacket section — updated in place.

When routing to 03_client_communication, I produce a routing note (inline in the session) with:
- Situation description
- Tone guidance
- Specific content that must be in the message

## What I Write

- **Key Dates table** — populated immediately when contract is executed
- **Document Checklist** — updated each session as documents are confirmed received
- **Open Items** — current list of unresolved tasks
- **Risk Flags** — URGENT items (72-hour window) and stop-condition risks (missing documents close to closing)

## Stage

I set Stage to **under_contract** when a contract is executed and I take over.
I set Stage to **closed** when the final walkthrough is complete and closing is confirmed.

## What Comes Next

When all checklist items are cleared and closing is confirmed: Stage is set to "closed" and the deal is complete. No further routing needed. Agents can close the deal folder at that point.
