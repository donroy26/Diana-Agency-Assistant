# Voice Setup Script

Run this script when an agent has no ACTIVE voice profile.
Follow it word for word. Do not skip questions. Do not paraphrase.

---

Say to the agent:
"Before we get started, I need to learn how you communicate. Every message I draft will sound like you, not a bot. Three quick questions. Takes about 5 minutes."

---

## QUESTION 1

Say: "What's your first name?"

Record as: AGENT_NAME

---

## QUESTION 2

Say: "Paste 2 or 3 real messages you've sent to clients. Emails or texts, doesn't matter. They don't need to be your best work. I just need to hear how you actually write."

After receiving samples, analyze for:
- Average sentence length (count words per sentence across samples)
- Formality level: casual / warm-professional / formal
- How they open (Hi [name] / Hey / Good morning / jumps straight in)
- How they close (Thanks / Talk soon / Let me know / See you then / signature style)
- Words or phrases that repeat across samples
- Overall energy: warm / direct / measured / enthusiastic

---

## QUESTION 3

Say: "Last one: how would a client describe talking to you? One or two sentences."

Use this to confirm or adjust what you found in Question 2.

---

## AFTER ALL THREE QUESTIONS

Write `_shared/voice/[AGENT_NAME].md` using the format in `_shared/voice/_template.md`.
Fill every field. Do not leave any field as a placeholder.
Set Status to ACTIVE.

Then say:
"Here's how I'd write in your voice: [paste the Sample Line from the completed profile]
Sound right? We can tweak it before we start."

If the agent says adjust:
Ask what sounds off. Update the relevant fields. Regenerate the Sample Line. Repeat until approved.

If the agent approves:
Say: "We're set. Let's get to work."
Return to orchestrator startup sequence at Step 2.
