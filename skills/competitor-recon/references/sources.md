# Sources

How to collect each source and what to save. Save each one to `recon/snapshots/<competitor-slug>/<source>/<YYYY-MM-DD>.md`. Snapshots must be **stable**: the same page should produce the same snapshot on two runs if nothing real changed. So save cleaned, structured content, never raw HTML.

Fetch pages with the web-fetch tool, asking it to return exactly the fields below. Use the scripts for sitemaps and job boards.

## pricing

Save as a table, one row per plan, plans in the order the page shows them:

```
| Plan | Price | Billing | Who it's for | Key limits | Highlighted |
|---|---|---|---|---|---|
| Starter | £29 | per month, billed yearly | solo | 1 user, 1,000 contacts | |
| Pro | £79 | per month, billed yearly | teams | 5 users, unlimited contacts | ✓ (Most popular) |
| Enterprise | Contact sales | | | SSO, audit log | |
```

Below the table: a free trial or free plan (and its length), a money-back guarantee, the currency and whether there's a monthly/yearly toggle, and the full feature list per plan as bullets. If prices differ by region, save what the page shows by default and note the region.

## homepage

```
Headline: <the main H1>
Subheadline: <the line under it>
Primary call to action: <button text> → <link>
Secondary call to action: <button text> → <link>
Navigation: <top-level menu items, in order>
Proof: <customer logos named, headline stats like "10,000 teams">
Sections: <each section heading, in order>
```

Leave out cookie banners, testimonials that rotate, and anything else that changes on every load.

## changelog and blog

Prefer the RSS or Atom feed when config has one: it's lighter and has exact dates. Save one line per entry, newest first, up to the 30 most recent:

```
- 2026-11-04 · Introducing Workflows AI · https://rival.com/changelog/workflows-ai
```

If there's no feed, read the page and save the same format. If entries have no dates, write `undated` and keep the order the page shows.

## sitemap

Run `scripts/sitemap-urls.sh <domain>` and save its output as is, one URL per line. If it prints `NO_SITEMAP`, record the source as `not found` and don't save a file. If it prints `TRUNCATED`, note that in the snapshot's first line.

## jobs

Run `scripts/jobs.sh <system> <slug>` and save its output under a summary header:

```
Open roles: 23
By department: Engineering 9 · Sales 6 · Marketing 3 · Customer Success 3 · Other 2
By location: London 8 · Remote (UK) 6 · New York 5 · Berlin 4

<the script's tab-separated lines, as is>
```

If the company has no supported job board, read its careers page instead and save the same format (titles, departments and locations only, never people's names). `JOBS: 0` can mean a wrong slug: check the careers page once before recording zero.

## extra pages

Config may list extra pages (a docs page, an integrations page, a comparison page). Save the page's headings and the text under each, as bullet points, without navigation or footer.
