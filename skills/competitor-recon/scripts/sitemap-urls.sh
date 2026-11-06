#!/usr/bin/env bash
# Recon sitemap reader. Prints every page URL a site lists in its sitemaps,
# sorted and de-duplicated, so two runs can be diffed for new and removed pages.
#
# Usage: sitemap-urls.sh <domain> [max-urls]
#
# Reads robots.txt for Sitemap: lines, falls back to /sitemap.xml and
# /sitemap_index.xml, follows sitemap indexes two levels deep, and handles .gz.
# Public files only, one request at a time, with a polite user agent.

set -u
domain="${1:-}"
max="${2:-5000}"
if [ -z "$domain" ]; then
  echo "usage: sitemap-urls.sh <domain> [max-urls]" >&2
  exit 2
fi
domain=$(printf '%s' "$domain" | sed -e 's#^https\{0,1\}://##' -e 's#/.*##')
UA="Mozilla/5.0 (compatible; Recon/0.1; +https://github.com/Pilotree-ai/recon)"

fetch() {
  local url=$1
  case "$url" in
    *.gz) curl -sL --max-time 20 -A "$UA" "$url" | gunzip -c 2>/dev/null ;;
    *)    curl -sL --compressed --max-time 20 -A "$UA" "$url" ;;
  esac
  sleep 1
}
locs() { tr '<' '\n' | grep -i '^loc>' | sed -e 's/^[Ll][Oo][Cc]>//' -e 's/&amp;/\&/g' | tr -d ' \r'; }

roots=$(fetch "https://$domain/robots.txt" | tr -d '\r' | grep -i '^sitemap:' | sed 's/^[Ss]itemap: *//')
[ -z "$roots" ] && roots="https://$domain/sitemap.xml https://$domain/sitemap_index.xml"

pages=""
queue="$roots"
depth=0
seen=" "
while [ -n "$queue" ] && [ "$depth" -lt 3 ]; do
  next=""
  for sm in $queue; do
    case "$seen" in *" $sm "*) continue ;; esac
    seen="$seen$sm "
    body=$(fetch "$sm")
    printf '%s' "$body" | grep -qi '<sitemapindex' \
      && next="$next $(printf '%s' "$body" | locs)" \
      || pages="$pages
$(printf '%s' "$body" | locs)"
  done
  queue="$next"
  depth=$((depth+1))
done

out=$(printf '%s\n' "$pages" | grep -E '^https?://' | sort -u)
count=$(printf '%s\n' "$out" | grep -c .)
if [ "$count" -eq 0 ]; then
  echo "NO_SITEMAP: $domain" >&2
  exit 1
fi
printf '%s\n' "$out" | head -n "$max"
[ "$count" -gt "$max" ] && echo "TRUNCATED: $count urls, showing $max" >&2
exit 0
