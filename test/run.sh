#!/bin/bash
# Does build-like-petros help? Same brief, same model and tools; the "with" arm
# has the skill in the project. 2 briefs x 2 arms x 2 runs.
AB=$1; SKILL=$2
TOOLS=("Write" "Edit" "Read" "Glob" "Grep" "Bash(node:*)" "Bash(npm:*)" "Bash(npx:*)" "Bash(ls:*)" "Bash(cat:*)" "Bash(mkdir:*)" "Bash(curl:*)" "WebFetch" "Skill")
JUDGING='Judging: Impact 25%, Technical execution 25%, Use of the sponsor'"'"'s tech 25%, Design & UX 15%, Presentation 10% (a README with a 3-sentence pitch and a demo script). Submission: it must run with `npm install && npm start` and serve on PORT (default 3000).'
WEATHER="Sponsor track: Best use of Open-Meteo (a free weather API, no key needed: https://open-meteo.com/en/docs). Build a web app that helps a specific group of people make a real decision with weather data. $JUDGING"
BOOKS="Sponsor track: Best use of Open Library (a free books API, no key needed: https://openlibrary.org/developers/api). Build a web app for students or readers. $JUDGING"
one() { local name=$1 arm=$2 brief=$3
  local dir=$AB/$name-$arm; rm -rf $dir && mkdir -p $dir && cd $dir && git init -q
  if [ $arm = with ]; then mkdir -p .claude/skills/build-like-petros && cp $SKILL .claude/skills/build-like-petros/SKILL.md; fi
  claude -p "We're at a hackathon. Here's the brief:

$brief

Build our project in this folder. We have about two hours, so make the calls on what to build and get it done." \
    --strict-mcp-config --allowedTools "${TOOLS[@]}" --max-budget-usd 6 --output-format json > $dir.json 2>$dir.err
}
for r in 1 2; do
  one weather$r with "$WEATHER" & one weather$r without "$WEATHER" &
  one books$r with "$BOOKS" & one books$r without "$BOOKS" &
  wait
done
echo builds done
