# The test

Does `build-like-petros` make a coding agent build a better hackathon project?

- **Briefs:** two sponsor tracks with judging criteria (Impact 25%, Technical 25%,
  Use of the sponsor's tech 25%, Design 15%, Presentation 10%): a web app that
  helps a group of people decide something with Open-Meteo weather data, and a
  web app for students or readers on Open Library. Both APIs need no key.
- **Builds:** `run.sh`. Each brief twice with the skill (in the project's
  `.claude/skills/`) and twice without, with Claude Code (`claude -p`), the same
  model, tools and kickoff prompt, capped at $6 a build. All four "with" builds
  loaded the skill.
- **Checks:** `eval.sh` installs and starts each app, screenshots it and records
  objective facts. All 8 installed, served and called the sponsor's API live.
- **Judging:** `judge.sh`. Per brief, a judge (Claude, read-only tools) scores the
  four submissions on the criteria, relabeled P1-P4 in random order with the
  skill's folder removed; a second judge sees them in reverse order.

## Results

| Brief | Build | Skill | Judge 1 | Judge 2 | Average |
|---|---|---|---|---|---|
| Weather | PourWindow | with | 78.5 | 85 | 81.8 |
| Weather | Driftless | with | 79 | 79 | 79.0 |
| Weather | Slabcast | without | 80 | 80 | 80.0 |
| Weather | Slabcast | without | 77 | 78.5 | 77.8 |
| Books | Free Period | with | 77.5 | 80 | 78.8 |
| Books | Syllabus Zero | with | 79.5 | 73.5 | 76.5 |
| Books | Free Period | without | 83.5 | 82.5 | 83.0 |
| Books | Dogear | without | 71 | 72.5 | 71.8 |

With the skill: 79.0 on average. Without: 78.1. Per criterion (out of 10), with
vs without: impact 7.9 vs 7.6, technical 7.4 vs 7.5, sponsor 8.4 vs 8.1, design
7.9 vs 7.8, presentation 8.1 vs 8.4. All within the judges' own disagreement.
The builds with the skill cost about 7% less and took about 7% less time, which
is also too small to rely on.

What this doesn't test: working with a person in the loop over many turns,
which is where the skill's style (self-rating, numbered fixes, "proceed")
shows. Eight builds and two briefs is small; a real effect smaller than ~5
points wouldn't show up here.

Total cost: $34.02 ($28.85 builds, $5.17 judging).

The test ran on the first draft of the skill. The published `SKILL.md` is that
draft trimmed: the same method, with generic advice (ship early, use real data,
deploy in the first hour) taken out, since agents already do it.
