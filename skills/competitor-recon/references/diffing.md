# Diffing

Compare each source's newest snapshot with the one before it, drop what doesn't matter, and turn what's left into **signals**. A signal is one real change, stated as a fact, with its evidence.

## Noise to ignore

- Dates, copyright years, "updated x days ago", counters and live stats.
- Wording tweaks that don't change meaning (a comma, "Get started" → "Get Started").
- Reordering of logos, testimonials or blog cards.
- Sitemap URLs that only differ by tracking parameters, trailing slashes or locale copies of an existing page (`/de/`, `/fr/`) unless a whole new locale appears.
- Tag, author, pagination and search-result pages in sitemaps (`/tag/`, `/author/`, `/page/2`).

## What counts as a signal

| Source | Signal | Importance |
|---|---|---|
| pricing | A price went up or down, a plan was added, removed or renamed, a limit changed, the free plan or trial changed, the highlighted plan changed, a feature moved between plans | **High** |
| homepage | New headline or subheadline (a positioning change), a new primary call to action (for example "Start free" → "Book a demo", which hints at a move upmarket), a new navigation item, new proof (a big-name logo, a new headline stat) | High for headline and call to action, Medium otherwise |
| changelog | A new entry | Medium. **High** if it overlaps with what the user cares about (config `focus`) or with their own product |
| blog | A new post | Low. Medium if it announces something (a launch, funding, a partnership, a new market) |
| sitemap | New pages. Group them by path (`/integrations/` +4, `/compare/` +2) and name the interesting ones. New `/compare/<you>` or `/vs/<you>` pages are always **High**. Removed pages matter only in groups (a whole section gone) | Medium, High as noted |
| jobs | Change in total open roles of 20% or more, a new department hiring, a new location (a market entry), or senior roles (Head of, VP, Director, Chief) | Medium. **High** for a new country or a first senior hire in a new function |

Raise any signal one level if it touches the user's `focus` line in config. Never raise more than one level.

## Writing a signal

One line of fact, then an optional "Read:" line of interpretation, then the evidence:

```
Pro plan up from £49 to £59 a month (billed yearly). Starter unchanged.
  Read: first price rise in the snapshots we have, and it lands a month after their "Workflows AI" launch.
  Evidence: https://rival.com/pricing · seen 2026-11-09, previously 2026-11-02
```

- Facts use the snapshot's exact numbers and words.
- "Read:" is short, plainly an interpretation, and says what it means **for the user's company** when there's a clear link. Skip it if there isn't one.
- When a change could be a measurement error (a page that loaded half-empty, a sitemap that shrank by 90%), refetch once. If it's still odd, report it as "Couldn't confirm" in the footer, not as a signal.

## Ranking

Sort all signals across all competitors by importance (High, Medium, Low), then by competitor in config order. Cap the digest at the 10 most important signals, and list how many lower ones were left out ("+7 low-importance changes in the saved snapshots").
