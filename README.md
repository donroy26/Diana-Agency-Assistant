# Diana's Real Estate Team AI OS

## What This Is

An AI operating system for Diana's 4-person boutique real estate team in Austin, TX. It runs inside Claude Code with no new software, no new logins, no integrations. It handles leads, property research, client communication, offer strategy, and transaction coordination through six AI specialists working in a single Claude project.

---

## Architecture

```
               ┌─────────────────────┐
               │   00_orchestrator   │
               │  (front door, routes│
               │   every request)    │
               └──────────┬──────────┘
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
┌───────────────┐ ┌──────────────┐ ┌──────────────────┐
│01_lead_       │ │02_property_  │ │03_client_        │
│qualifier      │ │research      │ │communication     │
│               │ │              │ │                  │
│Writes:        │ │Writes:       │ │Writes:           │
│Lead Card      │ │research-     │ │comms/drafts      │
│in deal-file   │ │brief.md      │ │                  │
└───────────────┘ └──────────────┘ └────────▲─────────┘
                                            │ ◄── routes back from 04
                                            │
                            ┌───────────────┴──┐
                            │05_offer_navigator│
                            │                  │
                            │Writes:           │
                            │offer-summary.md  │
                            └────────┬─────────┘
                                     │
                            ┌────────▼─────────┐
                            │04_transaction_   │
                            │coordinator       │
                            │                  │
                            │Writes:           │
                            │Deal Jacket in    │
                            │deal-file         │
                            └──────────────────┘

  All specialists read and write to:
  _shared/cases/[CASE_ID]/deal-file.md
```

The deal folder is the memory. Claude has no memory between sessions. The deal file does. Every session starts with a brief update from the agent on what's happened since the last session, which is appended to the deal file before any work begins.

---

## How a Request Flows

### New buyer lead: Kevin Torres, East Austin, $425–500k

Kevin walks into an open house on Tillery Street. Agent Diana captures the lead. She opens the system, Claude asks her name and confirms her voice profile is active. She says "new lead." Claude routes to the lead qualifier, which walks Diana through the intake: intent, budget, timeline, target area, must-haves, deal-breakers, communication style. When the Lead Card is complete, Claude creates a deal folder at `_shared/cases/TORRES-2026-001/`. Stage is set to "qualified."

Next session, Diana comes back and says "Kevin Torres." Claude reads the deal file (stage is "qualified"). Asks what's new, logs the update, and routes to property research. The research specialist pulls comps in East Austin and Mueller for the $425–500k range and produces research-brief.md. When Kevin finds a property he wants to offer on, Diana opens the system again. Stage is now "researched." She says offer, and Claude routes to the offer navigator, which reads the research brief and models the offer.

### Mid-deal, inspection issue: Sarah Okonkwo, under contract

Marcus's client Sarah is under contract on a Mueller property. An inspection finds an HVAC issue. Marcus opens the system. Claude confirms Marcus's voice profile, asks about the deal. Marcus says "Sarah Okonkwo." Claude reads the deal file (stage is "under_contract"). Asks "What's happened since we last talked?" Marcus describes the HVAC finding. Claude logs the session update. Marcus says he needs to send Sarah a message. Claude routes to client communication. The specialist reads Marcus's voice profile and deal context, and drafts a calm, direct text in Marcus's voice, short sentences, signed "– M", and saves it to the comms folder as PENDING APPROVAL. Marcus reads it, approves it, and sends it himself.

---

## Setup — Windows

1. Download or clone this repo to your computer
2. Double-click `install.bat`
3. Enter your first name when prompted
4. Open the "Dianas Team AI" shortcut on your desktop
5. Claude will walk you through a 5-minute voice setup
6. After voice setup, say "new lead" or name an existing deal to begin

## Setup — Mac

1. Download or clone this repo
2. Open Terminal
3. Navigate to the repo folder: `cd path/to/agency-system`
4. Run once: `chmod +x launch.sh`
5. Start Claude: `./launch.sh`
6. Claude walks you through voice setup on first launch

---

## Onboarding a New Team Member

Same steps as Setup above. Claude builds a voice profile on first launch. They paste two or three messages they've sent to clients, Claude learns their style, and they're operational in about five minutes. They do not need to read any documentation before starting.

---

## What Each Specialist Does

| Specialist | Job |
|-----------|-----|
| 00_orchestrator | Front door — identifies the agent, routes every request, captures session updates |
| 01_lead_qualifier | First contact — captures intent, budget, timeline, and creates the deal folder |
| 02_property_research | Market and comp analysis — buyer or seller mode, produces research-brief.md |
| 03_client_communication | Drafts all client messages in the agent's voice — nothing sent without approval |
| 04_transaction_coordinator | Tracks deadlines, documents, and risks from contract to close |
| 05_offer_navigator | Structures offers (buyer) or evaluates and ranks incoming offers (seller) |

---

## Deal Folders

Each deal lives in `_shared/cases/[LASTNAME-YEAR-###]/`.

To start a new deal: tell the orchestrator you have a new lead. 01_lead_qualifier creates the folder automatically.

To continue an existing deal: tell the orchestrator the client name. Claude reads the deal file at the start of the session and routes based on the current stage.

The deal file is the memory. Never delete it. Specialists append to it. They do not overwrite existing content.

---

## What This System Does Not Do

- Send messages (all drafts require agent review and approval before sending)
- Connect to MLS, Zillow, or any live data source
- Give legal or contract advice (flag those questions to Diana)
- Remember conversations on its own (the deal file is the memory between sessions)
- Replace agent judgment (it prepares, drafts, and tracks so agents can focus on relationships)
