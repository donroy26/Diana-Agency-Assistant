# Handoff Protocol

## The Model

This is a single Claude project. All six specialist folders are loaded together. Claude reads the orchestrator files on startup and operates from there. There are no separate projects per specialist. Everything runs in one place. Agents never copy-paste structured blocks between sessions.

## What a Handoff Is

When a specialist finishes its work, it writes its output to the deal folder. That is the handoff. There are no envelopes, no structured messages, no separate processes. The next specialist reads the deal folder to pick up where the previous one left off.

## The Deal Folder as Spine

Every deal lives in `_shared/cases/[CASE_ID]/`. The deal-file.md is the running log of the deal: who did what, when, and what stage the deal is at. Deliverables (research briefs, offer summaries, communication drafts) are separate files inside the same folder.

- The Lead Card is written directly into deal-file.md by 01_lead_qualifier.
- research-brief.md is created by 02_property_research and referenced from deal-file.md.
- offer-summary.md is created by 05_offer_navigator and referenced from deal-file.md.
- Communication drafts are written to the `comms/` subfolder by 03_client_communication.
- The Deal Jacket section of deal-file.md is owned and updated in place by 04_transaction_coordinator.

## The Session Update Convention

At the start of every existing-deal session, the orchestrator asks: "What's happened since we last talked?" The agent's answer is appended to the Session Log in deal-file.md as a new entry, date-stamped and attributed to the agent, before any specialist is engaged. This entry is the bridge between sessions. Claude has no memory between sessions; the deal file does.
