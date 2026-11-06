# Setup

Creates `recon/config.md` from `templates/config.template.md` in a short dialogue. Ask only for what's missing, and work out everything you can yourself.

## 1. Ask

In one message, ask for:

1. **Your company** (name and website), so the digest can say what a change means for you.
2. **Competitors:** names or websites, up to 10. If they're not sure, offer to suggest five from their own site and category, and let them pick.
3. **What you care about most**, in a line. For example "pricing and anything AI", "UK expansion", "enterprise features". This decides what ranks highest.

## 2. Discover sources

For each competitor, find its sources yourself before asking anything else. Work through them in this order and stop early once each is found:

| Source | How to find it |
|---|---|
| Homepage | The domain itself |
| Pricing | `/pricing`, `/plans`, or a "Pricing" link in the homepage navigation |
| Changelog | `/changelog`, `/releases`, `/whats-new`, `/updates`, or a "Changelog" link in the footer. Note an RSS or Atom feed if the page links one |
| Blog | `/blog`, `/news`, `/resources`. Look for a feed: `/blog/rss`, `/feed`, `/rss.xml`, or a `<link rel="alternate" type="application/rss+xml">` on the page |
| Sitemap | Try `scripts/sitemap-urls.sh <domain>` once. Note whether it works |
| Jobs | The careers page. If it links to `boards.greenhouse.io/<slug>`, `jobs.lever.co/<slug>`, `jobs.ashbyhq.com/<slug>` or `apply.workable.com/<slug>`, note the system and slug and test `scripts/jobs.sh <system> <slug>` |

Run discovery for all competitors in parallel, one agent each, following `rules.md`.

## 3. Confirm

Show one compact table (competitor, then ✓ or ✗ per source, with the URL) and ask the user to confirm or correct it. Then ask where the digest should go:

- **A file only** (default): saved in `recon/digests/`.
- **Slack:** find their channels with the Slack connector and let them pick one. Ask whether later runs may post there without asking each time (`slack_auto_post: yes`). Scheduled runs can only post if they say yes.

Write `recon/config.md` and say which file it is. Suggest adding `recon/` to `.gitignore` if the folder is inside a public repo.

## Changing config later

"Add X", "stop watching Y", "also track their docs", "send it to #product instead": edit only the affected block of `recon/config.md` and confirm the change in one line. Keep old snapshots when a competitor is removed, unless the user asks to delete them.
