#!/usr/bin/env bash
# Recon job-board reader. Lists a company's open roles from its applicant
# tracking system's public job-board API, as tab-separated lines:
#   title <TAB> department <TAB> location <TAB> url
#
# Usage: jobs.sh <greenhouse|lever|ashby|workable> <board-slug>
#
# The slug is the company's name in its job-board URL, for example
# boards.greenhouse.io/<slug>, jobs.lever.co/<slug>, jobs.ashbyhq.com/<slug>,
# apply.workable.com/<slug>. Public endpoints only. No names of people are kept.

set -u
ats="${1:-}"
slug="${2:-}"
if [ -z "$ats" ] || [ -z "$slug" ]; then
  echo "usage: jobs.sh <greenhouse|lever|ashby|workable> <board-slug>" >&2
  exit 2
fi
UA="Mozilla/5.0 (compatible; Recon/0.1; +https://github.com/Pilotree-ai/recon)"

case "$ats" in
  greenhouse) url="https://boards-api.greenhouse.io/v1/boards/$slug/jobs" ;;
  lever)      url="https://api.lever.co/v0/postings/$slug?mode=json" ;;
  ashby)      url="https://api.ashbyhq.com/posting-api/job-board/$slug" ;;
  workable)   url="https://apply.workable.com/api/v1/widget/accounts/$slug" ;;
  *) echo "unknown ATS: $ats (use greenhouse, lever, ashby or workable)" >&2; exit 2 ;;
esac

body=$(curl -sL --compressed --max-time 20 -A "$UA" "$url")
if [ -z "$body" ]; then
  echo "NO_RESPONSE: $url" >&2
  exit 1
fi

printf '%s' "$body" | python3 -I -c '
import json, sys
ats = sys.argv[1]
try:
    data = json.load(sys.stdin)
except Exception:
    sys.stderr.write("NOT_JSON: board not found or blocked\n"); sys.exit(1)

def clean(v):
    return " ".join(str(v or "").split())

rows = []
if ats == "greenhouse":
    for j in data.get("jobs", []):
        dept = ", ".join(d.get("name", "") for d in j.get("departments", []) or [])
        rows.append((j.get("title"), dept, (j.get("location") or {}).get("name"), j.get("absolute_url")))
elif ats == "lever":
    for j in data if isinstance(data, list) else []:
        c = j.get("categories") or {}
        rows.append((j.get("text"), c.get("team") or c.get("department"), c.get("location"), j.get("hostedUrl")))
elif ats == "ashby":
    for j in data.get("jobs", []):
        rows.append((j.get("title"), j.get("department") or j.get("team"), j.get("location"), j.get("jobUrl")))
elif ats == "workable":
    for j in data.get("jobs", []):
        loc = ", ".join(x for x in (j.get("city"), j.get("country")) if x)
        rows.append((j.get("title"), j.get("department"), loc, j.get("url") or j.get("shortlink")))

for r in sorted(rows, key=lambda r: (clean(r[1]), clean(r[0]))):
    print("\t".join(clean(x) for x in r))
sys.stderr.write("JOBS: %d\n" % len(rows))
' "$ats"
