#!/bin/bash
# Each build: does it install and run, what it shows, and the objective facts.
AB=$1; CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; port=4100
for dir in $AB/*-with $AB/*-without; do
  n=$(basename $dir); port=$((port+1)); out=$AB/$n.eval; : > $out
  ( cd $dir && npm install --silent >/dev/null 2>&1; echo "install=$?" >> $out )
  ( cd $dir && PORT=$port npm start > $AB/$n.server.log 2>&1 & echo $! > $AB/$n.pid )
  code=000; for i in $(seq 1 30); do code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 2 http://localhost:$port/); [ "$code" = 200 ] && break; sleep 1; done
  echo "http=$code" >> $out
  [ "$code" = 200 ] && "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1280,1800 --virtual-time-budget=12000 --screenshot=$AB/$n.png http://localhost:$port/ >/dev/null 2>&1
  pkill -P $(cat $AB/$n.pid) 2>/dev/null; kill $(cat $AB/$n.pid) 2>/dev/null; lsof -ti tcp:$port | xargs kill 2>/dev/null
  src=$(cd $dir && find . -path ./node_modules -prune -o -path ./.git -prune -o -path ./.claude -prune -o -type f \( -name '*.js' -o -name '*.mjs' -o -name '*.ts' -o -name '*.html' -o -name '*.jsx' -o -name '*.tsx' \) -print)
  echo "files=$(echo "$src" | grep -c .)" >> $out
  echo "lines=$(cd $dir && cat $src 2>/dev/null | wc -l | tr -d ' ')" >> $out
  echo "sponsor_calls=$(cd $dir && cat $src 2>/dev/null | grep -oE 'open-meteo\.com|openlibrary\.org|covers\.openlibrary' | wc -l | tr -d ' ')" >> $out
  echo "mock_words=$(cd $dir && cat $src 2>/dev/null | grep -ciE 'mock|fake data|dummy|placeholder data|sample data|hardcoded')" >> $out
  echo "readme=$([ -f $dir/README.md ] && wc -w < $dir/README.md | tr -d ' ' || echo 0)" >> $out
  echo "tests=$(cd $dir && find . -path ./node_modules -prune -o -type f \( -name '*.test.*' -o -path '*/test/*' \) -print | grep -c .)" >> $out
  python3 -c "import json;d=json.load(open('$AB/$n.json'));print('cost=%.2f turns=%s mins=%.1f skill_used=%s'%(d.get('total_cost_usd',0),d.get('num_turns'),d.get('duration_ms',0)/60000,'?'))" >> $out 2>/dev/null
done
echo eval done
