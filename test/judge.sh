#!/bin/bash
# Blind judging: each brief's 4 submissions as P1..P4 in random order, the
# skill's folder removed; two judges per brief, the second in reverse order.
AB=$1
for brief in weather books; do
  for j in 1 2; do
    J=$AB/judge-$brief-$j; rm -rf $J && mkdir -p $J
    subs=($(ls -d $AB/$brief?-with $AB/$brief?-without | python3 -c "import sys,random;l=sys.stdin.read().split();random.seed($RANDOM);random.shuffle(l);print(' '.join(l))"))
    [ $j = 2 ] && subs=($(awk '{print $2}' $AB/key-$brief-1.txt | tail -r))
    i=0; : > $J/key.txt
    for s in "${subs[@]}"; do i=$((i+1))
      rsync -a --exclude node_modules --exclude .git --exclude .claude --exclude package-lock.json $s/ $J/P$i/
      [ -f $s.png ] && cp $s.png $J/P$i-screenshot.png
      cp $s.eval $J/P$i-run.txt 2>/dev/null; sed -i '' '/^cost=/d' $J/P$i-run.txt 2>/dev/null
      echo "P$i $s" >> $J/key.txt
    done
    mv $J/key.txt $AB/key-$brief-$j.txt
    (cd $J && claude -p "You are judging a hackathon. The brief the teams got: $(grep -m1 "^$( [ $brief = weather ] && echo WEATHER || echo BOOKS )=" $AB/run.sh | cut -d'"' -f2 | sed 's/\$JUDGING/see the weights below/')

Weights: Impact 25, Technical execution 25, Use of the sponsor's tech 25, Design & UX 15, Presentation 10 (README pitch and demo script).

There are four submissions here: folders P1 to P4. For each, PN-screenshot.png is its home page as served (none means it didn't serve), and PN-run.txt has facts from running it (http=200 means it served). Read the code, the README and the screenshot of each. Judge only what was built and what works, not what the README claims.

Score each submission 1-10 on each criterion, compute the weighted total out of 100, and rank them. Be strict and specific: 2-3 lines of reasons each. End with exactly one line per submission in this form: SCORE PN <total>" \
      --strict-mcp-config --allowedTools Read Glob Grep --max-budget-usd 4 --output-format json > $AB/judge-$brief-$j.json 2>&1) &
  done
done
wait; echo judging done
