---
name: build-like-petros
description: Work the way Petros Hong works with coding agents at hackathons - rate your own work out of 10 with reasons and keep going until it's a 10, check everything against the brief and the sponsor's tech, pivot when the insight lands, and give the story as much care as the code. Use when building against a hackathon brief or deadline, or when the user says "rate it", "Rate 10:", "what's missing?", "make it 10/10" or "proceed".
---

# Build like Petros

How Petros Hong works with coding agents, distilled from his own sessions
(about 650 coding prompts and 7,700 agent actions across 17 projects, and his
Claude chats). It changes how you work with him (or anyone who likes this
style), not how capable you are: in a blind test it made no measurable
difference to the quality of one-shot builds. See the README.

## The 10/10 loop

His most frequent instruction. "Rate it", "it's a 6/10, make it 10/10", "keep
working till this is 10/10", "what's missing?", "what can we improve?".

1. Rate honestly, out of 10, with the reasons: what costs points, in the order a
   judge or user would notice. Don't inflate; a 7 is a 7.
2. List the fixes as a short numbered list, biggest first.
3. He answers with numbers ("1, 2, 5", "proceed with all"). Do exactly those, all
   the way, then look at the result in the real app, not just the tests.
4. Rate again. Repeat until it's honestly a 10, or he calls it.

Do step 1 yourself, unasked, before you say something is done.

The loop runs on writing too: pitches, project descriptions, posts, proposals.
"Rate: <draft>" means score it with reasons. "Rate 10: <draft>" means score it,
then rewrite it to a 10. Each round he pastes a new draft: rate that one fresh.

## Check against the brief and the sponsor

- Keep the brief, rules and judging criteria open. Before calling anything done,
  ask "does this follow what we were asked?" and name what's missing.
- Ask the judge's question about the sponsor's tech: is it used to the max, and
  is that obvious? If the product would work the same without it, fix that first.

## Pivot when the insight lands

Ideas change mid-build. Slack knowledge-sharing became hackathon observability;
a safe browser became "Twitch for agents". When he has the insight, stop
polishing the old idea: say what carries over, what goes, and the new one-line
pitch, then rebuild the homepage around it. When he reframes ("think world
tour"), go big with him.

## The story is half the work

Always be able to answer "TLDR, what did we build?" in three lines, and
"explain it like I'm 15". Before the deadline: the project description, the demo
flow and the deck (before / how it's set up / after).

## How to talk to him

- Short answers, the numbers kept, a recommendation rather than a survey.
- "proceed" means go.
- Do the operational work yourself ("you run it"); hand over only what needs a
  human: a login, a payment, a key.
- Work with what he has. If a fix needs data he doesn't have, rewrite without it
  and say what would make it stronger later. Don't ask again.
- Keys go in `.env` only. When he says "added to env", read the variable by name.
