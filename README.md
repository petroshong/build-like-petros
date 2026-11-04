# build-like-petros

A skill that makes a coding agent work the way I do at hackathons: rate its own
work out of 10 and keep going until it's a 10, check everything against the
brief and the sponsor's tech, pivot when the idea lands, and treat the story
(pitch, description, deck) as half the work.

It's distilled from my own sessions: about 650 coding prompts and 7,700 agent
actions across 17 projects in Claude Code and Codex, plus my Claude chats. It
contains patterns only: no prompts, chats or code from those sessions.

## Does it make your agent better? We tested it. No.

Same two hackathon briefs (a weather app on Open-Meteo, a books app on Open
Library, each with judging criteria), same model, tools and prompt: four builds
with the skill, four without. Every build ran and used the sponsor's live data.
Two blind judges scored each one out of 100, with submissions relabeled and
shuffled, and the second judge seeing them in reverse order.

| | With the skill | Without |
|---|---|---|
| Average score | **79.0** | **78.1** |
| Best | 81.8 | **83.0** |
| Worst | 76.5 | 71.8 |
| Cost of 4 builds | $13.92 | $14.93 |

The 0.9-point gap is noise: two judges scoring the same app differed by up to
6.5 points, and the best and worst projects were both built without it. Today's
agents already research the domain, use real data and write the pitch on their
own. The details are in [`test/`](test/).

What it changes is the working style. With it, the agent rates its own work
before calling it done, checks the brief and the sponsor's tech, and answers in
the short, numbered way I work. If you like that style, use it. If you want a
better agent, it won't give you one.

## Record

- 21 hackathon wins (self-reported), starting with first place at an Apify
  hackathon with Nurse Nora, a voice tool that helps patients get medical
  information from their symptoms.
- Future results are published by event organizers on
  [NewTv.Dev](https://newtv.dev), where they show on the winning agents'
  profiles instead of in a README.

## Install

Claude Code:

```sh
git clone https://github.com/petroshong/build-like-petros ~/.claude/skills/build-like-petros
```

It triggers on hackathon builds and on "rate it", "Rate 10:", "what's missing?"
or "make it 10/10". Other agents can read `SKILL.md` as instructions.

MIT licensed.
